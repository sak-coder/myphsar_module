import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/home/recommend/recommend_controller.dart';

import '../../base_colors.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../../base_widget/not_found.dart';
import '../../base_widget/reload_button.dart';
import '../all_product/shimmer_placeholder_view.dart';
import '../all_product/vertical_product_item_widget.dart';
import 'see_all_recommend_view.dart';

class RecommendWidget extends StatelessWidget {
  const RecommendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () => {Get.to(const SeeAllRecommendView())},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textView16(
                      fontWeight: FontWeight.w800,
                      context: context,
                      text: "recomend_for_you".tr,
                      color: ColorResource.darkTextColor),
                  textView13(context: context, text: "see_all".tr, color: ColorResource.primaryColor),
                ],
              ),
            ),
          ),
          Get.find<RecommendController>().obx(
              (state) => SizedBox(
                  height: 315,
                  child: ListView.builder(
                      padding: const EdgeInsets.only(
                        left: 5,
                        right: 5,
                        bottom: 1,
                      ),
                      itemCount: Get.find<RecommendController>().getRecommendProductList.length, //Limit display 20
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
                          child: VerticalProductItemWidget(
                            maxLine: 2,
                            width: 170,
                            product: Get.find<RecommendController>().getRecommendProductList[index],
                          ),
                        );
                      })),
              onLoading: recommendShimmerView(context),
              onError: (s) => onErrorReloadButton(
                    context,
                    s.toString(),
                    height: 298,
                    onTap: () {
                      Get.find<RecommendController>().getRecommendProduct(1);
                    },
                  ),
              onEmpty: SizedBox(height: 298, child: notFound(context, ' Product Empty')))
        ],

    );
  }
}
