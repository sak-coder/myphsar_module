import 'package:flutter/cupertino.dart';

Widget withBackGroundTextContainer(
    {double? w,
    double? h,
    required Text text,
    double radius = 0,
    required Color containerBgColor,
    double padding = 2}) => Container(
      constraints: BoxConstraints.tightFor(width: w, height: h),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(color: containerBgColor, borderRadius: BorderRadius.circular(radius)),
      child: text);
