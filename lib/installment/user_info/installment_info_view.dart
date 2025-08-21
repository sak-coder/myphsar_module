import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';
import 'package:myphsar/base_widget/snack_bar_message.dart';
import 'package:myphsar/installment/submit_installment_body.dart';
import 'package:myphsar/installment/id/id_card_detail_view.dart';

import '../../base_colors.dart';
import '../../base_widget/alert_dialog_view.dart';
import '../../base_widget/custom_decoration.dart';
import '../../base_widget/custom_icon_button.dart';
import '../../base_widget/input_text_field_custom.dart';
import '../../base_widget/input_text_field_icon.dart';
import '../../base_widget/reload_button.dart';
import '../../helper/share_pref_controller.dart';
import '../installment_view_controller.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class InstallmentInfoView extends StatefulWidget {
  final String productId;

  const InstallmentInfoView(this.productId, {super.key});

  @override
  State<InstallmentInfoView> createState() => _InstallmentInfoViewState();
}

enum PickerType { jobType, provinceCity, duration }

class _InstallmentInfoViewState extends State<InstallmentInfoView> {
  var fullNameForm = GlobalKey<FormState>();
  var ageForm = GlobalKey<FormState>();
  var emailForm = GlobalKey<FormState>();
  var phoneForm = GlobalKey<FormState>();
  var jobForm = GlobalKey<FormState>();
  var salaryForm = GlobalKey<FormState>();
  var provinceCityForm = GlobalKey<FormState>();
  var jobTypeForm = GlobalKey<FormState>();
  var durationForm = GlobalKey<FormState>();
  var referenceForm = GlobalKey<FormState>();
  var referenceContactForm = GlobalKey<FormState>();

