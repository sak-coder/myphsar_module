import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/base_widget/custom_bottom_sheet_dialog.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';
import 'package:myphsar/helper/share_pref_controller.dart';

import '../../base_widget/custom_appbar_view.dart';
import '../../base_widget/custom_icon_button.dart';
import '../../base_widget/input_text_field_icon.dart';
import '../user_profile/user_profile_controller.dart';
import '../user_profile/UserProfileModel.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  var oldPwdFormKey = GlobalKey<FormState>();
  var newPwdFormKey = GlobalKey<FormState>();
  var confirmPwdFormKey = GlobalKey<FormState>();
  var oldPwdController = TextEditingController();
  var newPwdController = TextEditingController();
  var confirmPwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(context: context, titleText: 'change_pwd'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textView15(context: context, text: 'old_pwd'.tr, color: ColorResource.darkTextColor),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: InputTextFieldWithIcon(
                  formKey: oldPwdFormKey,
                  controller: oldPwdController,
                  hintTxt: 'old_pwd'.tr,
                  fillColor: Colors.white,
                  isPassword: true,
                  imageIcon: Image.asset(
                    "assets/images/key_ic.png",
                    width: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: textView15(context: context, text: 'new_pwd'.tr, color: ColorResource.darkTextColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: InputTextFieldWithIcon(
                  formKey: newPwdFormKey,
                  controller: newPwdController,
                  hintTxt: 'new_pwd'.tr,
                  fillColor: Colors.white,
                  isPassword: true,
                  imageIcon: Image.asset(
                    "assets/images/key_ic.png",
                    width: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: textView15(context: context, text: 'confirm_pwd'.tr, color: ColorResource.darkTextColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: InputTextFieldWithIcon(
                  formKey: confirmPwdFormKey,
                  controller: confirmPwdController,
                  hintTxt: 'confirm_pwd'.tr,
                  fillColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  isPassword: true,
                  imageIcon: Image.asset(
                    "assets/images/key_ic.png",
                    width: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: customTextButton(
            blur: 0,
            height: 50,
            radius: 5,
            color: ColorResource.primaryColor,
            onTap: () {
              oldPwdFormKey.currentState?.validate();
              newPwdFormKey.currentState?.validate();
              confirmPwdFormKey.currentState?.validate();

              var userProfile = Get.find<SharePrefController>().getUserProfile();
              if (newPwdController.value.text != '' &&
                  oldPwdController.value.text != '' &&
                  confirmPwdController.value.text != '') {
                if (newPwdController.value.text == confirmPwdController.value.text) {
                  Get.find<UserProfileController>().updateUserInfo(
                      context: context,
                      updateUserModel: ParamUserProfileModel(
                        fName: userProfile.fName,
                        lName: userProfile.lName,
                        email: userProfile.email,
                        phone: userProfile.phone,
                      ),
                      pass: confirmPwdController.value.text);
                } else {
                  customBottomSheetDialog(
                      color: ColorResource.primaryColor,
                      radius: 0,
                      context: context,
                      child: textView15(
                          context: context,
                          text: 'pwd_no_match_mes'.tr,
                          maxLine: 3,
                          color: Colors.white,
                          textAlign: TextAlign.center),
                      height: 100);
                }
              }
            },
            text: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: textView15(
                  context: context,
                  text: "update_pwd".tr,
                  maxLine: 1,
                  height: 1.7,
                  color: ColorResource.whiteColor,
                  textAlign: TextAlign.center),
            )),
      ),
    );
  }
}
