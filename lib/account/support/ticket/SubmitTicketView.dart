import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/account/support/support_ticket_controller.dart';
import 'package:myphsar/account/support/SupportTicketParam.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_icon_button.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/base_widget/input_text_field_custom.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';

class SubmitTicketView extends StatefulWidget {
  final String ticketType;
  final String icon;

  const SubmitTicketView({super.key, required this.ticketType, required this.icon});

  @override
  State<SubmitTicketView> createState() => _SubmitTicketViewState();
}

class _SubmitTicketViewState extends State<SubmitTicketView> {
  var subjectFormKey = GlobalKey<FormState>();
  var descriptionFormKey = GlobalKey<FormState>();
  var subjectController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: customAppBarView(elevation: 0, context: context, titleText: 'submit_ticket'.tr),
        body: SingleChildScrollView(
          child: Column(
            children: [
              customImageTextButton(
                  leftPadding: 20,
                  padding: 10,
                  color: ColorResource.lightHintTextColor,
                  radius: 0,
                  blur: 0,
                  height: 60,
                  text: textView15(
                      fontWeight: FontWeight.w700,
                      context: context,
                      text: widget.ticketType,
                      maxLine: 1,
                      height: 1,
                      color: ColorResource.darkTextColor),
                  icon: Image.asset(
                    widget.icon,
                    height: 20,
                  ),
                  iconAlign: CustomIconAlign.left),
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
                  child: InputTextFieldCustom(
                    formKey: subjectFormKey,
                    hintTxt: "subject".tr,
                    controller: subjectController,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InputTextFieldCustom(
                  formKey: descriptionFormKey,
                  controller: descriptionController,
                  hintTxt: "issue_detail_hint".tr,
                  textInputAction: TextInputAction.send,
                  maxLine: 6,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: customTextButton(
                      blur: 0,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      radius: 5,
                      color: ColorResource.primaryColor,
                      onTap: () {
                        subjectFormKey.currentState!.validate();
                        descriptionFormKey.currentState!.validate();

                        Get.find<SupportTicketController>().sendSupportTicket(
                            SupportTicketParamModel(
                                type: widget.ticketType,
                                subject: subjectController.text,
                                description: descriptionController.text),
                            context);
                      },
                      text: Center(
                        child: textView15(
                            context: context,
                            text: "send".tr,
                            maxLine: 1,
                            color: ColorResource.whiteColor,
                            textAlign: TextAlign.center),
                      ))),
            ],
          ),
        ));
  }
}
