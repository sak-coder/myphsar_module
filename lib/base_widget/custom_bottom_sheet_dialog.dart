import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myphsar/base_colors.dart';

import 'myphsar_text_view.dart';

Future<void> customErrorBottomDialog(BuildContext context, String message) {
  return customBottomSheetDialogWrap(
      context: context,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: textView15(
            context: context, text: message, maxLine: 3, textAlign: TextAlign.center, color: ColorResource.whiteColor),
      ),
      radius: 0,
      color: ColorResource.primaryColor,
      barrierColor: Colors.transparent);
}

Future<void> customBottomSheetDialog(
    {required BuildContext context,
    required Widget child,
    required double height,
    double radius = 25.0,
    Color color = Colors.white,
    Color? barrierColor, bool isDismiss = true,
    EdgeInsets padding = const EdgeInsets.all(20)}) {
  return showModalBottomSheet<void>(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
    context: context,
    isDismissible: isDismiss,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: barrierColor,
    builder: (context) => Container(
      padding: padding,
      margin: MediaQuery.of(context).viewInsets,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
      ),
      child: child,
    ),
  );
}

Future<void> customBottomSheetDialogWrap(
    {required BuildContext context,
    required Widget child,
    double radius = 25.0,
    Color color = Colors.white,
    Color? barrierColor,
    EdgeInsets padding = const EdgeInsets.all(20)}) {
  return showModalBottomSheet<void>(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: barrierColor,
    builder: (context) => SingleChildScrollView(
      child: Container(
          padding: padding,
          margin: const EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
            ),
          ),
          child: child),
    ),
  );
}
