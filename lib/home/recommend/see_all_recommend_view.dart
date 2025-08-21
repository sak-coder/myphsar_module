import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/base_widget/reload_button.dart';

import '../../base_colors.dart';
import '../../base_widget/custom_appbar_view.dart';
import '../../base_widget/not_found.dart';
import '../../product/product_item_grid_view.dart';
import '../all_product/shimmer_placeholder_view.dart';
import 'recommend_controller.dart';

class SeeAllRecommendView extends StatefulWidget {
  const SeeAllRecommendView({super.key});

  @override
  State<SeeAllRecommendView> createState() => _SeeAllRecommendViewState();
}

class _SeeAllRecommendViewState extends State<SeeAllRecommendView> {
  ScrollController scrollController = ScrollController();
  bool delay = false;
  Timer? timer;

  @override
  void initState() {
    timer = Timer(const Duration(seconds: 1), () async {
      setState(() {
        delay = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backGroundColor: ColorResource.bgItemColor,
        appBar: customAppBarView(
          context: context,
          titleText: "recomend_for_you".tr,
        ),
        body: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.only(top: 10),
            child: delay
                ? Get.find<RecommendController>().obx(
                    (state) => ProductItemGridView(
                          Get.find<RecommendController>(),
                          Get.find<RecommendController>().getRecommendProductList,
                          scrollController,
                          callDataApiFunction,
                          paddingBottom: 30,
                        ),
                    onLoading: productShimmerView(context),
                    onError: (s) => onErrorReloadButton(context, s.toString(),
                            height: MediaQuery.of(context).size.height, onTap: () {
                          Get.find<RecommendController>().getRandomLatestProduct(1);
                        }),
                    onEmpty: SizedBox(
                        height: MediaQuery.of(context).size.height, child: notFound(context, 'empty_product'.tr)))
                : productShimmerView(context)));
  }

  void callDataApiFunction(int offset) {
    Get.find<RecommendController>().getRecommendProduct(offset);
  }
}
