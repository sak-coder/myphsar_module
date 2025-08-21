import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_icon_button.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/base_widget/loader_view.dart';
import 'package:myphsar/base_widget/snack_bar_message.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../auth/AuthController.dart';
import '../base_colors.dart';
import '../base_widget/input_text_field_icon.dart';
import '../base_widget/my_text_button.dart';
import '../base_widget/myphsar_text_view.dart';

class ForgetPasswordView extends StatefulWidget {
	const ForgetPasswordView({super.key});

	@override
	State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> with TickerProviderStateMixin {
	final _phoneNumberController = TextEditingController();
	final _phoneNumberKey = GlobalKey<FormState>();

	var newPwdFormKey = GlobalKey<FormState>();
	var confirmPwdFormKey = GlobalKey<FormState>();

	var newPwdController = TextEditingController();
	var confirmPwdController = TextEditingController();

	TextEditingController pinCodeTextController = TextEditingController();

	String otp = '';
	late TabController _controller;

	int _secondsRemaining = 120; // Initial
	Timer? _timer;
	bool _isEnabled = true;

	@override
	void initState() {
		_controller = TabController(length: 3, vsync: this);
		_controller.addListener(_handleSelected);

		super.initState();
	}

	void _startCountdown() {
		setState(() {
			_isEnabled = false;
			_secondsRemaining = 120; // Reset countdown duration

			pinCodeTextController.clear();
			if (_phoneNumberController.value.text.isNotEmpty) {
				Get.find<AuthController>().forgetPassword(context, _phoneNumberController.text.trim(), () {});
			}
		});

		_timer = Timer.periodic(const Duration(seconds: 1), (timer) {
			setState(() {
				if (_secondsRemaining > 0) {
					_secondsRemaining--;
				} else {
					_timer?.cancel();
					_isEnabled = true;
				}
			});
		});
	}

	@override
	void dispose() {
		_timer?.cancel();
		super.dispose();
	}

	void _handleSelected() {
		setState(() {
			_controller.index;
		});
	}

	@override
	Widget build(BuildContext context) {
		return CustomScaffold(
			body: SafeArea(
				child: Stack(
					children: [
						Column(
							crossAxisAlignment: CrossAxisAlignment.center,
							children: [
								Container(
									color: Colors.white,
									padding: const EdgeInsets.only(left: 10, right: 10),
									child: Row(
										mainAxisAlignment: MainAxisAlignment.spaceBetween,
										children: [
											_controller.index == 3
													? const SizedBox.shrink()
													: IconButton(
													onPressed: () => {routBack(_controller)},
													icon: const Icon(
														Icons.arrow_back_rounded,
														color: ColorResource.secondaryColor,
													))
										],
									),
								),
								Expanded(
										child: DefaultTabController(
												length: 3,
												child: TabBarView(
														controller: _controller,
														physics: const NeverScrollableScrollPhysics(),
														children: [
															enterPhoneNumberView(),
															verifyCodeView(),
													   	changeNewPasswordView(),
														]))),
							],
						),
						Obx(() =>
								loaderFullScreenView(context, Get
										.find<AuthController>()
										.isLoading
										.value))
					],
				),
			),
		);
	}

	Widget enterPhoneNumberView() {
		return Container(
			padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
			height: MediaQuery
					.of(context)
					.size
					.height,
			color: Colors.white,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: [
					Image.asset(
						"assets/images/log_with_text_ic.png",
						width: 250,
						fit: BoxFit.fitWidth,
					),
					Padding(
						padding: const EdgeInsets.only(top: 40, bottom: 20),
						child: textView20(
							context: context,
							text: "enter_pone".tr,
							color: ColorResource.darkTextColor,
						),
					),
					InputTextFieldWithIcon(
						textInputAction: TextInputAction.next,
						hintTxt: 'phone_number1'.tr,
						maxIconWidth: 90,
						controller: _phoneNumberController,
						formKey: _phoneNumberKey,
						inputType: TextInputType.number,
						imageIcon: Padding(
							padding: const EdgeInsets.all(2),
							child: Row(
								children: [
									Padding(
										padding: const EdgeInsets.only(left: 20, right: 20),
										child: textView13(context: context, text: "+855", fontWeight: FontWeight.w600),
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
					Padding(
						padding: const EdgeInsets.only(top: 20),
						child: customTextButtonCustom(context, () {
							_phoneNumberKey.currentState?.validate();
							if (_phoneNumberController.value.text.isNotEmpty) {
								Get.find<AuthController>().forgetPassword(context, _phoneNumberController.text, () {
									routNext(_controller);
								});
							}
						}, "Confirm", width: MediaQuery
								.of(context)
								.size
								.width),
					),
				],
			),
		);
	}

	Widget verifyCodeView() {
		return Container(
				padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
				color: Colors.white,
				child: Column(
					children: [
						customTextButton(
								padding: 15,
								text: textView16(
									context: context,
									fontWeight: FontWeight.w700,
									text: "verify_otp".tr,
									color: ColorResource.primaryColor,
								),
								blur: 0,
								color: const Color(0x3b96e4f4)),
						Padding(
							padding: const EdgeInsets.only(bottom: 20, top: 20),
							child: textView15(
									height: 2,
									context: context,
									text: 'otp_note'.tr + _phoneNumberController.text.toString(),
									maxLine: 2,
									textAlign: TextAlign.center),
						),
						PinCodeTextField(
							controller: pinCodeTextController,
							keyboardType: TextInputType.number,
							length: 4,
							// obscureText: false,
							pinTheme: PinTheme(
								activeColor: ColorResource.secondaryColor,
								selectedColor: ColorResource.secondaryColor,
								borderRadius: BorderRadius.circular(10),
								fieldHeight: 50,
								fieldWidth: 50,
							),
							onCompleted: (value) {
								otp = value;
								Get.find<AuthController>().verifyOtp(
										context: context,
										identity: _phoneNumberController.text.trim(),
										otp: otp,
										callback: () {
											routNext(_controller);
											setState(() {
												pinCodeTextController.clear();
											});
										});
							},
							animationType: AnimationType.fade,
							animationDuration: const Duration(milliseconds: 300),
							onChanged: (value) {},
							appContext: context,
						),
						Padding(
							padding: const EdgeInsets.all(20),
							child: textView15(context: context, text: 'error_otp_msg'.tr, maxLine: 2, textAlign: TextAlign.center),
						),

						customTextButton(
							blur: 1,
							height: 40,
							onTap: _isEnabled ? _startCountdown : null,
							text: textView15(
									context: context, text: _isEnabled ? "resend".tr : '$_secondsRemaining${" Sec  ${"resend".tr}"}'),
						),
					],
				));
	}

	Widget changeNewPasswordView() {
		return SingleChildScrollView(
			child: Container(
				padding: const EdgeInsets.all(20),
				color: Colors.white,
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.center,
					children: [
						Image.asset(
							"assets/images/log_with_text_ic.png",
							width: 250,
							fit: BoxFit.fitWidth,
						),
						Padding(
							padding: const EdgeInsets.only(top: 40, bottom: 20),
							child: textView20(
								context: context,
								text: "enter_password_msg".tr,
								color: ColorResource.darkTextColor,
							),
						),
						Padding(
							padding: const EdgeInsets.only(top: 10),
							child: InputTextFieldWithIcon(
								formKey: newPwdFormKey,
								controller: newPwdController,
								textInputAction: TextInputAction.newline,
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
						),
						Padding(
							padding: const EdgeInsets.only(top: 20),
							child: customTextButtonCustom(context, () {
								confirmPwdFormKey.currentState?.validate();
								newPwdFormKey.currentState?.validate();
								if(newPwdController.text.trim()!=confirmPwdController.text.trim()){
									snackBarMessage(context, "pwd_not_match_msg".tr);
									return;
								}
								if (_phoneNumberController.value.text.isNotEmpty) {
									Get.find<AuthController>().resetPassword(
											context: context,
											identity: _phoneNumberController.text.trim(),
											otp: otp,
											password: newPwdController.text.trim(),
											confirmPwd: confirmPwdController.text.trim());
								}
							}, "confirm".tr, width: MediaQuery
									.of(context)
									.size
									.width),
						),
					],
				),
			),
		);
	}

	void routNext(TabController controller) {
		if (controller.index == 0) {
			controller.animateTo(1);
		} else if (controller.index == 1) {
			controller.animateTo(2);
		} else {
			controller.animateTo(3);
			// Navigator.pushReplacement(
			//     context,
			//     PageRouteBuilder(
			//       transitionDuration: Duration(milliseconds: 2000),
			//       pageBuilder: (context, anim1, anim2) => SignInView(),
			//     ));
		}
	}

	void routBack(TabController controller) {
		if (controller.index == 3) {
			controller.animateTo(2);
		} else if (controller.index == 2) {
			controller.animateTo(1);
		} else {
			Navigator.pop(context);
		}
	}
}
