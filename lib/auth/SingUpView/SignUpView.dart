import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/account/user_profile/UserProfileModel.dart';

import '../../account/user_profile/user_profile_controller.dart';
import '../../base_widget/custom_appbar_view.dart';
import '../../base_widget/custom_bottom_sheet_dialog.dart';
import '../../base_widget/input_text_field_custom.dart';
import '../../base_widget/input_text_field_icon.dart';
import '../../base_widget/my_text_button.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../AuthController.dart';
import 'SignUpModel.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignUpView> with SingleTickerProviderStateMixin {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _firstNameKey = GlobalKey<FormState>();
  final _lastNameKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  final _reEnterPasswordKey = GlobalKey<FormState>();
  final _phoneKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String countryCode = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarView(context: context, titleText: '', elevation: 0),
      body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Obx(() => Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "assets/images/log_with_text_ic.png",
                                width: 250,
                                fit: BoxFit.fitWidth,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              textView20(
                                context: context,
                                text: "create_new_acc".tr,
                                color: ColorResource.darkTextColor,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: InputTextFieldCustom(
                                      textInputAction: TextInputAction.next,
                                      hintTxt: 'first_name'.tr,
                                      controller: _firstNameController,
                                      formKey: _firstNameKey,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: InputTextFieldCustom(
                                      textInputAction: TextInputAction.next,
                                      hintTxt: 'last_name'.tr,
                                      controller: _lastNameController,
                                      formKey: _lastNameKey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InputTextFieldCustom(
                                textInputAction: TextInputAction.next,
                                hintTxt: 'email1'.tr,
                                inputType: TextInputType.emailAddress,
                                controller: _emailController,
                                formKey: _emailKey,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InputTextFieldWithIcon(
                                textInputAction: TextInputAction.next,
                                hintTxt: 'phone_number1'.tr,
                                controller: _phoneController,
                                formKey: _phoneKey,
                                inputType: TextInputType.number,
                                imageIcon: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Row(
                                    children: [
                                      // CustomIconTextButton(
                                      //   leftPadding: 2,
                                      //     text: Padding(
                                      //       padding: const EdgeInsets.only(left: 10),
                                      //       child : CountryCodePicker(
                                      //         padding: EdgeInsets.all(10),
                                      //
                                      //       textOverflow: TextOverflow.ellipsis,
                                      //       textStyle: TextStyle(fontSize: 15,color: ColorResource.darkTextColor),
                                      //       showFlag: true,
                                      //       showCountryOnly: false,
                                      //       onChanged: (val){
                                      //
                                      //       },
                                      //
                                      //         initialSelection: 'IT',
                                      //         favorite: ['+39','FR'],
                                      //
                                      //       flagDecoration: BoxDecoration(
                                      //
                                      //         borderRadius: BorderRadius.circular(1),
                                      //       ),
                                      //     ),),
                                      //
                                      //     // Padding(
                                      //     //   padding: const EdgeInsets.only(left: 5),
                                      //     //   child: TextViewSize_15(context: context, text: "Code",color: ColorResource.lightTextColor),
                                      //     // ),
                                      //     onTap: (){},
                                      //     radius:10,color: ColorResource.lightHintTextColor,blur:0,height: 42,width:100, icon: Image.asset("assets/images/phone_off_ic.png",color: ColorResource.hintTextColor,)),
                                      CountryCodePicker(
                                        padding: const EdgeInsets.only(left: 5),
                                        onInit: (val) {
                                          if (val!.dialCode == null) {
                                            countryCode = "+855";
                                          }
                                          countryCode = val.dialCode.toString();
                                        },
                                        dialogTextStyle: const TextStyle(
                                            color: Color(0xFF950004),
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "OpenSans-Medium.ttf",
                                            letterSpacing: 0.2),
                                        textOverflow: TextOverflow.ellipsis,
                                        textStyle: const TextStyle(fontSize: 15, color: ColorResource.darkTextColor),
                                        showFlag: true,
                                        showCountryOnly: false,
                                        onChanged: (val) {
                                          countryCode = val.dialCode.toString();
                                        },
                                        initialSelection: 'kh',
                                        favorite: const ['+855', 'kh'],
                                        flagDecoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(1),
                                        ),
                                      ),

                                      Container(
                                        height: 30,
                                        width: 1,
                                        color: ColorResource.hintTextColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InputTextFieldWithIcon(
                                hintTxt: 'pwd'.tr,

                                isPassword: true,
                                textInputAction: TextInputAction.next,
                                controller: _passwordController,
                                formKey: _passwordKey,
                                imageIcon: Image.asset(
                                  "assets/images/key_ic.png",
                                  width: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InputTextFieldWithIcon(
                                hintTxt: 'confirm_pwd'.tr,
                                isPassword: true,
                                textInputAction: TextInputAction.done,
                                controller: _confirmPasswordController,
                                formKey: _reEnterPasswordKey,
                                imageIcon: Image.asset(
                                  "assets/images/key_ic.png",
                                  width: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              customTextButtonCustom(context, () {
                                _firstNameKey.currentState?.validate();
                                _lastNameKey.currentState?.validate();
                                _emailKey.currentState?.validate();
                                _phoneKey.currentState?.validate();
                                _passwordKey.currentState?.validate();
                                _reEnterPasswordKey.currentState?.validate();

                                var firstName = _firstNameController.text.trim();
                                var lastName = _lastNameController.text.trim();
                                var emailText = _emailController.text.trim();
                                var phoneText =
                                    countryCode + _phoneController.text.replaceFirst(RegExp(r'^0+'), '').trim();

                                var confirmPwdText = _confirmPasswordController.text.trim();

                                if (firstName.isNotEmpty &&
                                    lastName.isNotEmpty &&
                                    emailText.isNotEmpty &&
                                    phoneText.isNotEmpty &&
                                    confirmPwdText.isNotEmpty) {
                                  if (_confirmPasswordController.value.text == _passwordController.value.text) {
                                    var singUpModel = SingUpModel(
                                      fName: firstName,
                                      lName: lastName,
                                      email: emailText,
                                      phone: phoneText,
                                      password: confirmPwdText,
                                    );

                                    Get.find<AuthController>().singUp(singUpModel, context, (response) async {
                                      if (response) {
                                        await Get.find<UserProfileController>().getUserProfile(
                                            context,
                                            (isGetUser) => {
                                                  if (isGetUser)
                                                    {
                                                      Navigator.of(context)
                                                        ..pop()
                                                        ..pop()
                                                    }
                                                  else
                                                    {
                                                      Get.find<UserProfileController>().saveTemporaryProfile(
                                                          UserProfileModel(fName: firstName, lName: lastName)),
                                                      Navigator.of(context)
                                                        ..pop()
                                                        ..pop()
                                                    }
                                                });
                                      } else {}
                                    });
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
                                } else {}
                              }, "sign_up".tr, width: MediaQuery.of(context).size.width),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: Get.find<AuthController>().isLoading.value,
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.black12,
                      child: const CircularProgressIndicator(
                        color: ColorResource.primaryColor,
                      ),
                    ),
                  ),
                ],
              ))),
    ); //Container(child: CustomBottomSheetDialog(context: context, child: TextViewSize_15(context: context, text: "text", maxLine: 1), height: 120),)
  }
}
