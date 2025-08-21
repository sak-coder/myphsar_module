import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_bottom_sheet_dialog.dart';
import 'package:myphsar/base_widget/custom_decoration.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/base_widget/loader_view.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';
import 'package:myphsar/base_widget/snack_bar_message.dart';
import 'package:myphsar/installment/installment_view_controller.dart';
import 'package:myphsar/installment/payment_table/payment_table_view.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../base_colors.dart';
import '../../base_widget/custom_icon_button.dart';
import '../../base_widget/input_text_field_custom.dart';
import '../../base_widget/input_text_field_icon.dart';
import '../submit_installment_body.dart';
import 'take_photo_view.dart';

class IdCartDetailView extends StatefulWidget {
  const IdCartDetailView({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<IdCartDetailView> createState() => _IdCartDetailViewState();
}

class _IdCartDetailViewState extends State<IdCartDetailView> with RestorationMixin, TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool toggleButton = false;

  @override
  String? get restorationId => widget.restorationId;
  var idNumberForm = GlobalKey<FormState>();
  var addressForm = GlobalKey<FormState>();

  // var fullName = GlobalKey<FormState>();
  var dobForm = GlobalKey<FormState>();
  var genderForm = GlobalKey<FormState>();
  var homeNumberForm = GlobalKey<FormState>();
  var stNumberForm = GlobalKey<FormState>();

  var permanenceAddress = GlobalKey<FormState>();
  var idNumberController = TextEditingController();
  var addressController = TextEditingController();

  // var fullNameController = TextEditingController();
  var dobController = TextEditingController();
  var genderController = TextEditingController();
  var homeNumberController = TextEditingController();
  var stNumberController = TextEditingController();
  var permanenceAddressController = TextEditingController();

  // var file = File('');
  // final picker = ImagePicker();

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime(1990, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture = RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          initialCalendarMode: DatePickerMode.day,
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendar,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(1900),
          lastDate: DateTime(2023),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(_restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  @override
  void initState() {
    Get.find<InstallmentViewController>().resetData();

    _controller = AnimationController(
      duration: const Duration(microseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInToLinear,
    );

    super.initState();
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        var selectDob = '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
        dobController.text = selectDob;
        snackBarMessage(context,
            '${'selected'.tr}${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}',
            bgColor: Colors.green);
      });
    }
  }

  void availableLenderList(String uuid) {
    customBottomSheetDialogWrap(
        context: context,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Wrap(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textView20(context: context, text: 'available_lender'.tr),
                customImageButton(
                    padding: 3,
                    height: 30,
                    width: 30,
                    icon: const Icon(Icons.clear),
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
            Container(
                constraints: const BoxConstraints(maxHeight: 400),
                child: Obx(
                  () => Get.find<InstallmentViewController>().getAvailableLenderList.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.only(top: 10),
                          shrinkWrap: true,
                          itemCount: Get.find<InstallmentViewController>().getAvailableLenderList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                decoration: customDecoration(radius: 10, shadowBlur: 2),
                                margin: const EdgeInsets.only(top: 5, bottom: 5),
                                padding: const EdgeInsets.all(10),
                                child: Material(
                                    color: ColorResource.whiteColor,
                                    child: InkWell(
                                      onTap: () async {
                                        // Navigator.pop(context);
                                        Get.to(PaymentTableView(
                                            uuid,
                                            Get.find<InstallmentViewController>()
                                                .getAvailableLenderList[index]
                                                .id
                                                .toString()));
                                      },
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                child: FadeInImage.assetNetwork(
                                                  placeholder: "assets/images/placeholder_img.png",
                                                  fit: BoxFit.fill,
                                                  image: Get.find<InstallmentViewController>()
                                                      .getAvailableLenderList[index]
                                                      .avatar
                                                      .toString(),
                                                  // image: '${Get.find<ConfigController>().configModel.baseUrls?.baseShopImageUrl}/' +
                                                  //     widget.sellerModel.image.toString(),
                                                  width: 50,
                                                  height: 50,
                                                  imageErrorBuilder: (c, o, s) => Image.asset(
                                                    "assets/images/placeholder_img.png",
                                                    fit: BoxFit.fill,
                                                    height: 50,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(bottom: 5, left: 5),
                                                    child: textView15(
                                                        context: context,
                                                        text: Get.find<InstallmentViewController>()
                                                            .getAvailableLenderList[index]
                                                            .organization
                                                            .toString(),
                                                        maxLine: 2,
                                                        fontWeight: FontWeight.w800),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 5),
                                                    child: textView15(
                                                      context: context,
                                                      text: "${"rate".tr}${Get.find<InstallmentViewController>()
                                                              .getAvailableLenderList[index]
                                                              .installmentFee} %",
                                                      maxLine: 1,
                                                      color: ColorResource.lightTextColor,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                              customImageButton(
                                                onTap: () async {
                                                  setState(() {
                                                    if (toggleButton) {
                                                      toggleButton = false;
                                                      _controller.animateBack(0, duration: const Duration(milliseconds: 300));
                                                    } else {
                                                      toggleButton = true;
                                                      if (_animation.status != AnimationStatus.completed) {
                                                        _controller.forward();
                                                      }
                                                    }
                                                  });
                                                },
                                                blur: 0,
                                                color: ColorResource.lightHintTextColor,
                                                radius: 5,
                                                padding: 0,
                                                height: 35,
                                                width: 35,
                                                icon: Icon(
                                                  toggleButton
                                                      ? Icons.keyboard_arrow_down_outlined
                                                      : Icons.keyboard_arrow_up_outlined,
                                                  size: 25,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizeTransition(
                                            sizeFactor: _animation,
                                            axis: Axis.vertical,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding: const EdgeInsets.only(top: 10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Divider(),
                                                      textView15(
                                                        color: ColorResource.lightTextColor,
                                                        textAlign: TextAlign.start,
                                                        context: context,
                                                        text: "${"down_payment".tr}: ${Get.find<InstallmentViewController>()
                                                                .getAvailableLenderList[index]
                                                                .installmentBooking} %",
                                                        height: 1.5,
                                                      ),
                                                      textView15(
                                                          color: ColorResource.lightTextColor,
                                                          textAlign: TextAlign.start,
                                                          context: context,
                                                          text: "${"contact".tr}: ${Get.find<InstallmentViewController>()
                                                                  .getAvailableLenderList[index]
                                                                  .phone}",
                                                          height: 1.5),
                                                      Get.find<InstallmentViewController>()
                                                                  .getAvailableLenderList[index]
                                                                  .address !=
                                                              ''
                                                          ? textView15(
                                                              color: ColorResource.lightTextColor,
                                                              textAlign: TextAlign.start,
                                                              context: context,
                                                              text: Get.find<InstallmentViewController>()
                                                                  .getAvailableLenderList[index]
                                                                  .address
                                                                  .toString(),
                                                              maxLine: 5)
                                                          : const SizedBox.shrink(),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )));
                          })
                      : Container(
                          decoration: customDecoration(radius: 10, shadowBlur: 0),
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          padding: const EdgeInsets.all(10),
                          child: textView15(context: context, text: "no_available_lender".tr),
                        ),
                ))
          ]),
        ));
  }

