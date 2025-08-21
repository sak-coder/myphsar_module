import 'package:flutter/material.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';

import '../base_colors.dart';

Widget customTextButtonCustom(BuildContext context, Function() function, String text,
    {double width = 100, Color textColor = Colors.white}) => SizedBox(
    height: 45,
    width: width,
    child: TextButton(
        onPressed: function,
        style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(ColorResource.whiteColor),
            backgroundColor: WidgetStateProperty.all<Color>(ColorResource.primaryColor),
            elevation: WidgetStateProperty.all(2),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),
        child: textView15(context: context, text: text, color: textColor)),
  );

Widget socialLoginCustomButton(BuildContext context, Function() function, String text, Widget icon) {
  return Container(
    height: 50,
    margin: const EdgeInsets.only(bottom: 5),
    width: MediaQuery.of(context).size.width,
    child: OutlinedButton.icon(
      onPressed: function,
      label: textView15(
        context: context,
        text: text,
      ),
      style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(ColorResource.whiteColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: ColorResource.primaryColor02),
              borderRadius: BorderRadius.circular(5)))),
      icon: icon,
    ),
  );
}

Widget texButtonLinkCustom(BuildContext context, Function() function, String text) => TextButton(
      onPressed: function,
      style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(ColorResource.whiteColor),
          backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),
      child: textView15(
          context: context, text: text, fontWeight: FontWeight.w800, color: ColorResource.secondaryColor));
