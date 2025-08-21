import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/auth/AuthController.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_confirm_dialog_view.dart';
import 'package:myphsar/base_widget/custom_icon_button.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';

import '../../base_colors.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../../base_widget/title_row_icon_widget.dart';
import '../password/ChangePasswordView.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(context: context, titleText: 'setting'.tr),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            titleRowWidget(
                context: context,
                title: 'change_pwd'.tr,
                icon: const Icon(Icons.keyboard_arrow_right_outlined),
                onTap: () {
                  Get.to(const ChangePasswordView());
                }),
            titleRowWidget(
                context: context,
                title: 'delete_acc'.tr,
                icon: const Icon(Icons.keyboard_arrow_right_outlined),
                onTap: () {
                  customConfirmDialogView(
                      context: context,
                      title: "delete_account_msg".tr,
                      positiveText: "yes".tr,
                      negativeText: "no".tr,
                      positive: () async {
                        await Get.find<AuthController>().deleteAccount(context);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      });
                }),
          ],
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
              customConfirmDialogView(
                  context: context,
                  title: "log_out_msg".tr,
                  positiveText: "yes".tr,
                  negativeText: "no".tr,
                  positive: () async {
                    Get.find<AuthController>().logOut(context);
                    Navigator.pop(context);
                  });
            },
            text: Center(
              child: textView15(
                  context: context,
                  text: "log_out".tr,
                  maxLine: 1,
                  color: ColorResource.whiteColor,
                  textAlign: TextAlign.center),
            )),
      ),
    );
  }
}
