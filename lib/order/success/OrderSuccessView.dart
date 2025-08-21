import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/dashborad/dash_board_view.dart';

import '../../app_constants.dart';
import '../../base_colors.dart';
import '../../base_widget/custom_icon_button.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../../check_out/check_out_controller.dart';
import '../../helper/share_pref_controller.dart';

class OrderSuccessView extends StatelessWidget {
  final bool? successStatus;

  const OrderSuccessView( {super.key, required this.successStatus });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    successStatus==true? Icons.check_circle_outline_rounded:Icons.cancel_outlined,
                    size: 100,
                    color: successStatus==true? ColorResource.greenColor:ColorResource.primaryColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: textView20(fontWeight: FontWeight.w700, context: context, text: successStatus==true ? "order_completed".tr:"order_fail".tr),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: textView15(
                        color: ColorResource.lightTextColor,
                        context: context,
                        text: "${'order'.tr} ${'order_failed'.tr}"),
                  ),
                  successStatus==true? Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: textView15(
                        textAlign: TextAlign.center,
                        color: ColorResource.lightTextColor,
                        maxLine: 2,
                        context: context,
                        text: 'send_receipt_to'.tr + Get.find<SharePrefController>().getUserProfile().email.toString()),
                  ): const SizedBox.shrink(),
                    successStatus==true? customTextButton(
                      onTap: () async {

                       Navigator.popUntil(context, ModalRoute.withName('/'));

                      },
                      blur: 1,
                      text: Center(
                        child: textView16(
                          context: context,
                          text: 'my_order'.tr,
                          fontWeight: FontWeight.w700,
                          color: ColorResource.greenColor,
                        ),
                      ),
                      color: ColorResource.whiteColor,
                      radius: 10,
                      height: 50):const SizedBox.shrink(),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextButton(
                      onTap: () async {

                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      },
                      text: Center(
                        child: textView16(
                          context: context,
                          text: 'continue_shopping'.tr,
                          fontWeight: FontWeight.w600,
                          color: ColorResource.whiteColor,
                        ),
                      ),
                      color: ColorResource.greenColor,
                      radius: 10,
                      height: 50),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textView12(
                  color: ColorResource.lightTextColor,
                  maxLine: 2,
                  context: context,
                  text: 'support_text'.tr,
                ),
                customTextButton(
                    text: textView13(
                      color: ColorResource.greenColor,
                      fontWeight: FontWeight.w700,
                      maxLine: 2,
                      context: context,
                      text: 'contact'.tr,
                    ),
                    blur: 0,
                    radius: 1,
                    onTap: () {})
              ],
            )
          ],
        ),
      ),
    );
  }
}
