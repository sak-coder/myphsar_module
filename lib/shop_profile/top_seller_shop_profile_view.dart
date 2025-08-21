import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/base_widget/loader_view.dart';
import 'package:myphsar/shop_profile/shop_profile_controller.dart';

import '../auth/AuthController.dart';
import '../base_widget/custom_appbar_view.dart';
import '../base_widget/custom_icon_button.dart';
import '../base_widget/custom_scaffold.dart';
import '../base_widget/myphsar_text_view.dart';
import '../base_widget/not_found.dart';
import '../base_widget/reload_button.dart';
import '../base_widget/sing_in_dialog_view.dart';
import '../chat/chat_room/chat_room_view.dart';
import '../configure/config_controller.dart';
import '../home/all_product/shimmer_placeholder_view.dart';
import '../product/product_item_grid_view.dart';

class TopSellerShopProfileView extends StatefulWidget {
  final String shopId;
  final String shopName;

  const TopSellerShopProfileView({super.key, required this.shopName, required this.shopId});

  @override
  State<TopSellerShopProfileView> createState() => _TopSellerShopProfileViewState();
}

class _TopSellerShopProfileViewState extends State<TopSellerShopProfileView> with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();

  List<Widget> categoryWidget = [];

  void getProduct() async {

    await Get.find<ShopProfileController>().getShopProfile(widget.shopId.toString());
    Get.find<ShopProfileController>().clearProductList();
    Get.find<ShopProfileController>().getAllShopProduct( Get.find<ShopProfileController>().getShopProfileModel.shop!.sellerId.toString(), 1);
  //  await Get.find<ShopProfileController>().getAllShopProduct(widget.shopId.toString(), 1);
  }

  void callRequest(int offset) async {
   await Get.find<ShopProfileController>().getAllShopProduct( Get.find<ShopProfileController>().getShopProfileModel.shop!.sellerId.toString(), offset);
   // await Get.find<ShopProfileController>().getAllShopProduct(widget.shopId.toString(), offset);
  }

  @override
  void initState() {
    getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(
        context: context,
        titleText: "shop_profile".tr,
        flexibleSpace: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: customImageButton(
                  onTap: () {
                    if (!Get.find<AuthController>().isSignIn()) {
                      signInDialogView(context);
                    } else {
                      Get.to(ChatRoomView(shopId: widget.shopId, sellerId: widget.shopId, shopName: widget.shopName));
                    }
                  },
                  blur: 0,
                  padding: 10,
                  height: 50,
                  width: 50,
                  icon: Image.asset(
                    "assets/images/chat_ic.png",
                    width: 26,
                    height: 23,
                  )),
            )),
      ),
      body: Obx(() => Get.find<ShopProfileController>().getShopProfileModel.shop != null
          ? CustomScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  elevation: 1,
                  pinned: false,
                  backgroundColor: Colors.transparent,
                  expandedHeight: 250,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              customImageButton(
                                padding: 0,
                                width: 80,
                                height: 80,
                                icon: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: "assets/images/placeholder_img.png",
                                    fit: BoxFit.fitHeight,
                                    image:
                                        '${Get.find<ConfigController>().configModel.baseUrls?.baseShopImageUrl}/${Get.find<ShopProfileController>().getShopProfileModel.image}',
                                    width: 80,
                                    height: 80,
                                    imageErrorBuilder: (c, o, s) => Image.asset(
                                      "assets/images/placeholder_img.png",
                                      fit: BoxFit.fitWidth,
                                      height: 80,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textView20(
                                        context: context,
                                        text:
                                            Get.find<ShopProfileController>().getShopProfileModel.shop!.name.toString(),
                                        color: ColorResource.darkTextColor),
                                    // TextViewSize_12(
                                    //     context: context, text: widget.sellerModel.email.toString(), color: ColorResource.darkTextColor),
                                  ],
                                ),
                              ),
                              // TextViewSize_12(context: context, text: widget.sellerModel.name!)
                            ]),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: ColorResource.whiteColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(color: Colors.black26, blurRadius: 3),
                                ],
                              ),
                              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/phone_ic.png",
                                      width: 19,
                                      height: 19,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    textView15(
                                      context: context,
                                      text: Get.find<ShopProfileController>().getShopProfileModel.shop!.contact!,
                                      maxLine: 1,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Get.find<ShopProfileController>().getShopProfileModel.shop!.email != null
                                    ? Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/mail_ic.png",
                                            width: 19,
                                            height: 19,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          textView15(
                                              context: context,
                                              text: Get.find<ShopProfileController>()
                                                  .getShopProfileModel
                                                  .shop!
                                                  .email
                                                  .toString(),
                                              maxLine: 1)
                                        ],
                                      )
                                    : const SizedBox.shrink(),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/pin_ic.png",
                                      width: 19,
                                      height: 19,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: textView15(
                                            context: context,
                                            text: Get.find<ShopProfileController>().getShopProfileModel.shop!.address!,
                                            height: 1,
                                            maxLine: 2))
                                  ],
                                ),
                              ]),
                            ),
                          ],
                        )),
                  ),
                  automaticallyImplyLeading: false,
                ),
                SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverDelegate(
                      child: Container(
                        color: ColorResource.whiteColor,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: textView20(context: context, text: "product".tr, color: ColorResource.darkTextColor),
                          ),
                          // Obx(() => Container(
                          //       color: ColorResource.whiteColor,
                          //       margin: EdgeInsets.only(
                          //         left: 5,
                          //       ),
                          //       child: TabBar(
                          //           onTap: (val) => {
                          //                 Get.find<ShopProfileController>()
                          //                     .sortProductByCategory(Get.find<ShopProfileController>().getCategoryList[val])
                          //               },
                          //           labelPadding: EdgeInsets.only(left: 10, right: 10),
                          //           isScrollable: true,
                          //           indicatorWeight: 3,
                          //           // indicator:  BoxDecoration(
                          //           //   borderRadius: BorderRadius.circular(1),
                          //           //   color: ColorResource.primaryColor,
                          //           // ),
                          //           controller: tabController,
                          //           indicatorColor: ColorResource.primaryColor,
                          //           indicatorSize: TabBarIndicatorSize.label,
                          //           tabs: List.generate(
                          //               Get.find<ShopProfileController>().getCategoryList.length,
                          //               (index) => TextViewSize_20(
                          //                     context: context,
                          //                     fontWeight: FontWeight.w600,
                          //                     text: Get.find<ShopProfileController>().getCategoryList[index],
                          //                   ),
                          //               growable: true)),
                          //     ))
                        ]),
                      ),
                    )),
                SliverToBoxAdapter(
                    child: Get.find<ShopProfileController>().obx(
                        (state) => ProductItemGridView(Get.find<ShopProfileController>(),
                            Get.find<ShopProfileController>().getProductList, scrollController, callRequest),
                        onLoading: productShimmerView(context),
                        onError: (s) => onErrorReloadButton(context, s.toString(), height: 300, onTap: () {
                              getProduct();
                            }),
                        onEmpty: SizedBox(height: 298, child: notFound(context, 'empty_product'.tr))))
              ],
            )
          : loaderFullScreenView(context, true)),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 46;

  @override
  double get minExtent => 46;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 46 || oldDelegate.minExtent != 46 || child != oldDelegate.child;
  }
}
