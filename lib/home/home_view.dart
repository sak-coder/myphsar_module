import 'dart:async';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_decoration.dart';
import 'package:myphsar/home/banner/banner_view_controller.dart';
import 'package:myphsar/home/daily_deal/daily_deal_controller.dart';
import 'package:myphsar/home/home_controller.dart';
import 'package:myphsar/home/recommend/recommend_controller.dart';
import 'package:myphsar/home/recommend/recommend_widget.dart';
import 'package:myphsar/home/search/search_view.dart';
import 'package:myphsar/home/seller/all_seller_view.dart';
import 'package:myphsar/new_arrival/new_arrival_view.dart';
import 'package:myphsar/top_selling/top_selling_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../auth/AuthController.dart';
import '../base_colors.dart';
import '../base_widget/badg_icon.dart';
import '../base_widget/custom_icon_button.dart';
import '../base_widget/custom_scaffold_indicator.dart';
import '../base_widget/input_text_field_icon.dart';
import '../base_widget/myphsar_text_view.dart';
import '../base_widget/not_found.dart';
import '../base_widget/reload_button.dart';
import '../base_widget/sing_in_dialog_view.dart';
import '../cart/cart_list/cart_list_view.dart';
import '../configure/config_controller.dart';
import '../dashborad/dash_board_controller.dart';
import '../installment_product/installment_product_view.dart';
import '../product/product_item_grid_view.dart';
import 'all_product/flash_deal_widget.dart';
import 'all_product/shimmer_placeholder_view.dart';
import 'daily_deal/daily_deals_widget.dart';

class HomeView extends StatefulWidget {
  final BuildContext globalContext;

  const HomeView({super.key, required this.globalContext});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  GlobalKey<FormState> searchKey = GlobalKey();

  var refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  ScrollController scrollController = ScrollController();
  int offSetCount = 1;
  int currentBannerIndex = 0;
  int countTimer = 0;
  late Timer timer;

  //ScrollPhysics _physics = ClampingScrollPhysics();
  // //:
  // void timerIntervalGetChat() {
  //   timer = Timer.periodic(Duration(seconds: 30), (timer) {
  //     countTimer++;
  //     if (countTimer == 21) {
  //       timer.cancel();
  //     }
  //     scrollController.animateTo(scrollController.position.maxScrollExtent + 100,
  //         duration: Duration(milliseconds: 100), curve: Curves.ease);
  //   });
  // }

  @override
  void initState() {
    getData();
    appTrackTransparency();

    super.initState();
  }

