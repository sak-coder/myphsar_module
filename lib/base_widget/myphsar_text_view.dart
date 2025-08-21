import 'package:flutter/material.dart';
import '../base_colors.dart';

Widget textView23({
  required BuildContext context,
  required String text,
  Color color = ColorResource.primaryColor,
}) =>
    Text(
      text,
      textScaler: const TextScaler.linear(1),
      style: Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(fontSize: 23, color: color, fontWeight: FontWeight.w600, letterSpacing: 0.1, height: 1.3),
      textAlign: TextAlign.start,
    );

Widget textView20(
        {required BuildContext context,
        required String text,
        Color color = ColorResource.darkTextColor,
        int? maxLine,
        TextAlign textAlign = TextAlign.start,
        FontWeight? fontWeight = FontWeight.w600,
        double? fontHeight = 1.3}) =>
    Text(
      text,
      textScaler: const TextScaler.linear(1),
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: fontWeight,
            fontSize: 18,
            color: color,
            height: fontHeight,
            letterSpacing: 0.1,
          ),
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );

Widget textView25(
    {required BuildContext context,
    required String text,
    Color color = ColorResource.whiteColor,
    int? maxLine,
    FontWeight? fontWeight = FontWeight.w600,
    double? fontHeight}) {
  return Text(
    text,
    textScaler: const TextScaler.linear(1),
    style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: fontWeight,
          fontSize: 25,
          color: color,
          height: fontHeight,
          letterSpacing: 0.1,
        ),
    textAlign: TextAlign.start,
    maxLines: maxLine,
    overflow: TextOverflow.ellipsis,
  );
}

Widget textView30({
  required BuildContext context,
  required String text,
  Color color = ColorResource.primaryColor,
}) {
  return Text(
    text,
    textScaler: const TextScaler.linear(1),
    style: Theme.of(context)
        .textTheme
        .headlineSmall
        ?.copyWith(fontSize: 30, color: color, fontWeight: FontWeight.w600, letterSpacing: 0.1, height: 1.3),
    textAlign: TextAlign.start,
  );
}

Widget textView16(
    {required BuildContext context, required String text, FontWeight? fontWeight, Color? color, int? maxLine}) {
  return Text(
    text,
    textScaler: const TextScaler.linear(1),
    maxLines: maxLine,
    style: Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(fontSize: 16, fontWeight: fontWeight, color: color, letterSpacing: 0.1, height: 1.3),
    textAlign: TextAlign.start,
  );
}

Widget textView18(
    {required BuildContext context, required String text, FontWeight? fontWeight, Color? color, int? maxLine}) {
  return Text(
    text,
    textScaler: const TextScaler.linear(1),
    maxLines: maxLine,
    style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontSize: 18,
          fontWeight: fontWeight,
          color: color,
          height: 1.3,
          letterSpacing: 0.1,
        ),
    textAlign: TextAlign.start,
  );
}

Widget textViewCrossPrice16({
  required BuildContext context,
  required String text,
  FontWeight? fontWeight = FontWeight.w500,
  TextDecoration? textDecoration,
  Color color = ColorResource.primaryColor,
}) {
  return Text(
    text,
    textScaler: const TextScaler.linear(1),
    style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontSize: 16,
        height: 1.3,
        color: color,
        fontWeight: fontWeight,
        decoration: textDecoration,
        decorationThickness: 2,
        decorationColor: ColorResource.primaryColor,
        letterSpacing: 0.2),
    textAlign: TextAlign.start,
  );
}

Widget textViewCrossPrice20({
  required BuildContext context,
  required String text,
  Color color = ColorResource.primaryColor,
  FontWeight fontWeight = FontWeight.w500,
  TextDecoration? textDecoration,
}) =>
    Text(
      text,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: fontWeight,
            fontSize: 20,
            color: color,
            height: 1.3,
            decoration: textDecoration,
            decorationThickness: 2,
            decorationColor: ColorResource.primaryColor,
          ),
      textScaler: const TextScaler.linear(1),
      textAlign: TextAlign.start,
    );

