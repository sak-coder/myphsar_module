import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_scaffold_indicator.dart';
import 'package:myphsar/top_selling/top_selling_view_controller.dart';

import '../../base_widget/not_found.dart';
import '../../base_widget/reload_button.dart';
import '../../product/product_item_grid_view.dart';
import '../base_colors.dart';
import '../home/all_product/shimmer_placeholder_view.dart';

class TopSellingView extends StatefulWidget {
  const TopSellingView({super.key});

  @override
  State<TopSellingView> createState() => _TopSellingViewState();
}

class _TopSellingViewState extends State<TopSellingView> {
  ScrollController scrollController = ScrollController();

  var refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    initDat();
    super.initState();
  }

  void initDat() async {
    await Get.find<TopSellingViewController>().getTopSellingProduct(1);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldRefreshIndicator(
      color: ColorResource.bgItemColor,
      appBar: customAppBarView(context: context, titleText: "top_selling".tr),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 5),
          controller: scrollController,
          child: Get.find<TopSellingViewController>().obx(
              (state) => ProductItemGridView(Get.find<TopSellingViewController>(),
                  Get.find<TopSellingViewController>().getTopSellingProductList, scrollController, callRequest),
              onLoading: productShimmerView(context),
              onError: (s) => onErrorReloadButton(context, s.toString(), height: 300, onTap: () {
                    callRequest(1);
                  }),
              onEmpty: SizedBox(height: 298, child: notFound(context, 'empty_product'.tr)))),
      onRefresh: () async {
        initDat();
      },
      refreshIndicatorKey: refreshIndicatorKey,
    );
  }

  void callRequest(int offset) {
    Get.find<TopSellingViewController>().getTopSellingProduct(offset);
  }
}
