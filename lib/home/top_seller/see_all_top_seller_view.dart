import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/not_found.dart';
import 'package:myphsar/home/all_product/shimmer_placeholder_view.dart';
import 'package:myphsar/home/top_seller/top_seller_controller.dart';
import 'package:myphsar/home/top_seller/top_seller_model.dart';

import '../../base_widget/custom_appbar_view.dart';
import '../../base_widget/custom_scaffold.dart';
import '../../base_widget/reload_button.dart';
import '../home_controller.dart';
import 'top_seller_item_view.dart';

class SeeAllTopSellerView extends StatefulWidget {
  final List<TopSellerModel> _topSellerModel;

  const SeeAllTopSellerView(this._topSellerModel, {super.key});

  @override
  State<SeeAllTopSellerView> createState() => _SeeAllTopSellerViewState();
}

class _SeeAllTopSellerViewState extends State<SeeAllTopSellerView> {
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
        appBar: customAppBarView(context: context, titleText: 'top_seller'.tr),
        body: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
            child: delay
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Get.find<TopSellerController>().obx(
                        (state) => ListView.builder(
                            itemCount: Get.find<TopSellerController>().getTopSellerModel.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return TopSellerItemView(
                                index,
                                MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.width + 50,
                                widget._topSellerModel[index],
                                scrollController,
                                callDataApiFunction,
                                imageSize: MediaQuery.of(context).size.width / 2 - 10,
                              );
                            }),
                        onEmpty: notFound(context, "empty_top_seller".tr),
                        onError: (s) => onErrorReloadButton(context, s.toString(),
                                height: MediaQuery.of(context).size.height, onTap: () {
                              Get.find<HomeController>().getRandomLatestProduct(1);
                            })))
                : topSellerShimmerView(context, axis: Axis.vertical, height: 500)));
  }

  void callDataApiFunction(int offset) {
    Get.find<HomeController>().getRecommendProduct(offset);
  }
}
