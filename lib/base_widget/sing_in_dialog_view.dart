import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/LogInView/SignInView.dart';
import '../base_colors.dart';
import 'custom_bottom_sheet_dialog.dart';
import 'custom_icon_button.dart';
import 'myphsar_text_view.dart';

Future signInDialogView(BuildContext context, {EdgeInsets padding = const EdgeInsets.only(top: 30, bottom: 25)}) =>
    customBottomSheetDialogWrap(
      context: context,
      padding: padding,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Column(
            children: [
              textView20(
                  fontWeight: FontWeight.w700,
                  context: context,
                  text: "section_lock_msg".tr,
                  color: ColorResource.darkTextColor,
                  fontHeight: 1.5),
              const SizedBox(
                height: 10,
              ),
              textView16(
                  context: context,
                  text: "please_sign_try_again".tr,
                  fontWeight: FontWeight.w500,
                  color: ColorResource.lightTextColor),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customTextButton(
                  blur: 0,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: textView20(
                      context: context,
                      text: "cancel".tr,
                      fontWeight: FontWeight.w600,
                      color: ColorResource.secondaryColor),
                ),
                customTextButton(
                    blur: 0,
                    onTap: () async {
                      await Get.to(() => const SignInView());
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    text: textView20(
                        context: context,
                        text: "sign_in".tr,
                        fontWeight: FontWeight.w600,
                        color: ColorResource.secondaryColor))
              ],
            ),
          )
        ],
      ),
    );
