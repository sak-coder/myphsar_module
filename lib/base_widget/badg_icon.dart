import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import 'myphsar_text_view.dart';

Widget badgeIcon(
        {required BuildContext context,
        required String badgeText,
        double topP = -5.0,
        double endP = -5.0,
        required Widget imageIcon,
        bool visibleBadge = false}) =>
    badges.Badge(
      position: BadgePosition.topEnd(top: topP, end: endP),
      badgeAnimation: const BadgeAnimation.scale(
        animationDuration: Duration(milliseconds: 400),
        colorChangeAnimationDuration: Duration(seconds: 1),
        loopAnimation: false,
        curve: Curves.bounceIn,
        colorChangeAnimationCurve: Curves.fastOutSlowIn,
      ),
      showBadge: visibleBadge,
      // badgeStyle: BadgeStyle(padding: EdgeInsets.all(5)),
      badgeContent: Center(
          child: textView11(
              context: context, text: badgeText, color: Colors.white, fontWeight: FontWeight.w500, height: 1)),
      child: imageIcon,
    );
