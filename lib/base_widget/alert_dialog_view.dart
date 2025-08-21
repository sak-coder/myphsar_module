import 'package:flutter/material.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/base_widget/custom_decoration.dart';

import 'custom_icon_button.dart';
import 'myphsar_text_view.dart';

Future successAlertDialogView(BuildContext context, String title, {String message = ''}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 3), () {
        if (context.mounted) {
          Navigator.of(context).pop(true);
        }
      });
      return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
            decoration: customDecoration(
              radius: 20,
              color: ColorResource.primaryColor,
            ),
            child: Wrap(
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Center(
                  child: Icon(
                    Icons.check_rounded,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                Center(
                  child: textView15(
                    context: context,
                    text: title,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                    color: Colors.white,
                  ),
                ),
                message != ''
                    ? textView15(
                        context: context,
                        text: message,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                        maxLine: 3,
                        color: Colors.white,
                      )
                    : const SizedBox.shrink(),
              ],
            )),
      );
    },
  );
}

Future alertDialogMessageView(
  String? title, {
  required BuildContext context,
  required String message,
  required Widget icon,
  Function()? callback,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.of(context).pop();
        callback!();
      });
      return PopScope(
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            callback!();
          }
        },
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Container(
              height: 220,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              decoration: customDecoration(
                radius: 20,
                color: ColorResource.primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  textView20(color: Colors.white, context: context, text: title.toString()),
                  icon,
                  textView15(
                      context: context,
                      text: message,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      color: Colors.white,
                      maxLine: 3),
                ],
              )),
        ),
      );
    },
  );
}

Future customConfirmAlertDialogWidgetView(
    {required BuildContext context,
    required String title,
    String? message,
    required String posText,
    String? navText,
    required Function() onPosClick,
    bool dismissAble = true}) {
  return showDialog(
    barrierDismissible: dismissAble,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Wrap(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15),
                  decoration: customDecoration(
                    radius: 20,
                    color: ColorResource.whiteColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textView20(context: context, text: title, color: ColorResource.lightTextColor, fontHeight: 2),
                      message != null
                          ? textView14(
                              context: context,
                              text: message,
                              maxLine: 2,
                              textAlign: TextAlign.center,
                              height: 1.5,
                              color: ColorResource.lightTextColor)
                          : const SizedBox.shrink(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          navText != null
                              ? customTextButton(
                                  blur: 0,
                                  margin: const EdgeInsets.only(top: 10),
                                  text: textView15(context: context, text: navText, fontWeight: FontWeight.w700),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  })
                              : const SizedBox.shrink(),
                          customTextButton(
                              blur: 0,
                              margin: const EdgeInsets.only(top: 10),
                              text: textView15(
                                  context: context,
                                  text: posText,
                                  fontWeight: FontWeight.w700,
                                  color: ColorResource.secondaryColor),
                              onTap: () {
                                onPosClick();
                              }),
                        ],
                      )
                    ],
                  )),
            ],
          ));
    },
  );
}

Future autoDismissAlertDialogWidgetView({required BuildContext context, required Widget widget}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.of(context).pop();
      });
      return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Wrap(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15),
                  decoration: customDecoration(
                    radius: 20,
                    color: ColorResource.whiteColor,
                  ),
                  child: widget),
            ],
          ));
    },
  );
}

Future alertDialogWidgetView({required BuildContext context, required Widget widget}) {
  // Future.delayed(Duration(seconds: 3), () {
  //   Navigator.of(context).pop(true);
  // });
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Wrap(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15),
                  decoration: customDecoration(
                    radius: 20,
                    color: ColorResource.whiteColor,
                  ),
                  child: widget),
            ],
          ));
    },
  );
}
