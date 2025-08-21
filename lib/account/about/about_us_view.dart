import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';
import 'package:myphsar/configure/config_controller.dart';

import '../../base_widget/title_row_icon_widget.dart';
import '../privacy/PrivacyView.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(

      appBar: customAppBarView(context: context, titleText: 'about_us'.tr,),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          children: [
            titleRowWidget(
                context: context,
                title: 'about_myphsar'.tr,
                icon: const Icon(Icons.keyboard_arrow_right_rounded),
                onTap: () {
                  Get.to(() => PrivacyPolicyView(
                        title: 'about_myphsar'.tr,
                        text: Get.find<ConfigController>().configModel.aboutUs!,
                      ));
                }),
            titleRowWidget(
                context: context,
                title: 'term_condition'.tr,
                icon: const Icon(Icons.keyboard_arrow_right_rounded),
                onTap: () {
                  Get.to(() => PrivacyPolicyView(
                        title: 'term_condition'.tr,
                        text: Get.find<ConfigController>().configModel.termsConditions!,
                      ));
                }),
            titleRowWidget(
                context: context,
                title: 'privacy_policy'.tr,
                icon: const Icon(Icons.keyboard_arrow_right_rounded),
                onTap: () {
                  Get.to(() => PrivacyPolicyView(
                        title: 'privacy_policy'.tr,
                        text: Get.find<ConfigController>().configModel.privacyPolicy!,
                      ));
                }),
            SizedBox(
              height: 45,
              child: titleRowWidget(
                  context: context,
                  title: 'app_version'.tr,
                  icon: textView16(
                      context: context,
                      text: Get.find<ConfigController>().getAppVersion,
                      color: ColorResource.lightTextColor),
                  onTap: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