  var fullNameController = TextEditingController();
  var ageController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var jobController = TextEditingController();
  var salaryController = TextEditingController();
  var provinceCityController = TextEditingController();
  var provinceCityId;
  var jobTypeController = TextEditingController();
  var jobTypeId;
  var durationController = TextEditingController();
  var durationId;
  var referenceController = TextEditingController();
  var referenceContactController = TextEditingController();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    await Get.find<InstallmentViewController>().getInstallmentInfoData();
  }

  void pickDialog(List<dynamic> list, PickerType type) {
    alertDialogWidgetView(
      context: context,
      widget: Wrap(children: [
        Container(
          constraints: const BoxConstraints(
            maxHeight: 500,
          ),
          child: list.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.only(top: 2, right: 2, left: 2),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        decoration: customDecoration(radius: 10, shadowBlur: 2),
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        padding: const EdgeInsets.only(left: 10),
                        child: Material(
                            color: ColorResource.whiteColor,
                            child: InkWell(
                              onTap: () async {
                                Navigator.pop(context);
                                switch (type) {
                                  case PickerType.provinceCity:
                                    provinceCityController.text = list[index].name.toString();
                                    provinceCityId = list[index].id.toString();
                                    break;
                                  case PickerType.duration:
                                    durationController.text = list[index].title.toString();
                                    durationId = list[index].id.toString();
                                    break;
                                  case PickerType.jobType:
                                    jobTypeController.text = list[index].jobTitle.toString();
                                    jobTypeId = list[index].id.toString();
                                    break;
                                }
                                // Get.to(PaymentTableView());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                                    child: PickerType.duration == type
                                        ? textView15(context: context, text: list[index].title.toString(), maxLine: 2)
                                        : PickerType.provinceCity == type
                                            ? textView15(
                                                context: context, text: list[index].name.toString(), maxLine: 2)
                                            : textView15(
                                                context: context, text: list[index].jobTitle.toString(), maxLine: 2),
                                  )),
                                ],
                              ),
                            )));
                  })
              : onErrorReloadButton(context, "", height: 200, onTap: () {
                  initData();
                  Navigator.pop(context);
                }),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(context: context, titleText: "installment_info".tr),
      body: Get.find<InstallmentViewController>().obx(
        (state) => Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textView20(context: context, text: "fill_your_info".tr),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        child: InputTextFieldCustom(
                            controller: fullNameController, formKey: fullNameForm, hintTxt: "user_name".tr),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: InputTextFieldCustom(
                            inputType: TextInputType.number,
                            controller: ageController,
                            formKey: ageForm,
                            hintTxt: "age_no:".tr),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InputTextFieldCustom(controller: emailController, formKey: emailForm, hintTxt: "email1".tr),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InputTextFieldCustom(
                      inputType: TextInputType.phone,
                      controller: phoneController,
                      formKey: phoneForm,
                      hintTxt: "phone_number1".tr),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10),
                        child: InputTextFieldCustom(controller: jobController, formKey: jobForm, hintTxt: "job".tr),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: InputTextFieldCustom(
                            inputType: TextInputType.number,
                            controller: salaryController,
                            formKey: salaryForm,
                            hintTxt: "salary1".tr),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InputTextFieldWithIcon(
                      controller: provinceCityController,
                      readonly: true,
                      onTap: () {
                        pickDialog(
                            Get.find<InstallmentViewController>().getProvinceCityModelList, PickerType.provinceCity);
                      },
                      maxIconWidth: Get.find<SharePrefController>().getLocalLanguage().languageCode == 'en' ? 118 : 80,
                      imageIcon: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 1),
                            child: Center(
                                child: textView14(
                              color: ColorResource.hintTextColor,
                              fontWeight: FontWeight.w500,
                              context: context,
                              textAlign: TextAlign.center,
                              text: "province_city1".tr,
                              //   text: "ខេត្ត/ក្រុង",
                            )),
                          ),
                          Container(
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              height: 30,
                              width: 1,
                              color: ColorResource.hintTextColor),
                        ],
                      ),
                      formKey: provinceCityForm,
                      hintTxt: "select_p_c".tr),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InputTextFieldWithIcon(
                      controller: jobTypeController,
                      readonly: true,
                      onTap: () {
                        pickDialog(Get.find<InstallmentViewController>().getJobModelList, PickerType.jobType);
                      },
                      maxIconWidth: Get.find<SharePrefController>().getLocalLanguage().languageCode == 'en' ? 87 : 105,
                      imageIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 1),
                            child: Center(
                                child: textView14(
                              color: ColorResource.hintTextColor,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                              context: context,
                              text: "job_type".tr,
                              //      ប្រភេទការងារ
                            )),
                          ),
                          Container(
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              height: 30,
                              width: 1,
                              color: ColorResource.hintTextColor),
                        ],
                      ),
                      formKey: jobTypeForm,
                      hintTxt: "select_job_type".tr),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: InputTextFieldWithIcon(
                      controller: durationController,
                      readonly: true,
                      onTap: () {
                        pickDialog(Get.find<InstallmentViewController>().getDurationModelList, PickerType.duration);
                      },
                      maxIconWidth: Get.find<SharePrefController>().getLocalLanguage().languageCode == 'en' ? 87 : 105,
                      imageIcon: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Center(
                                child: textView14(
                              color: ColorResource.hintTextColor,
                              fontWeight: FontWeight.w500,
                              context: context,
                              text: "duration".tr,
                              // text: "រយៈពេល",
                            )),
                          ),
                          Container(
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              height: 30,
                              width: 1,
                              color: ColorResource.hintTextColor),
                        ],
                      ),
                      formKey: durationForm,
                      hintTxt: "select_duration".tr),
                ),
                textView20(context: context, text: "ref_person".tr),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InputTextFieldCustom(
                      controller: referenceController, formKey: referenceForm, hintTxt: "ref_name".tr),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InputTextFieldCustom(
                      textInputAction: TextInputAction.done,
                      inputType: TextInputType.phone,
                      controller: referenceContactController,
                      formKey: referenceContactForm,
                      hintTxt: "phone_number1".tr),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: customTextButton(
                    blur: 0,
                    height: 50,
                    radius: 5,
                    color: ColorResource.primaryColor,
                    onTap: () async {
                      fullNameForm.currentState!.validate();
                      ageForm.currentState!.validate();
                      emailForm.currentState!.validate();
                      phoneForm.currentState!.validate();
                      jobForm.currentState!.validate();
                      salaryForm.currentState!.validate();
                      provinceCityForm.currentState!.validate();
                      jobTypeForm.currentState!.validate();
                      durationForm.currentState!.validate();
                      referenceForm.currentState!.validate();
                      referenceContactForm.currentState!.validate();

                      var name = fullNameController.text.trim();
                      var age = ageController.text.trim();
                      var email = emailController.text.trim();
                      var phone = phoneController.text.trim();
                      var job = jobController.text.trim();
                      var salary = salaryController.text.trim();
                      var city = provinceCityController.text.trim();
                      var jobType = jobTypeController.text.trim();
                      var duration = durationController.text.trim();
                      var refName = referenceController.text.trim();
                      var refContact = referenceContactController.text.trim();

                      if (name.isNotEmpty &&
                          age.isNotEmpty &&
                          email.isNotEmpty &&
                          phone.isNotEmpty &&
                          job.isNotEmpty &&
                          salary.isNotEmpty &&
                          city.isNotEmpty &&
                          jobType.isNotEmpty &&
                          duration.isNotEmpty &&
                          refName.isNotEmpty &&
                          refContact.isNotEmpty) {
                        if (email.isValidEmail()) {
                          SubmitInstallmentBody submitModel =
                              Get.find<InstallmentViewController>().getSubmitInstallmentBody;

                          submitModel.productId = widget.productId;
                          submitModel.fullName = name;
                          submitModel.age = age;
                          submitModel.email = email;
                          submitModel.phone = phone;
                          submitModel.jobPosition = job;
                          submitModel.salary = salary;
                          submitModel.cityId = provinceCityId;
                          submitModel.jobTypeId = jobTypeId;
                          submitModel.installDurationId = durationId;
                          submitModel.refName = refName;
                          submitModel.refPhone = refContact;

                          // await Get.find<InstallmentViewController>().setUserInstallmentsInfo(SubmitInstallmentBody(
                          //     productId: widget.productId,
                          //     fullName: name,
                          //     age: age,
                          //     email: email,
                          //     phone: phone,
                          //     jobPosition: job,
                          //     salary: salary,
                          //     cityId: cityId,
                          //     jobTypeId: jobId,
                          //     installDurationId: durId,
                          //     refName: refName,
                          //     refPhone: refContact));

                          Get.to(const IdCartDetailView());
                        } else {
                          snackBarMessage(context, "invalid_email".tr);
                        }
                      }
                    },
                    text: Center(
                      child: textView15(
                          context: context,
                          text: "next".tr,
                          color: ColorResource.whiteColor,
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onError: (s) =>
            onErrorReloadButton(context, s.toString(), height: MediaQuery.of(context).size.height, onTap: () {
          initData();
        }),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      //   child: CustomTextButton(
      //     blur: 0,
      //     height: 50,
      //     radius: 5,
      //     color: ColorResource.primaryColor,
      //     onTap: () async {
      //       fullNameForm.currentState!.validate();
      //       ageForm.currentState!.validate();
      //       emailForm.currentState!.validate();
      //       phoneForm.currentState!.validate();
      //       jobForm.currentState!.validate();
      //       salaryForm.currentState!.validate();
      //       provinceCityForm.currentState!.validate();
      //       jobTypeForm.currentState!.validate();
      //       durationForm.currentState!.validate();
      //       referenceForm.currentState!.validate();
      //       referenceContactForm.currentState!.validate();
      //
      //       var name = fullNameController.text.trim();
      //       var age = ageController.text.trim();
      //       var email = emailController.text.trim();
      //       var phone = phoneController.text.trim();
      //       var job = jobController.text.trim();
      //       var salary = salaryController.text.trim();
      //       var city = provinceCityController.text.trim();
      //       var jobType = jobTypeController.text.trim();
      //       var duration = durationController.text.trim();
      //       var refName = referenceController.text.trim();
      //       var refContact = referenceContactController.text.trim();
      //
      //       if (name.isNotEmpty &&
      //           age.isNotEmpty &&
      //           email.isNotEmpty &&
      //           phone.isNotEmpty &&
      //           job.isNotEmpty &&
      //           salary.isNotEmpty &&
      //           city.isNotEmpty &&
      //           jobType.isNotEmpty &&
      //           duration.isNotEmpty &&
      //           refName.isNotEmpty &&
      //           refContact.isNotEmpty) {
      //         SubmitInstallmentBody submitModel = Get.find<InstallmentViewController>().getSubmitInstallmentBody;
      //
      //         submitModel.productId = widget.productId;
      //         submitModel.fullName = name;
      //         submitModel.age = age;
      //         submitModel.email = email;
      //         submitModel.phone = phone;
      //         submitModel.jobPosition = job;
      //         submitModel.salary = salary;
      //         submitModel.cityId = provinceCityId;
      //         submitModel.jobTypeId = jobTypeId;
      //         submitModel.installDurationId = durationId;
      //         submitModel.refName = refName;
      //         submitModel.refPhone = refContact;
      //
      //         // await Get.find<InstallmentViewController>().setUserInstallmentsInfo(SubmitInstallmentBody(
      //         //     productId: widget.productId,
      //         //     fullName: name,
      //         //     age: age,
      //         //     email: email,
      //         //     phone: phone,
      //         //     jobPosition: job,
      //         //     salary: salary,
      //         //     cityId: cityId,
      //         //     jobTypeId: jobId,
      //         //     installDurationId: durId,
      //         //     refName: refName,
      //         //     refPhone: refContact));
      //
      //         Get.to(IdCartDetailView());
      //       }
      //     },
      //     text: Center(
      //       child: TextViewSize_15(
      //           context: context, text: "next".tr, color: ColorResource.whiteColor, textAlign: TextAlign.center),
      //     ),
      //   ),
      // ),
    );
  }
}