  appTrackTransparency() async {
    if (Platform.isIOS) {
      // Show tracking authorization dialog and ask for permission
      // final status = await AppTrackingTransparency.requestTrackingAuthorization();
      // If the system can show an authorization request dialog
      if (await AppTrackingTransparency.trackingAuthorizationStatus == TrackingStatus.notDetermined) {
        await Future.delayed(const Duration(milliseconds: 200));
        // Request system's tracking authorization dialog
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
    }
  }

  _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void getData() async {
    await Get.find<BannerViewController>().getMainBanner();
    await Get.find<BannerViewController>().getFooterBanner();
    await Get.find<HomeController>().getRandomLatestProduct(1);
    // await Get.find<TopSellerController>().getTopSeller();
    await Get.find<RecommendController>().getRecommendProduct(1);
    await Get.find<HomeController>().getFlashDeal();
    await Get.find<DailyDealController>().getDailyDealProduct();

    // await Get.find<CartController>().getAllCartList();
    Get.find<DashBoardController>().listener.stream.listen((event) {
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 1000), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldRefreshIndicator(
      body: CustomScrollView(
        controller: scrollController,
        // physics: _physics,
        slivers: [
          SliverAppBar(
            elevation: 1.5,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shadowColor: const Color(0X40000000),
            pinned: true,
            expandedHeight: 450,
            title: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10, right: 5),
                    child: InkWell(
                      onTap: () async {
                        Get.to(() => const SearchView());
                        // opaque: false, popGesture: true, transition: Transition.noTransition);
                      },
                      child: SizedBox(
                        height: 45,
                        child: InputTextFieldWithIcon(
                          formKey: searchKey,
                          enable: false,
                          hintTxt: "search".tr,
                          imageIcon: Image.asset(
                            "assets/images/search_ic.png",
                            width: 19,
                            height: 19,
                          ),
                          textInputAction: TextInputAction.search,
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(() => badgeIcon(
                    topP: -2,
                    endP: -2,
                    visibleBadge: Get.find<HomeController>().cartCount > 0 ? true : false,
                    context: context,
                    badgeText: Get.find<HomeController>().cartCount.toString(),
                    imageIcon: customImageButton(
                      padding: 11,
                      radius: 10,
                      width: 45,
                      height: 45,
                      onTap: () async {

                        if (!Get.find<AuthController>().isSignIn()) {
                          signInDialogView(widget.globalContext);
                        } else {
                          Get.to(() => const CartListView());
                        }
                      },
                      blur: 0,
                      icon: Image.asset(
                        "assets/images/basket_ic.png",
                        width: 24,
                        height: 24,
                      ),
                    )))
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              // background:HeaderWidget(),
              background: Stack(
                children: [
                  Stack(children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      height: 340.0,
                      child: Obx(() => Get.find<BannerViewController>().getMainBannerModel.bannerModelList != null &&
                              Get.find<BannerViewController>().getMainBannerModel.bannerModelList!.isNotEmpty
                          ? CarouselSlider.builder(
                              options: CarouselOptions(
                                viewportFraction: 1.0,
                                aspectRatio: 20 / 9,
                                //    autoPlayCurve: Curves.fastOutSlowIn,
                                autoPlayAnimationDuration: const Duration(seconds: 2),
                                autoPlayInterval: const Duration(seconds: 7),
                                autoPlay:
                                    Get.find<BannerViewController>().getMainBannerModel.bannerModelList!.length == 1
                                        ? false
                                        : true,
                                // enlargeCenterPage: true,
                                disableCenter: true,
                                onPageChanged: (index, reason) {
                                  currentBannerIndex = index;
                                  // setState(() {
                                  //   currentBannerIndex = index;
                                  // });
                                },
                              ),
                              itemCount: Get.find<BannerViewController>().getMainBannerModel.bannerModelList!.length,
                              itemBuilder: (context, index, _) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: "assets/images/placeholder_img.png",
                                    width: 150,
                                    placeholderFit: BoxFit.fitHeight,
                                    fit: BoxFit.fill,
                                    image: '${Get.find<ConfigController>().configModel.baseUrls?.baseBannerImageUrl}'
                                        '/${Get.find<BannerViewController>().getMainBannerModel.bannerModelList![index].photo}',
                                    imageErrorBuilder: (c, o, s) => Image.asset(
                                      "assets/images/placeholder_img.png",
                                      fit: BoxFit.fitHeight,
                                      width: 150,
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Image.asset(
                              "assets/images/placeholder_img.png",
                              fit: BoxFit.fill,
                              width: 150,
                            ))),
                    ),
                    InkWell(
                      onTap: () => {
                        _launchUrl(Get.find<BannerViewController>()
                            .getMainBannerModel
                            .bannerModelList![currentBannerIndex]
                            .url
                            .toString())
                      },
                      child: Container(
                        height: 340.0,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                                begin: FractionalOffset.center,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                                  Color.fromRGBO(213, 212, 212, 0.0),
                                  Colors.white,
                                ],
                                stops: [
                                  0.3,
                                  1
                                ])),
                      ),
                    ),
                  ]),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: (210),
                      // margin: EdgeInsets.only(top: (10 + MediaQuery.of(context).viewPadding.top)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: InkWell(
                                      onTap: (() => {Get.to(() => const AllSellerView())}),
                                      child: Container(
                                        decoration: customDecoration(
                                            shadowBlur: 1,
                                            shadowColor: ColorResource.lightShadowColor50,
                                            color: const Color(0xFFE3F0E7),
                                            radius: 10),
                                        height: 90,
                                        padding: const EdgeInsets.only(left: 10, top: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: textView18(
                                                  fontWeight: FontWeight.w700,
                                                  context: context,
                                                  color: ColorResource.lightTextColor,
                                                  text: 'brand'.tr,
                                                )),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Image.asset(
                                                "assets/images/brand_ic.png",
                                                width: 67,
                                                height: 50,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: InkWell(
                                      onTap: () {
                                        Get.to(() => const TopSellingView());
                                      },
                                      child: Container(
                                        decoration: customDecoration(
                                            shadowBlur: 1,
                                            shadowColor: ColorResource.lightShadowColor50,
                                            color: const Color(0xFFF0ECFC),
                                            radius: 10),
                                        height: 90,
                                        padding: const EdgeInsets.only(left: 10, top: 10, right: 5),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: textView18(
                                                  fontWeight: FontWeight.w700,
                                                  context: context,
                                                  color: ColorResource.lightTextColor,
                                                  text: 'top_selling'.tr,
                                                )),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Image.asset(
                                                "assets/images/top_seller_ic.png",
                                                width: 62,
                                                height: 54,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: InkWell(
                                      onTap: () {
                                        Get.to(const NewArrivalView());
                                      },
                                      child: Container(
                                        decoration: customDecoration(
                                            shadowBlur: 1,
                                            shadowColor: ColorResource.lightShadowColor50,
                                            color: const Color(0xFFFCEBE7),
                                            radius: 10),
                                        height: 90,
                                        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5, right: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: textView18(
                                                  fontWeight: FontWeight.w700,
                                                  context: context,
                                                  color: ColorResource.lightTextColor,
                                                  text: 'new_arrival'.tr,
                                                )),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Image.asset(
                                                "assets/images/new_arrival_ic.png",
                                                width: 50,
                                                height: 50,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: InkWell(
                                      onTap: () {
                                        Get.to(() => const InstallmentProductView());
                                      },
                                      child: Container(
                                        decoration: customDecoration(
                                            shadowBlur: 1,
                                            shadowColor: ColorResource.lightShadowColor50,
                                            color: const Color(0xFFF6F7F9),
                                            radius: 10),
                                        height: 90,
                                        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: textView18(
                                                  fontWeight: FontWeight.w700,
                                                  color: ColorResource.lightTextColor,
                                                  context: context,
                                                  text: 'installments'.tr,
                                                )),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Image.asset(
                                                "assets/images/special_ic.png",
                                                width: 70,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          SliverToBoxAdapter(
            child: Container(
              color: ColorResource.bgItemColor,
              child: Column(
                children: [
                  /* Flash Deal Container*/
                  Obx(() => Get.find<HomeController>().getFlashDealListModel.length > 0
                      ? FlashDealWidget(scrollController)
                      : const SizedBox()),

                  // /*Top Seller Widget*/
                  // TopSellerWidget(),
                  //
                  // /*Recommend Product*/
                  const RecommendWidget(),
                  //
                  // /*Recommend Product*/
                  Obx(() => Get.find<DailyDealController>().getDailyDealProductListModel.length > 0
                      ? const DailyDealsWidget()
                      : const SizedBox()),

                  /*All Product*/
                  //  AllProductWidget(scrollController),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
                        child: textView16(
                            fontWeight: FontWeight.w700,
                            context: context,
                            text: "all_product".tr,
                            color: ColorResource.darkTextColor),
                      ),
                      Get.find<HomeController>().obx(
                          (state) => ProductItemGridView(Get.find<HomeController>(),
                              Get.find<HomeController>().getRandomProductList, scrollController, callRequest),
                          onLoading: productShimmerView(context),
                          onError: (s) => onErrorReloadButton(context, s.toString(), height: 300, onTap: () {
                                Get.find<HomeController>().getRandomLatestProduct(1);
                              }),
                          onEmpty: SizedBox(height: 298, child: notFound(context, 'empty_product'.tr)))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      onRefresh: () async {
        Get.find<HomeController>().clearAllData();
        getData();
      },
      topSafeArea: false,
    );
  }

  void callRequest(int offset) {
    Get.find<HomeController>().getRandomLatestProduct(offset);
  }
}
