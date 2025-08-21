import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';

AppBar customAppBarView(
    {required BuildContext context,
    required String titleText,
    Widget? flexibleSpace,
    Color shadowColor = const Color(0X40000000),
    double elevation = 0,
    Color bgColor = ColorResource.whiteColor,
    Color textColor = ColorResource.secondaryColor,
    bool backIconEnable = true}) {
  return AppBar(
    surfaceTintColor: Colors.white,
    title: textView15(context: context, text: titleText,fontWeight: FontWeight.w700),
    backgroundColor: bgColor,
    elevation: elevation,
    shadowColor: shadowColor,
    leading: backIconEnable
        ? IconButton(
            icon: Image.asset("assets/images/back_ic.png", width: 20, color: textColor),
            onPressed: () async => {
              if (Navigator.canPop(context))
                {
                  Navigator.maybePop(context),
                }
              else
                {SystemNavigator.pop()}
            },
          )
        : Container(),
    flexibleSpace: Center(child: flexibleSpace),
  );
}

AppBar customTextAppBarView({required BuildContext context, Widget? flexibleSpace}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    surfaceTintColor: Colors.white,
    shadowColor: const Color(0X40000000),
    flexibleSpace: flexibleSpace,
  );
}
