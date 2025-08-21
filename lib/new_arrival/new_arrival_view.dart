import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_scaffold_indicator.dart';

import '../../base_colors.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../../base_widget/not_found.dart';
import '../../base_widget/reload_button.dart';
import '../../product/product_item_grid_view.dart';
import '../home/all_product/product_item_widget.dart';
import '../home/all_product/shimmer_placeholder_view.dart';
import 'new_arrival_view_controller.dart';

class NewArrivalView extends StatefulWidget {
  const NewArrivalView({super.key});

  @override
  State<NewArrivalView> createState() => _NewArrivalViewState();
}

class _NewArrivalViewState extends State<NewArrivalView> {
  ScrollController scrollController = ScrollController();

  var refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    initDat();
    super.initState();
  }

  void initDat() async {
    await Get.find<NewArrivalViewController>().getNewArrivalCategoryList(1);
    await Get.find<NewArrivalViewController>().getNewArrivalProduct(1);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldRefreshIndicator(
      color: ColorResource.bgItemColor,
      appBar: customAppBarView(context: context, titleText: "new_arrival".tr),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Get.find<NewArrivalViewController>().obx(
              (state) => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Get.find<NewArrivalViewController>().getNewArrivalCatProductList.length,
                  itemBuilder: (BuildContext context, int cateIndex) {
                    var newArrivalCate = Get.find<NewArrivalViewController>().getNewArrivalCatProductList[cateIndex];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            // onTap: () => {Get.to(SeeAllRecommendView())},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textView16(
                                  fontWeight: FontWeight.w700,
                                    context: context,
                                    text: newArrivalCate.name.toString(),
                                    color: ColorResource.darkTextColor),
                                // TextViewSize_13(
                                //     context: context, text: "See All", color: ColorResource.primaryColor),
                              ],
                            ),
                          ),
                        ),
                        Get.find<NewArrivalViewController>().obx(
                            (state) => SizedBox(
                                height: 320,
                                child: ListView.builder(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                      right: 5,
                                      bottom: 1,
                                    ),
                                    itemCount: Get.find<NewArrivalViewController>()
                                        .getNewArrivalCatProductList[cateIndex]
                                        .products!
                                        .length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
                                        child: ProductItemWidget(
                                          elevation: 0,
                                          width: 170,
                                          product: Get.find<NewArrivalViewController>()
                                              .getNewArrivalCatProductList[cateIndex]
                                              .products![index],
                                        ),
                                      );
                                    })),
                            onLoading: recommendShimmerView(context),
                            onError: (s) => onErrorReloadButton(
                                  context,
                                  s.toString(),
                                  height: 298,
                                  onTap: () {
                                    initDat();
                                  },
                                ),
                            onEmpty: SizedBox(height: 298, child: notFound(context, 'empty_product'.tr)))
                      ],
                    );
                  }),
              onLoading: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: recommendShimmerView(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
              child: textView16(context: context, text: "new_product".tr, color: ColorResource.darkTextColor,fontWeight: FontWeight.w700),
            ),
            Get.find<NewArrivalViewController>().obx(
                (state) => ProductItemGridView(Get.find<NewArrivalViewController>(),
                    Get.find<NewArrivalViewController>().getNewArrivalProductList, scrollController, callRequest),
                onLoading: productShimmerView(context),
                onError: (s) => onErrorReloadButton(context, s.toString(),
                        height: MediaQuery.of(context).size.height - 200, onTap: () {
                      Get.find<NewArrivalViewController>().getNewArrivalProduct(1);
                    }),
                onEmpty:
                    SizedBox(height: MediaQuery.of(context).size.height, child: notFound(context, 'empty_product'.tr)))
          ],
        ),
      ),
      onRefresh: () async {
        initDat();
      },
      refreshIndicatorKey: refreshIndicatorKey,
    );
  }

  void callRequest(int offset) {
    Get.find<NewArrivalViewController>().getNewArrivalProduct(offset);
  }
}
