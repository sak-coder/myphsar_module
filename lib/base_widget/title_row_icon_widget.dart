import 'package:flutter/material.dart';

import '../base_colors.dart';
import 'myphsar_text_view.dart';

Widget titleRowWidget(
    {required Function() onTap,
    required BuildContext context,
    required String title,
      FontWeight fontWeight = FontWeight.w500,
      EdgeInsets padding = const EdgeInsets.only(top: 12,bottom: 12),
    Color textColor = ColorResource.darkTextColor,
    required Widget icon}) => Material(
    color: Colors.white,
    child: InkWell(
      onTap: onTap,
      child:
          Padding(
            padding: padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textView15(
                  context: context,
                  text: title,
                  color: textColor,
                  fontWeight: fontWeight,
                ),
                icon
              ],
            ),
          ),
    ),
  );
