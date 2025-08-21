import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_decoration.dart';
import 'package:myphsar/cart/cart_controller.dart';
import 'package:myphsar/check_out/check_out_view.dart';
import 'package:myphsar/base_widget/custom_scaffold_indicator.dart';
import 'package:myphsar/dashborad/dash_board_view.dart';

import '../../base_colors.dart';
import '../../base_widget/custom_appbar_view.dart';
import '../../base_widget/custom_confirm_dialog_view.dart';
import '../../base_widget/custom_icon_button.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../../base_widget/not_found.dart';
import '../../base_widget/reload_button.dart';
import '../../configure/config_controller.dart';
import '../../home/all_product/shimmer_placeholder_view.dart';
import '../../utils/price_converter.dart';

class CartListView extends StatefulWidget {
  const CartListView({super.key});

  @override
  State<CartListView> createState() => _CartListViewState();
}

class _CartListViewState extends State<CartListView> {
  int currentSellerId = 0;

  List<dynamic> cartModelList = [];

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    await Get.find<CartController>().getAllCartList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldRefreshIndicator(
      appBar: customAppBarView(context: context, titleText: 'cart'.tr),
      body: Container(
        color: Colors.white,
        child: Get.find<CartController>().obx(
            (state) => Obx(
                  () => ListView.builder(
                      itemCount: Get.find<CartController>().getCartModelList.length,
                      itemBuilder: (BuildContext context, int index) {
                        cartModelList = Get.find<CartController>().getCartModelList;

                        if (cartModelList[index].sellerId != currentSellerId) {
                          cartModelList[index].isDisplaySeller = true;
                          currentSellerId = cartModelList[index].sellerId;
                        }
                        if (cartModelList.length == 1) {
                          cartModelList[index].isDisplaySeller = true;
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            cartModelList[index].isDisplaySeller == true
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                                    child: textView15(
                                        fontWeight: FontWeight.w700,
                                        context: context,
                                        text: cartModelList[index].shopInfo),
                                  )
                                : Container(),
                            Container(
                              decoration: customDecoration(
                                  radius: 10, shadowBlur: 2, shadowColor: ColorResource.lightShadowColor50),
                              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                              padding: const EdgeInsets.only(left: 10,bottom: 5,top: 5),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    height: 90,
                                    width: 90,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: FadeInImage.assetNetwork(
                                          placeholder: "assets/images/placeholder_img.png",
                                          placeholderFit: BoxFit.contain,
                                          fadeInDuration: const Duration(seconds: 1),
                                          fit: BoxFit.contain,
                                          image:
                                              '${Get.find<ConfigController>().configModel.baseUrls?.baseProductThumbnailUrl}/${cartModelList[index].thumbnail}',
                                          imageErrorBuilder: (c, o, s) => Image.asset(
                                            "assets/images/placeholder_img.png",
                                            fit: BoxFit.contain,
                                          ),
                                        )),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: textView15(
                                                  context: context,
                                                  text: cartModelList[index].name!,
                                                  maxLine: 2,
                                                  color: ColorResource.darkTextColor,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.2),
                                            )),
                                            customImageButton(
                                                padding: 10,
                                                onTap: () {
                                                  customConfirmDialogView(
                                                      context: context,
                                                      title: 'delete_confirm_msg'.tr,
                                                      positiveText: 'yes'.tr,
                                                      negativeText: 'no'.tr,
                                                      positive: () {
                                                        Get.find<CartController>().deleteCartProduct(
                                                            context, cartModelList[index].id.toString(), index,null);
                                                        Navigator.pop(context);
                                                      });
                                                },
                                                blur: 0,
                                                height: 40,
                                                width: 40,
                                                radius: 100,
                                                icon: Image.asset(
                                                  "assets/images/delete_ic.png",
                                                  width: 15,
                                                )),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: textView12(
                                              context: context,
                                              text: cartModelList[index].variant,
                                              fontWeight: FontWeight.w600,
                                              color: ColorResource.lightTextColor),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            textView15(
                                                context: context,
                                                text: PriceConverter.currencySignAlignment(
                                                    cartModelList[index].price! - cartModelList[index].discount!),
                                                maxLine: 1,
                                                fontWeight: FontWeight.w600,
                                                color: ColorResource.primaryColor),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 5),
                                              child: Row(
                                                children: [
                                                  customImageButton(
                                                      blur: 0,
                                                      padding: 0,
                                                      onTap: () async {
                                                        if (cartModelList[index].quantity > 1) {
                                                          var qty = cartModelList[index].quantity - 1;
                                                          Get.find<CartController>().minusQty(
                                                            qty,
                                                            index,
                                                          );
                                                          await Get.find<CartController>().updateCartProductQty(
                                                              context, cartModelList[index].id!, qty);
                                                        }
                                                      },
                                                      icon: Icon(
                                                        Icons.remove_circle_outlined,
                                                        color: cartModelList[index].quantity == 1
                                                            ? ColorResource.primaryColor05
                                                            : ColorResource.primaryColor,
                                                        size: 25,
                                                      ),
                                                      height: 40,
                                                      width: 40),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 5, right: 5),
                                                    child: textView20(
                                                        context: context,
                                                        text: Get.find<CartController>()
                                                            .getCartModelList[index]
                                                            .quantity
                                                            .toString(),
                                                        color: ColorResource.darkTextColor),
                                                  ),
                                                  customImageButton(
                                                      blur: 0,
                                                      padding: 0,
                                                      onTap: () async {
                                                        var qty = cartModelList[index].quantity + 1;
                                                          Get.find<CartController>().plusQty(qty, index);
                                                        await Get.find<CartController>().updateCartProductQty(
                                                            context, cartModelList[index].id!, qty);
                                                      },
                                                      icon: const Icon(
                                                        Icons.add_circle_rounded,
                                                        color: ColorResource.primaryColor,
                                                        size: 25,
                                                      ),
                                                      height: 40,
                                                      width: 40)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                ),
            onLoading: wishlistShimmerView(context),
            onError: (s) =>
                onErrorReloadButton(context, s.toString(), height: MediaQuery.of(context).size.height, onTap: () {
                  initData();
                }),
            onEmpty: SizedBox(height: MediaQuery.of(context).size.height, child: notFound(context, 'cart_empty'.tr))),
      ),
      bottomNavigationBar: Obx(() => Get.find<CartController>().getCartModelList.isNotEmpty
          ? Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              decoration: customDecorationOnly(
                  shadowBlur: 1.5,
                  offset: const Offset(1, -1.8),
                  topLeft: 15,
                  topRight: 15,
                  color: ColorResource.whiteColor,
                  shadowColor: ColorResource.lightGrayColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Wrap(
                      direction: Axis.vertical,
                      children: [
                        textView15(context: context, text: "${"total".tr}: ", maxLine: 1, fontWeight: FontWeight.w700),
                        textView25(
                            context: context,
                            text: PriceConverter.currencySignAlignment(Get.find<CartController>().getTotalAmount),
                            color: ColorResource.primaryColor)
                      ],
                    ),
                  ),
                  customTextButton(
                      onTap: () async {
                        await Get.to(CheckOutView(groupCarId: cartModelList.map((user) => user.cartGroupId).toList()));
                      },
                      text: Center(
                        child: textView16(
                          context: context,
                          text: 'check_out'.tr,
                          fontWeight: FontWeight.w600,
                          color: ColorResource.whiteColor,
                        ),
                      ),
                      color: ColorResource.primaryColor,
                      radius: 10,
                      height: 50)
                ],
              ),
            )
          : const SizedBox.shrink()),
      topSafeArea: true,
      onRefresh: () async {
        initData();
      },
    );
  }
}