Widget textView15({
  required BuildContext context,
  required String text,
  Color color = ColorResource.darkTextColor,
  int maxLine = 1,
  double height = 1.2,
  TextAlign textAlign = TextAlign.start,
  FontWeight fontWeight = FontWeight.w500,
}) =>
    Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleSmall
          ?.copyWith(fontSize: 15, fontWeight: fontWeight, height: height, color: color, letterSpacing: 0.1),
      textAlign: textAlign,
      textScaler: const TextScaler.linear(1),
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );

Widget textView14({
  required BuildContext context,
  required String text,
  Color color = ColorResource.darkTextColor,
  int maxLine = 1,
  double height = 1,
  TextAlign textAlign = TextAlign.start,
  FontWeight fontWeight = FontWeight.w500,
}) =>
    Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontSize: 14, fontWeight: fontWeight, height: height, color: color, letterSpacing: 0.1),
      textAlign: textAlign,
      textScaler: const TextScaler.linear(1),
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );

Widget textViewCrossPrice13({
  required BuildContext context,
  required String text,
  Color color = ColorResource.primaryColor,
  FontWeight fontWeight = FontWeight.w500,
  TextDecoration? textDecoration,
}) =>
    Text(
      text,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: fontWeight,
          fontSize: 13,
          color: color,
          decoration: textDecoration,
          height: 1.3,
          decorationThickness: 2,
          decorationColor: ColorResource.primaryColor,
          letterSpacing: 0.1),
      textScaler: const TextScaler.linear(1),
      textAlign: TextAlign.start,
    );

Widget textView13({
  required BuildContext context,
  required String text,
  Color color = ColorResource.darkTextColor,
  FontWeight fontWeight = FontWeight.w500,
  int? maxLine,
  TextAlign textAlign = TextAlign.start,
  double? height = 1.3,
}) =>
    Text(
      text,
      textScaler: const TextScaler.linear(1),
      textAlign: textAlign,
      style: Theme.of(context)
          .textTheme
          .labelLarge
          ?.copyWith(fontWeight: fontWeight, fontSize: 13, color: color, letterSpacing: 0.1, height: height),

      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );

Widget textViewCrossPrice12({
  required BuildContext context,
  required String text,
  Color color = ColorResource.primaryColor,
  FontWeight fontWeight = FontWeight.w500,
  TextDecoration? textDecoration,
}) =>
    Text(
      text,
      textScaler: const TextScaler.linear(1),
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            letterSpacing: 0.1,
            fontWeight: fontWeight,
            fontSize: 12,
            color: color,
            decoration: textDecoration,
            decorationThickness: 2,
            decorationColor: ColorResource.primaryColor,
          ),
      textAlign: TextAlign.start,
    );

Widget textView12(
        {required BuildContext context,
        required String text,
        String? fontFamily,
        int? maxLine = 10,
        double height = 1.2,
        Color color = ColorResource.primaryColor,
        FontWeight fontWeight = FontWeight.w500}) =>
    Text(
      text,
      textScaler: const TextScaler.linear(1),
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: fontWeight,
          fontSize: 12,
          height: height,
          color: color,
          letterSpacing: 0.1,
          fontFamily: fontFamily),
      textAlign: TextAlign.start,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );

Widget textView11(
        {required BuildContext context,
        required String text,
        double height = 1.2,
        Color color = ColorResource.lightTextColor,
        FontWeight fontWeight = FontWeight.w500}) =>
    Text(
      text,
      textScaler: const TextScaler.linear(1),
      style: Theme.of(context)
          .textTheme
          .labelLarge
          ?.copyWith(fontWeight: fontWeight, fontSize: 11, height: height, color: color, letterSpacing: 0.1),
      textAlign: TextAlign.start,
    );

Widget textView10(
        {required BuildContext context,
        required String text,
        double height = 1.2,
        Color color = ColorResource.lightTextColor,
        FontWeight fontWeight = FontWeight.w600}) =>
    Text(
      text,
      textScaler: const TextScaler.linear(1),
      style: Theme.of(context)
          .textTheme
          .labelLarge
          ?.copyWith(fontWeight: fontWeight, fontSize: 10, height: height, color: color, letterSpacing: 0.1),
      textAlign: TextAlign.start,
    );
