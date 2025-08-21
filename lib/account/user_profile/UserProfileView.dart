import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/helper/share_pref_controller.dart';

import '../../base_widget/profile_input_text_field_widget.dart';
import 'user_profile_controller.dart';
import 'UserProfileModel.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  final _emailKey = GlobalKey<FormState>();
  final _fNameKey = GlobalKey<FormState>();
  final _lNameKey = GlobalKey<FormState>();
  final _phoneKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();

  var lNameFocus = FocusNode();
  var fNameFocus = FocusNode();
  var emailFocus = FocusNode();
  var phoneFocus = FocusNode();

  @override
  void initState() {
    var localUserProfile = Get.find<SharePrefController>().getUserProfile();

    _fNameController.text = localUserProfile.fName!;
    _lNameController.text = localUserProfile.lName!;
    _emailController.text = localUserProfile.email != null ? localUserProfile.email! : "";
    _phoneController.text = localUserProfile.phone!;
    super.initState();
  }

  void update() {
    if (_emailController.value.text.isNotEmpty &&
        _lNameController.value.text.isNotEmpty &&
        _fNameController.value.text.isNotEmpty &&
        _phoneController.value.text.isNotEmpty) {
      Get.find<UserProfileController>().updateUserInfo(
          context: context,
          updateUserModel: ParamUserProfileModel(
              lName: _lNameController.value.text,
              fName: _fNameController.value.text,
              email: _emailController.value.text,
              phone: _phoneController.value.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(context: context, titleText: "account".tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileInputTextFieldWidget(
              hintText: 'first_name'.tr,
              title: 'first_name'.tr,
              controller: _fNameController,
              icon: Image.asset("assets/images/acc_ic.png"),
              onSave: () {
                setState(() {
                  update();
                });
              },
              formKey: _fNameKey,
              focusNote: fNameFocus,
            ),
            ProfileInputTextFieldWidget(
              hintText: 'last_name'.tr,
              title: 'last_name'.tr,
              controller: _lNameController,
              icon: Image.asset("assets/images/acc_ic.png"),
              onSave: () {
                setState(() {
                  update();
                });
              },
              formKey: _lNameKey,
              focusNote: lNameFocus,
            ),
            ProfileInputTextFieldWidget(
              hintText: 'phone_number1'.tr,
              title: 'phone_number1'.tr,
              controller: _phoneController,
              icon: Image.asset("assets/images/phone_off_ic.png"),
              onSave: () {
                setState(() {
                  update();
                });
              },
              formKey: _phoneKey,
              focusNote: phoneFocus,
            ),
            ProfileInputTextFieldWidget(
              hintText: 'email1'.tr,
              title: 'email1'.tr,
              controller: _emailController,
              icon: Image.asset(
                "assets/images/email_ic.png",
                width: 20,
                height: 20,
              ),
              onSave: () {
                setState(() {
                  update();
                });
              },
              formKey: _emailKey,
              focusNote: emailFocus,
            ),
          ],
        ),
      ),
    );
  }
}
