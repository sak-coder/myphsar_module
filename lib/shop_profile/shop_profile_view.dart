import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/chat/chat_room/chat_room_view.dart';
import 'package:myphsar/shop_profile/shop_profile_controller.dart';
import 'package:myphsar/shop_profile/shop_profile_model.dart';

import '../auth/AuthController.dart';
import '../base_widget/custom_appbar_view.dart';
import '../base_widget/custom_icon_button.dart';
import '../base_widget/custom_scaffold.dart';
import '../base_widget/myphsar_text_view.dart';
import '../base_widget/not_found.dart';
import '../base_widget/reload_button.dart';
import '../base_widget/sing_in_dialog_view.dart';
import '../configure/config_controller.dart';
import '../home/all_product/shimmer_placeholder_view.dart';
import '../product/product_item_grid_view.dart';

class ShopProfileView extends StatefulWidget {
  final ShopProfileModel sellerModel;

  const ShopProfileView(this.sellerModel, {super.key});

  @override
  State<ShopProfileView> createState() => _ShopProfileViewState();
}

class _ShopProfileViewState extends State<ShopProfileView> with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();

  List<Widget> categoryWidget = [];

  @override
  void initState() {
    getProduct();
    super.initState();
  }

  void getProduct() async {
    Get.find<ShopProfileController>().clearProductList();
    await Get.find<ShopProfileController>().getAllShopProduct(widget.sellerModel.shop!.sellerId.toString(), 1);
  }

  void callRequest(int offset) async {
    await Get.find<ShopProfileController>().getAllShopProduct(widget.sellerModel.shop!.sellerId.toString(), offset);
  }

  @override
  Widget build(BuildContext context) {
  //  var tabController = TabController(vsync: this, length: Get.find<ShopProfileController>().getCategoryList.length);
    return CustomScaffold(
      backGroundColor: ColorResource.bgItemColor,
        appBar: customAppBarView(
          context: context,
          titleText: "shop".tr,
          flexibleSpace: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: customImageButton(
                    onTap: () {
                      if (!Get.find<AuthController>().isSignIn()) {
                        signInDialogView(context);
                      } else {
                        Get.to(ChatRoomView(
                            shopId: widget.sellerModel.id.toString(),
                            sellerId: widget.sellerModel.id.toString(),
                            shopName: widget.sellerModel.shop!.name.toString()));
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
        body: SingleChildScrollView(

            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                    color: ColorResource.whiteColor,
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
                            onTap: () {},
                            icon:   FadeInImage.assetNetwork(
                                placeholder: "assets/images/placeholder_img.png",
                                fit: BoxFit.contain,
                                image: '${Get.find<ConfigController>().configModel.baseUrls?.baseShopImageUrl}/${widget.sellerModel.shop!.image}',
                                width: 80,
                                height: 80,
                                imageErrorBuilder: (c, o, s) => Image.asset(
                                  "assets/images/placeholder_img.png",
                                  fit: BoxFit.fitWidth,
                                  height: 80,
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
                                    text: widget.sellerModel.shop!.name.toString(),
                                    maxLine: 2,
                                    color: ColorResource.darkTextColor),
                                const SizedBox(
                                  height: 5,
                                ),
                                widget.sellerModel.verified == 1
                                    ? Wrap(
                                        crossAxisAlignment: WrapCrossAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 5),
                                            child: textView14(
                                                context: context,
                                                text: "Verified",
                                                maxLine: 2,
                                                color: ColorResource.lightTextColor),
                                          ),
                                          const Icon(
                                            Icons.verified,
                                            size: 17,
                                            color: Colors.lightBlueAccent,
                                          ),
                                        ],
                                      )
                                    : const SizedBox.shrink()

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
                              BoxShadow(color: Colors.black26, blurRadius: 1),
                            ],
                          ),
                          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/phone_ic.png",
                                  width: 15,
                                  height: 15,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                textView15(
                                  context: context,
                                  text: widget.sellerModel.shop!.contact.toString(),
                                  maxLine: 1,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            widget.sellerModel.shop!.email != null
                                ? Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/mail_ic.png",
                                        width: 15,
                                        height: 15,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      textView15(
                                          context: context, text: widget.sellerModel.shop!.email.toString(), maxLine: 1)
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
                                  width: 15,
                                  height: 15,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: textView15(
                                        context: context,
                                        text: widget.sellerModel.shop!.address.toString(),
                                        height: 1,
                                        maxLine: 2))
                              ],
                            ),
                          ]),
                        ),
                      ],
                    )),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: textView20(context: context, text: "product".tr, color: ColorResource.darkTextColor),
                  ),
                ),
                Get.find<ShopProfileController>().obx(
                    (state) => ProductItemGridView(Get.find<ShopProfileController>(),
                        Get.find<ShopProfileController>().getProductList, scrollController, callRequest),
                    onLoading: productShimmerView(context),
                    onError: (s) => onErrorReloadButton(context, s.toString(), height: 300, onTap: () {
                          getProduct();
                        }),
                    onEmpty: SizedBox(height: 298, child: notFound(context, 'empty_product'.tr)))
              ],
            )));
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
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 || oldDelegate.minExtent != 50 || child != oldDelegate.child;
  }
}
