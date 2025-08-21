import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';

import 'custom_icon_button.dart';
import 'myphsar_text_view.dart';

Widget reloadButton(BuildContext context, int statusCode, String errorMessage) => Visibility(
      visible: statusCode == 200 ? false : true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customImageButtonShadowBg(
              padding: 5,
              radius: 10,
              width: 100,
              height: 50,
              onTap: () {},
              icon: const Icon(
                Icons.refresh,
              )),
          textView15(context: context, text: errorMessage, maxLine: 3)
        ],
      ));

Widget onErrorReloadButton(BuildContext context, String errorMessage,
    {required Function() onTap, double height = 100}) => Container(
    height: height,
    padding: const EdgeInsets.only(left: 20, right: 20),
    width: MediaQuery.of(context).size.width,
    color: ColorResource.lightGrayBgColor,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        textView15(
            context: context,
            text: 'error_response_msg'.tr,
            maxLine: 3,
            color: ColorResource.darkTextColor,
            fontWeight: FontWeight.w700),
        const SizedBox(
          height: 5,
        ),
        textView13(
            context: context,
            text: 'error_response_msg_body'.tr,
            maxLine: 3,
            color: ColorResource.lightTextColor,
            textAlign: TextAlign.center),
        textView12(
          height: 2,
            context: context,
            text: errorMessage,
            maxLine: 3,
            color: ColorResource.lightTextColor,
            ),
        const SizedBox(
          height: 20,
        ),
        customImageTextButton(

            padding: 5,
            blur: 0,
            radius: 10,
            width: 120,
            height: 45,
            onTap: onTap, text: textView15(context: context, text: "Reload"), icon: Icon(Icons.refresh_rounded),
             ),
      ],
    ),
  );