  // void _choose() async {
  //   final pickedFile =
  //       await picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500, maxWidth: 500);
  //
  //   setState(() {
  //     if (pickedFile != null) {
  //       file = File(pickedFile.path);
  //       //Noted* check with back-end for update only need param
  //
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }
  //

  // void paymentDialog(BuildContext buildContext) {
  //   alertDialogWidgetView(
  //     context: context,
  //     widget: Wrap(children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           TextViewSize_20(context: context, text: 'Available Lender'),
  //           CustomIconButton(
  //               padding: 3,
  //               height: 30,
  //               width: 30,
  //               icon: Icon(Icons.clear),
  //               onTap: () {
  //                 Navigator.pop(context);
  //               }),
  //         ],
  //       ),
  //       Container(
  //         constraints: BoxConstraints(maxHeight: 400),
  //         child: Obx(()=> ListView.builder(
  //               padding: EdgeInsets.only(top: 10),
  //               shrinkWrap: true,
  //               itemCount: Get.find<InstallmentViewController>().getAvailableLenderList.length,
  //               itemBuilder: (BuildContext context, int index) {
  //                 return Container(
  //                     decoration: CustomDecoration(radius: 10, shadowBlur: 2),
  //                     margin: EdgeInsets.only(top: 5, bottom: 5),
  //                     padding: EdgeInsets.only(left: 10),
  //                     child: Material(
  //                         color: ColorResource.whiteColor,
  //                         child: InkWell(
  //                           onTap: () async {
  //                             Navigator.pop(context);
  //                             Get.to(PaymentTableView());
  //                           },
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Expanded(
  //                                   child: Padding(
  //                                 padding: const EdgeInsets.only(top: 10, bottom: 10),
  //                                 child: TextViewSize_15(context: context, text:Get.find<InstallmentViewController>().getAvailableLenderList[index].organization.toString(), maxLine: 2),
  //                               )),
  //                               Padding(
  //                                 padding: const EdgeInsets.all(10),
  //                                 child: CustomIconTextButton(
  //                                     onTap: () {},
  //                                     iconAlign: CustomIconAlign.right,
  //                                     text: TextViewSize_12(context: context, text: "Detail"),
  //                                     blur: 0,
  //                                     color: ColorResource.lightHintTextColor,
  //                                     radius: 5,
  //                                     padding: 0,
  //                                     height: 40,
  //                                     width: 65,
  //                                     icon: Icon(
  //                                       Icons.arrow_forward_ios_rounded,
  //                                       size: 13,
  //                                     )),
  //                               )
  //                             ],
  //                           ),
  //                         )));
  //               }),
  //         ),
  //       )
  //     ]),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(context: context, titleText: "id_detail".tr),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await Permission.camera.request().then((value) async => {
                                Get.to(const TakePhotoView(
                                  isFront: true,
                                ))
                              });

                          // print("F>>" + s.name);
                          // if (s == PermissionStatus.granted) {
                          //   print("F>>" + s.name);
                          //   await Permission.camera.request().then((value) => {
                          //         Get.to(TakePhotoView(
                          //           isFront: true,
                          //         ))
                          //       });
                          // } else {
                          //   openAppSettings();
                          // }
                        },
                        child: Column(
                          children: [
                            Obx(
                              () => Padding(
                                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 30),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: Get.find<InstallmentViewController>().getFrontCapturePhotoPath == ''
                                      ? Image.asset("assets/images/front_id_card.png")
                                      : Image.file(File(Get.find<InstallmentViewController>().getFrontCapturePhotoPath),
                                          width: 120, height: 120, fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            textView15(
                                context: context,
                                text: "id_passport".tr,
                                fontWeight: FontWeight.w600,
                                color: ColorResource.lightShadowColor50)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: customDecoration(radius: 10, color: ColorResource.lightShadowColor50),
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      height: 130,
                      width: 3,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await Permission.camera.request().then((value) async => {
                                Get.to(const TakePhotoView(
                                  isFront: false,
                                ))
                              });
                          // if (await Permission.camera.request().isGranted) {
                          //   Get.to(TakePhotoView(
                          //     isFront: false,
                          //   ));
                          // } else {
                          //   openAppSettings();
                          // }
                        },
                        child: Column(
                          children: [
                            Obx(
                              () => Padding(
                                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 30),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: Get.find<InstallmentViewController>().getSelfieCapturePhotoPath == ''
                                      ? Image.asset("assets/images/selfie_with_id.png")
                                      : Image.file(
                                          File(Get.find<InstallmentViewController>().getSelfieCapturePhotoPath),
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            textView15(
                                context: context,
                                text: "selfie_id".tr,
                                fontWeight: FontWeight.w600,
                                color: ColorResource.lightShadowColor50)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: textView15(
                      context: context, text: 'take_photo_note'.tr, maxLine: 5, color: ColorResource.lightShadowColor),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child:
                      InputTextFieldCustom(controller: idNumberController, formKey: idNumberForm, hintTxt: "id_num".tr),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                //   child: InputTextFieldCustom(formKey: fullName, hintTxt: "Full ID Name"),
                // ),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, left: 20),
                        child: InputTextFieldWithIcon(
                            onTap: () {
                              _restorableDatePickerRouteFuture.present();
                            },
                            readonly: true,
                            formKey: dobForm,
                            controller: dobController,
                            maxIconWidth: 35,
                            minIconWidth: 15,
                            rightImageIcon: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 10),
                              child: Image.asset(
                                "assets/images/date_pic_ic.png",
                                width: 30,
                                height: 30,
                              ),
                            ),
                            hintTxt: "dob_no:".tr),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10, right: 20),
                        child: InputTextFieldWithIcon(
                            onTap: () {
                              customBottomSheetDialogWrap(
                                  context: context,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Wrap(
                                      direction: Axis.vertical,
                                      children: [
                                        customTextButton(
                                            width: MediaQuery.of(context).size.width,
                                            onTap: () {
                                              Navigator.pop(context);
                                              genderController.text = "male".tr;
                                            },
                                            radius: 0,
                                            blur: 0,
                                            text: textView15(
                                                text: "male".tr,
                                                context: context,
                                                color: ColorResource.secondaryColor,
                                                fontWeight: FontWeight.w600)),
                                        customTextButton(
                                            width: MediaQuery.of(context).size.width,
                                            onTap: () {
                                              Navigator.pop(context);
                                              genderController.text = "female".tr;
                                            },
                                            radius: 0,
                                            blur: 0,
                                            text: textView15(
                                                text: "female".tr,
                                                context: context,
                                                color: ColorResource.secondaryColor,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ));
                            },
                            readonly: true,
                            formKey: genderForm,
                            controller: genderController,
                            maxIconWidth: 35,
                            minIconWidth: 15,
                            rightImageIcon: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 10),
                              child: Image.asset(
                                "assets/images/arrow_up_down_ic.png",
                                width: 20,
                                height: 20,
                              ),
                            ),
                            hintTxt: "gender".tr),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: InputTextFieldCustom(
                      controller: addressController, formKey: addressForm, hintTxt: "place_of_birth".tr),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: textView20(context: context, text: "permanence_residential".tr),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, left: 20, right: 5),
                        child: InputTextFieldCustom(
                            controller: homeNumberController, formKey: homeNumberForm, hintTxt: "home_number".tr),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, left: 5, right: 20),
                        child: InputTextFieldCustom(
                            controller: stNumberController, formKey: stNumberForm, hintTxt: "st_num".tr),
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
                    child: InputTextFieldCustom(
                        controller: permanenceAddressController,
                        formKey: permanenceAddress,
                        hintTxt: "per_address".tr)),
              ],
            ),
          ),
          Obx(() => loaderFullScreenView(context, Get.find<InstallmentViewController>().showLoading.value))
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: customTextButton(
          blur: 0,
          height: 50,
          radius: 5,
          color: ColorResource.primaryColor,
          onTap: () async {
            idNumberForm.currentState!.validate();
            dobForm.currentState!.validate();
            genderForm.currentState!.validate();
            addressForm.currentState!.validate();
            homeNumberForm.currentState!.validate();
            stNumberForm.currentState!.validate();
            permanenceAddress.currentState!.validate();

            var id = idNumberController.text.trim();
            var dob = dobController.text.trim();
            var sex = genderController.text.trim();
            var address = addressController.text.trim();
            var hNumber = homeNumberController.text.trim();
            var sNumber = stNumberController.text.trim();
            var perAddress = permanenceAddressController.text.trim();
            var frontImage = Get.find<InstallmentViewController>().getFrontCapturePhotoPath;
            var selfieCardImage = Get.find<InstallmentViewController>().getSelfieCapturePhotoPath;

            if (frontImage.isEmpty && selfieCardImage.isEmpty) {
              snackBarMessage(context, "please_take_photo".tr);
            }

            if (id.isNotEmpty &&
                dob.isNotEmpty &&
                sex.isNotEmpty &&
                hNumber.isNotEmpty &&
                address.isNotEmpty &&
                sNumber.isNotEmpty &&
                perAddress.isNotEmpty &&
                frontImage.isNotEmpty &&
                selfieCardImage.isNotEmpty) {
              SubmitInstallmentBody body = Get.find<InstallmentViewController>().getSubmitInstallmentBody;
              body.cardNumber = id;
              body.dob = "$dob - $sex";
              body.currentAddress = address;
              body.permanentHomeNumber = hNumber;
              body.permanentCurrentAddress = perAddress;
              body.permanentStreetNumber = sNumber;
              body.cardIdImage = frontImage;
              body.cardIdBackImage = selfieCardImage;

            await Get.find<InstallmentViewController>().submitInstallments(
                  context,
                  Get.find<InstallmentViewController>().getSubmitInstallmentBody,
                  File(frontImage),
                  File(selfieCardImage), (uuid) {
                availableLenderList(uuid);
              });
            }
          },
          text: Center(
            child: textView15(
                context: context, text: "next".tr, color: ColorResource.whiteColor, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
