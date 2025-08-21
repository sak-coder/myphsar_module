import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';
import 'package:myphsar/home/all_product/shimmer_placeholder_view.dart';
import 'package:myphsar/home/top_seller/see_all_top_seller_view.dart';
import 'package:myphsar/home/top_seller/top_seller_controller.dart';

import '../../base_widget/not_found.dart';
import '../../base_widget/reload_button.dart';
import 'top_seller_item_view.dart';

class TopSellerWidget extends StatelessWidget {
  const TopSellerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textView20(context: context, text: "top_seller".tr, color: ColorResource.darkTextColor),
              InkWell(
                  onTap: () {
                    Get.to(SeeAllTopSellerView(Get.find<TopSellerController>().getTopSellerModel));
                  },
                  child: textView13(context: context, text: "see_all".tr, color: ColorResource.primaryColor)),
            ],
          ),
        ),
        Get.find<TopSellerController>().obx(
          (state) => Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              height: 270,
              color: Colors.white10,
              child: ListView.builder(
                  itemCount: Get.find<TopSellerController>().getTopSellerModel.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TopSellerItemView(index, 310, 0, Get.find<TopSellerController>().getTopSellerModel[index],
                        ScrollController(), () {});
                  })),
          onLoading: topSellerShimmerView(context, axis: Axis.horizontal),
          onError: (s) => onErrorReloadButton(
            context,
            s.toString(),
            height: 270,
            onTap: () {
              Get.find<TopSellerController>().getTopSeller();
            },
          ),
          onEmpty: SizedBox(height: 298, child: notFound(context, 'empty_product'.tr)),
        )
      ],
    );
  }
}
