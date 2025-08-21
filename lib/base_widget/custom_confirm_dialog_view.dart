import 'package:flutter/cupertino.dart';
import 'package:myphsar/base_widget/custom_bottom_sheet_dialog.dart';

import '../base_colors.dart';
import 'custom_icon_button.dart';
import 'myphsar_text_view.dart';

Future<void> customConfirmDialogView(
    {required BuildContext context,
    required String title,
    required String positiveText,
    required String negativeText,
    required Function() positive}) {
  return customBottomSheetDialogWrap(
      context: context,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
      child: Wrap(
        children: [
          Center(
            child: textView20(
                context: context,
                text: title,
                fontWeight: FontWeight.w600,
                color: ColorResource.darkTextColor,
                maxLine: 2,
                textAlign: TextAlign.center),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customTextButton(
                padding: 1,
                blur: 0,
                height: 50,
                width: 95,
                onTap: positive,
                text: Center(
                  child: textView20(
                      context: context,
                      text: positiveText,
                      fontWeight: FontWeight.w600,
                      color: ColorResource.darkTextColor),
                ),
              ),
              customTextButton(
                padding: 1,
                blur: 0,
                height: 50,
                width: 95,
                onTap: () {
                  Navigator.pop(context);
                },
                text: Center(
                  child: textView20(
                      context: context,
                      text: negativeText,
                      fontWeight: FontWeight.w600,
                      color: ColorResource.primaryColor),
                ),
              )
            ],
          )
        ],
      ));
}
