import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/installment_product/installment_product_view_controller.dart';
import 'package:myphsar/base_widget/custom_scaffold_indicator.dart';

import '../../base_widget/not_found.dart';
import '../../base_widget/reload_button.dart';
import '../../product/product_item_grid_view.dart';
import '../home/all_product/shimmer_placeholder_view.dart';

class InstallmentProductView extends StatefulWidget {
  const InstallmentProductView({super.key});

  @override
  State<InstallmentProductView> createState() => _InstallmentProductViewState();
}

class _InstallmentProductViewState extends State<InstallmentProductView> {
  ScrollController scrollController = ScrollController();

  var refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    initDat(1);
    super.initState();
  }

  void initDat(int offset) async {
    await Get.find<InstallmentProductViewController>().getInstallmentProductList(offset);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldRefreshIndicator(
      color: ColorResource.bgItemColor,
      appBar: customAppBarView(context: context, titleText: "installments".tr),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 5),
          controller: scrollController,
          child: Get.find<InstallmentProductViewController>().obx(
              (state) => ProductItemGridView(Get.find<InstallmentProductViewController>(),
                  Get.find<InstallmentProductViewController>().getInstallmentList, scrollController, callRequest),
              onLoading: productShimmerView(context),
              onError: (s) =>
                  onErrorReloadButton(context, s.toString(), height: MediaQuery.of(context).size.height, onTap: () {
                    initDat(1);
                  }),
              onEmpty: SizedBox(
                  height: MediaQuery.of(context).size.height, child: notFound(context, 'empty_installments'.tr)))),
      onRefresh: () async {
        Get.find<InstallmentProductViewController>().clearData();
        initDat(1);
      },
      refreshIndicatorKey: refreshIndicatorKey,
    );
  }

  void callRequest(int offset) {
    initDat(offset);
  }
}
