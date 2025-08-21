import 'dart:ui';

import 'package:flutter/material.dart';

enum CustomIconAlign {
  left,
  right;
}

Widget customImageTextButton(
    {double? width,
    required double height,
    Function()? onTap,
    required Widget icon,
    Widget text = const SizedBox(),
    double padding = 10,
    double leftPadding = 10,
    double blur = 3,
    double radius = 100,
    EdgeInsetsGeometry? margin,
    Color color = Colors.white,
    Color shadowColor = Colors.black26,
    iconAlign = CustomIconAlign.left,
    textAlignment = Alignment.centerLeft,
    align = MainAxisAlignment.start}) => Container(
      height: height,
      width: width,
      margin: margin,
      // margin: EdgeInsets.only(left: 20, right: 5),
      alignment: textAlignment,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        boxShadow: [
          BoxShadow(color: shadowColor, blurRadius: blur),
        ],
      ),
      child: Material(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
              onTap: onTap,
              child: Container(
                  //    padding: EdgeInsets.only(left: leftPadding + 10, right: padding + 5, top: padding, bottom: padding),
                  padding: EdgeInsets.only(left: leftPadding, right: padding + 5, top: padding, bottom: padding),
                  height: height,
                  child: iconAlign == CustomIconAlign.left
                      ? Row(
                          mainAxisAlignment: align,
                          children: [
                            icon,
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(child: text)
                          ],
                        )
                      : Row(
                          mainAxisAlignment: align,
                          children: [Expanded(child: text), icon],
                        )))));

Widget customImageButton({
  double? width,
  required double height,
  Function()? onTap,
  required Widget icon,
  Widget text = const SizedBox(),
  double padding = 10,
  double blur = 3,
  double radius = 100,
  Color color = Colors.white,
  double margin = 0,
  Color shadowColor = Colors.black26,
}) => Container(
      height: height,
      width: width,
      margin: EdgeInsets.all(margin),
      // margin: EdgeInsets.only(left: 20, right: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        boxShadow: [
          BoxShadow(color: shadowColor, blurRadius: blur),
        ],
      ),
      child: Material(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          clipBehavior: Clip.hardEdge,
          child: InkWell(onTap: onTap, child: Padding(padding: EdgeInsets.all(padding), child: icon))));

Widget customTextButton({
  double? width,
  double? height,
  Function()? onTap,
  required Widget text,
  double padding = 10,
  double blur = 3,
  double radius = 100,
  AlignmentDirectional? alignmentDirectional,
  EdgeInsetsGeometry? margin,
  Color borderColor = Colors.transparent,
  Color color = Colors.white,
}) => Container(
      alignment: alignmentDirectional,
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(color: blur == 0 ? Colors.transparent : Colors.black26, blurRadius: blur),
        ],
      ),
      child: Material(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: text,
              ))));

Widget customImageButtonShadowBg({
  required double padding,
  double width = 36,
  double height = 36,
  required Function() onTap,
  required Widget icon,
  double radius = 100,
  double blur = 3,
  Color color = Colors.white,
}) => ClipRRect(
    borderRadius: BorderRadius.all(
      Radius.circular(radius),
    ),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(0.6)),
          child: InkWell(onTap: onTap, child: icon)),
    ),
  );

Widget customImageButtonShadow() => ClipRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Container(
        width: 36.0,
        height: 36.0,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(100),
            ),
            color: Colors.grey.shade200.withOpacity(0.5)),
        child: Center(
          child: Image.asset(
            "assets/images/love_ic.png",
            width: 24,
            height: 24,
          ),
        ),
      ),
    ),
  );
