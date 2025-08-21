import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../base_widget/custom_appbar_view.dart';
import '../../base_widget/not_found.dart';
import '../../base_widget/reload_button.dart';
import '../../configure/config_controller.dart';
import '../../product/product_item_grid_view.dart';
import '../all_product/shimmer_placeholder_view.dart';
import '../banner/banner_view_controller.dart';
import 'daily_deal_controller.dart';

class SeeAllDailyDealView extends StatefulWidget {
  const SeeAllDailyDealView({super.key});

  @override
  State<SeeAllDailyDealView> createState() => _SeeAllDailyDealViewState();
}

class _SeeAllDailyDealViewState extends State<SeeAllDailyDealView> {
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
        topSafeArea: false,
        appBar: customAppBarView(context: context, titleText: 'daily_deals'.tr),
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 5),
            controller: scrollController,
            child: delay
                ? Column(
                    children: [
                      Get.find<BannerViewController>().getFooterBannerModel.bannerModelList!.isNotEmpty
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 160,
                              child: Obx(() => CarouselSlider.builder(
                                    options: CarouselOptions(
                                      viewportFraction: 1.0,
                                      aspectRatio: 20 / 9,
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      autoPlayAnimationDuration: const Duration(seconds: 2),
                                      autoPlayInterval: const Duration(seconds: 10),
                                      autoPlay: true,
                                      // enlargeCenterPage: true,
                                      disableCenter: true,
                                      onPageChanged: (index, reason) {},
                                    ),
                                    itemCount:
                                        Get.find<BannerViewController>().getFooterBannerModel.bannerModelList!.length,
                                    itemBuilder: (context, index, _) {
                                      return Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: InkWell(
                                          onTap: () => {
                                            _launchUrl(Get.find<BannerViewController>()
                                                .getFooterBannerModel
                                                .bannerModelList![index]
                                                .url
                                                .toString())
                                          },
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width,
                                            child: FadeInImage.assetNetwork(
                                              placeholder: "assets/images/brand_ic.png",
                                              fit: BoxFit.fill,
                                              image:
                                                  '${Get.find<ConfigController>().configModel.baseUrls?.baseBannerImageUrl}'
                                                  '/${Get.find<BannerViewController>().getFooterBannerModel.bannerModelList![index].photo}',
                                              imageErrorBuilder: (c, o, s) =>
                                                  Image.asset("assets/images/fb_ic.png", fit: BoxFit.fill),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            )
                          : const SizedBox.shrink(),
                      Container(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Get.find<DailyDealController>().obx(
                              (state) => ProductItemGridView(
                                  Get.find(),
                                  Get.find<DailyDealController>().getDailyDealProductListModel,
                                  scrollController,
                                  callDataApiFunction),
                              onLoading: productShimmerView(context),
                              onError: (s) => onErrorReloadButton(
                                    context,
                                    s.toString(),
                                    height: 298,
                                    onTap: () {
                                      Get.find<DailyDealController>().getDailyDealProduct();
                                    },
                                  ),
                              onEmpty: SizedBox(height: 298, child: notFound(context, 'empty_product'.tr)))),
                    ],
                  )
                : productShimmerView(context)));
  }

  void callDataApiFunction(int offset) {}

  _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
