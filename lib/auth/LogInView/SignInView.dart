import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/app_constants.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/auth/SingUpView/SignUpView.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/snack_bar_message.dart';

import '../../base_widget/input_text_field_custom.dart';
import '../../base_widget/my_text_button.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../../configure/config_controller.dart';
import '../../reset_password/forget_password_view.dart';
import '../AuthController.dart';
import '../AuthModel.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> with SingleTickerProviderStateMixin {
  final _passwordController = TextEditingController();

  final _emailController = TextEditingController();
  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();

  bool facebookLogin = false;
  bool appleLogin = false;
  bool googleLogin = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void initState() {
    _passwordController.text = '';
    _emailController.text = '';

    for (var element in Get.find<ConfigController>().configModel.socialLogin!) {
      switch (element.loginMedium) {
        case AppConstants.FB_LOGIN:
          facebookLogin = element.status!;
          break;
        case AppConstants.GOOGLE_LOGIN:
          googleLogin = element.status!;
          break;
        case AppConstants.APPLE_LOGIN:
          appleLogin = element.status!;
          break;
      }
      // if (element.status == true && element.loginMedium == AppConstants.FB_LOGIN) {
      //   facebookLogin = true;
      // } else if (element.status == true && element.loginMedium == AppConstants.GOOGLE_LOGIN) {
      //   googleLogin = true;
      // }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarView(context: context, titleText: '', elevation: 0),
      body: Obx(() => Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Image Icon
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
                              text: "sing_in_continue".tr,
                              color: ColorResource.darkTextColor,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        Column(
                          children: [
                            InputTextFieldCustom(
                              textInputAction: TextInputAction.next,
                              hintTxt: 'email_phone'.tr,
                              controller: _emailController,
                              formKey: _emailKey,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InputTextFieldCustom(
                              hintTxt: 'pwd'.tr,
                              isPassword: true,
                              textInputAction: TextInputAction.done,
                              controller: _passwordController,
                              formKey: _passwordKey,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            customTextButtonCustom(context, () {
                              _emailKey.currentState?.validate();
                              _passwordKey.currentState?.validate();
                              if (_passwordController.value.text.isNotEmpty && _emailController.value.text.isNotEmpty) {
                                if (_emailController.value.text.isValidEmail()) {
                                  Get.find<AuthController>().signIn(
                                      AuthModel(
                                          email: _emailController.value.text.trim(),
                                          password: _passwordController.value.text.trim()),
                                      context);
                                } else {
                                  var phone = _emailController.text.trim();
                                  if (phone.length >= 8) {
                                    Get.find<AuthController>().signIn(
                                        AuthModel(
                                            email: _emailController.text.trim(),
                                            password: _passwordController.value.text.trim()),
                                        context);
                                  } else {
                                    snackBarMessage(context, "invalid_phone_msg".tr);
                                  }
                                }
                              }
                            }, "sing_in".tr, width: MediaQuery.of(context).size.width),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 20,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    height: 1,
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 50, right: 50),
                                      color: Colors.black12,
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(left: 20, right: 20),
                                      color: Colors.white,
                                      child: textView15(
                                        text: "or".tr,
                                        context: context,
                                      ))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            googleLogin
                                ? socialLoginCustomButton(context, () {
                                    // Get.find<AuthController>().googleSignIn(context);
                                  },
                                    'log_in_google'.tr,
                                    Image.asset(
                                      'assets/images/ic_google.png',
                                      width: 30,
                                      height: 30,
                                    ))
                                : const SizedBox.shrink(),
                            appleLogin
                                ? socialLoginCustomButton(context, () {
                                    Get.find<AuthController>().appleSingIn();
                                  },
                                    'log_in_apple'.tr,
                                    const Icon(
                                      Icons.apple,
                                      size: 30,
                                      color: Colors.black87,
                                      weight: 30,
                                    ))
                                : const SizedBox.shrink(),
                            facebookLogin
                                ? socialLoginCustomButton(context, () {
                                    // Get.find<AuthController>().fbLogin(context);
                                  },
                                    'log_in_fb'.tr,
                                    Image.asset(
                                      'assets/images/fb_ic.png',
                                      color: Colors.blue,
                                      width: 11,
                                      height: 20,
                                    ))
                                : const SizedBox.shrink()

                            // Get.find<ConfigController>().configModel.socialLogin!.length > 0 ? FacebookCustomButtom(context, () {
                            //   Get.find<AuthController>().fbLogin(context);
                            // }, 'log_in_fb'.tr):SizedBox.shrink(),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            texButtonLinkCustom(context, () {
                              Get.to(()=>const ForgetPasswordView());
                            }, "forget_pwd".tr),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontWeight: FontWeight.w700, color: ColorResource.lightTextColor),
                                    text: 'dont_have_acc'.tr,
                                  ),
                                  TextSpan(
                                    text: 'register'.tr,
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.w800,
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.to(()=>const SignUpView());
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
          )),
    ); //Container(child: CustomBottomSheetDialog(context: context, child: TextViewSize_15(context: context, text: "text", maxLine: 1), height: 120),)
  }
}
