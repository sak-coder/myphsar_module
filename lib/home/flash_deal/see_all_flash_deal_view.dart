import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/home/home_controller.dart';
import 'package:myphsar/home/all_product/shimmer_placeholder_view.dart';

import '../../base_colors.dart';
import '../../base_widget/custom_appbar_view.dart';
import '../../base_widget/custom_icon_button.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../../product/product_item_grid_view.dart';
import '../../product/product_model.dart';

class SeeAllFlashDealView extends StatefulWidget {
  final List<Products> flashDealList;
  final ScrollController scrollController;

  const SeeAllFlashDealView(this.flashDealList, this.scrollController, {super.key});

  @override
  State<SeeAllFlashDealView> createState() => _SeeAllFlashDealViewState();
}

class _SeeAllFlashDealViewState extends State<SeeAllFlashDealView> {
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
        appBar: customAppBarView(context: context, titleText: "flash_deal".tr),
        body: SingleChildScrollView(
          child: delay
              ? Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5, top: 20, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              textView16(context: context, text: 'time_left'.tr, color: ColorResource.darkTextColor),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 38,
                                margin: const EdgeInsets.only(left: 10),
                                padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                                child: Row(
                                  children: [
                                    Obx(
                                      () => customTextButton(
                                          height: 30,
                                          text: textView15(
                                              context: context, text: '${Get.find<HomeController>().day.value}d'),
                                          radius: 5,
                                          blur: 2,
                                          padding: 5),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5, right: 5),
                                      child: textView15(context: context, text: ":", fontWeight: FontWeight.w900),
                                    ),
                                    Obx(
                                      () => customTextButton(
                                          height: 30,
                                          text: textView15(
                                              context: context, text: '${Get.find<HomeController>().hours.value}h'),
                                          radius: 5,
                                          blur: 2,
                                          padding: 5),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5, right: 5),
                                      child: textView15(context: context, text: ":", fontWeight: FontWeight.w900),
                                    ),
                                    Obx(
                                      () => customTextButton(
                                          height: 30,
                                          text: textView15(
                                              context: context, text: '${Get.find<HomeController>().min.value}m'),
                                          radius: 5,
                                          blur: 2,
                                          padding: 5),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5, right: 5),
                                      child: textView15(context: context, text: ":", fontWeight: FontWeight.w900),
                                    ),
                                    Obx(
                                      () =>
                                          textView15(context: context, text: Get.find<HomeController>().sec.toString()),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                      ProductItemGridView(
                          Get.find(), widget.flashDealList, widget.scrollController, callDataApiFunction)
                    ],
                  ),
                )
              : productShimmerView(context),
        ));
  }

  void callDataApiFunction() {}
}
