import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/home/all_product/vertical_product_item_widget.dart';
import 'package:myphsar/home/banner/banner_view_controller.dart';
import 'package:myphsar/home/daily_deal/daily_deal_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../base_colors.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../../base_widget/not_found.dart';
import '../../base_widget/reload_button.dart';
import '../all_product/shimmer_placeholder_view.dart';
import 'see_all_daily_deal_view.dart';

class DailyDealsWidget extends StatelessWidget {
  const DailyDealsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textView16(
                    fontWeight: FontWeight.w800,
                    context: context,
                    text: "daily_deals".tr,
                    color: ColorResource.darkTextColor),
                InkWell(
                    onTap: () => {Get.to(const SeeAllDailyDealView())},
                    child: textView13(context: context, text: "see_all".tr, color: ColorResource.primaryColor)),
              ],
            ),
          ),
          Obx(
            () => Get.find<BannerViewController>().getFooterBannerModel.bannerModelList!.length > 0 &&
                    Get.find<BannerViewController>().getFooterBannerModel.bannerModelList != null
                ? Container()
                : const SizedBox.shrink(),
          ),
          SizedBox(
              height: 305,
              child: Get.find<DailyDealController>().obx(
                  (state) => ListView.builder(
                      padding: const EdgeInsets.only(
                        left: 5,
                        right: 5,
                        bottom: 1,
                      ),
                      itemCount: Get.find<DailyDealController>().getDailyDealProductListModel.length, //Limit display 20
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
                          child: VerticalProductItemWidget(
                            maxLine: 2,
                            width: 170,
                            product: Get.find<DailyDealController>().getDailyDealProductListModel[index],
                          ),
                        );
                      }),
                  onLoading: dailyDealShimmerView(context),
                  onError: (s) => onErrorReloadButton(
                        context,
                        s.toString(),
                        height: 298,
                        onTap: () {
                          Get.find<DailyDealController>().getDailyDealProduct();
                        },
                      ),
                  onEmpty: SizedBox(height: 298, child: notFound(context, 'empty_product'.tr))))
        ],
      ),
    );
  }

  _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
