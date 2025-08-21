import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/account/wishlist/wishlist_controller.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_icon_button.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';

import '../../base_widget/custom_bottom_sheet_dialog.dart';
import '../../base_widget/not_found.dart';
import '../../base_widget/reload_button.dart';
import '../../base_widget/snack_bar_message.dart';
import '../../cart/add_to_cart_view.dart';
import '../../configure/config_controller.dart';
import '../../home/all_product/shimmer_placeholder_view.dart';
import '../../utils/price_controller_display.dart';
import '../../utils/price_converter.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  @override
  void initState() {
    getAllWishlist();
    super.initState();
  }

  void getAllWishlist() async {
    await Get.find<WishlistController>().getAllWishlist(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: customAppBarView(context: context, titleText: 'wishlist'.tr),
        body: Container(
          color: Colors.white,
          child: Get.find<WishlistController>().obx(
              (state) => Obx(() => ListView.builder(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  itemCount: Get.find<WishlistController>().getAllWishlistModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    var wishlistMode = Get.find<WishlistController>().getAllWishlistModel;
                    return Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 10),
                            height: 90,
                            width: 90,
                            child: Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: "assets/images/placeholder_img.png",
                                      placeholderFit: BoxFit.contain,
                                      fadeInDuration: const Duration(seconds: 1),
                                      fit: BoxFit.contain,
                                      height: 90,
                                      image:
                                          '${Get.find<ConfigController>().configModel.baseUrls?.baseProductThumbnailUrl}/${wishlistMode[index].thumbnail}',
                                      imageErrorBuilder: (c, o, s) => Image.asset(
                                        "assets/images/placeholder_img.png",
                                        fit: BoxFit.contain,
                                      ),
                                    )),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: wishlistMode[index].discount! > 0
                                        ? Container(
                                            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 3, top: 3),
                                            decoration: BoxDecoration(
                                                color: ColorResource.lightGrayBgColor,
                                                borderRadius: BorderRadius.circular(10)),
                                            child: Text(
                                              PriceConverter.percentageCalculation(
                                                  context,
                                                  wishlistMode[index].unitPrice!,
                                                  wishlistMode[index].discount!,
                                                  wishlistMode[index].discountType!),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(fontSize: 12, color: ColorResource.primaryColor),
                                            ))
                                        : const SizedBox(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 6,
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                height: 90,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    textView15(
                                      context: context,
                                      text: wishlistMode[index].name.toString(),
                                      maxLine: 2,
                                      color: ColorResource.darkTextColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    PriceConverterDisplay.dynamicPrice(context,
                                        isCategory: false,
                                        unitPrice: wishlistMode[index].unitPrice!,
                                        discount: wishlistMode[index].discount!,
                                        discountType: wishlistMode[index].discountType!),

                                    // TextViewSize_20(context: context, text: "\$10", maxLine: 1,color: ColorResource.primaryColor)
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Container(
                                margin: const EdgeInsets.only(right: 20),
                                height: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    customImageButton(
                                        padding: 10,
                                        onTap: () {
                                          customBottomSheetDialog(
                                              context: context,
                                              child: Column(
                                                children: [
                                                  textView20(
                                                      context: context,
                                                      text: "delete_confirm_msg".tr,
                                                      fontWeight: FontWeight.w800,
                                                      color: ColorResource.darkTextColor),
                                                  const SizedBox(
                                                    height: 30,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      customTextButton(
                                                        padding: 1,
                                                        blur: 0,
                                                        height: 50,
                                                        width: 95,
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                          Get.find<WishlistController>().removeWishlist(
                                                              context, wishlistMode[index].id.toString(), index);
                                                        },
                                                        text: Center(
                                                          child: textView20(
                                                              context: context,
                                                              text: "yes".tr,
                                                              fontWeight: FontWeight.w700,
                                                              color: ColorResource.darkTextColor),
                                                        ),
                                                      ),
                                                      customTextButton(
                                                        padding: 1,
                                                        blur: 0,
                                                        height: 50,
                                                        width: 95,
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                          //		Get.find<AddressViewController>().deleteAddress(context,widget.id.toString(),widget.index);
                                                        },
                                                        text: Center(
                                                          child: textView20(
                                                              context: context,
                                                              text: "no".tr,
                                                              fontWeight: FontWeight.w700,
                                                              color: ColorResource.primaryColor),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                              height: 180);
                                        },
                                        blur: 0,
                                        height: 40,
                                        width: 40,
                                        radius: 100,
                                        icon: Image.asset(
                                          "assets/images/delete_ic.png",
                                          width: 15,
                                        )),
                                    customImageButton(
                                      onTap: () {
                                        customBottomSheetDialogWrap(
                                          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
                                          context: context,
                                          child: AddToCartView(
                                            products: Get.find<WishlistController>().getAllWishlistModel[index],
                                            function: (val) {
                                              snackBarMessage(context, val);
                                            },
                                          ),
                                        );
                                      },
                                      blur: 0,
                                      height: 40,
                                      width: 40,
                                      radius: 100,
                                      icon: Image.asset(
                                        "assets/images/add_card_ic.png",
                                        width: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    );
                  })),
              onLoading: wishlistShimmerView(context),
              onError: (s) => onErrorReloadButton(context, s.toString(), height: 300, onTap: () {
                    getAllWishlist();
                  }),
              onEmpty:
                  SizedBox(height: MediaQuery.of(context).size.height, child: notFound(context, 'empty_wishlist'.tr))),
        ),
        topSafeArea: true);
  }
}
