import 'package:flutter/material.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarMessage(BuildContext context, String text,
    {Color bgColor = Colors.red, Color txtColor = Colors.white}) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: textView15(context: context, text: text, color: txtColor,maxLine: 2),
      backgroundColor: bgColor,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(10)));
