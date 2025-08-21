import 'package:flutter/material.dart';
import 'package:myphsar/base_colors.dart';

Decoration customDecoration({
  Color color = Colors.white,
  double radius = 0,
  double shadowBlur = 0.0,
  Color borderColor = Colors.transparent,
  Offset offset = const Offset(0.1, 0.1),
  Color shadowColor = ColorResource.lightShadowColor50,
  BoxShape boxShape = BoxShape.rectangle,
}) =>
    BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      shape: boxShape,
      border: Border.all(color: borderColor),
      color: color,
      boxShadow: <BoxShadow>[BoxShadow(color: shadowColor, blurRadius: shadowBlur, offset: offset)],
    );

Decoration customDecorationOnly({
  Color color = Colors.white,
  double topLeft = 0,
  double topRight = 0,
  double bottomRight = 0,
  double bottomLeft = 0,
  BoxShape boxShape = BoxShape.rectangle,
  double shadowBlur = 0.0,
  Offset offset = const Offset(0.0, 0.0),
  Color shadowColor = Colors.black26,
}) => BoxDecoration(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topLeft),
        topRight: Radius.circular(topRight),
        bottomLeft: Radius.circular(bottomLeft),
        bottomRight: Radius.circular(bottomRight)),
    shape: boxShape,
    color: color,
    boxShadow: <BoxShadow>[BoxShadow(color: shadowColor, blurRadius: shadowBlur, offset: offset)],
  );
