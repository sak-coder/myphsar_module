import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_bottom_sheet_dialog.dart';
import 'package:myphsar/base_widget/custom_decoration.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';
import 'package:myphsar/product/product_model.dart';
import 'package:myphsar/product_detail/product_detail_controller.dart';
import 'package:myphsar/review/review_item_controller.dart';
import 'package:myphsar/review/review_item_view.dart';
import 'package:myphsar/shop_profile/shop_profile_controller.dart';
import 'package:myphsar/shop_profile/shop_profile_view.dart';
import 'package:share_plus/share_plus.dart';

// import 'package:share/share.dart';

import '../base_colors.dart';
import '../account/wishlist/wishlist_controller.dart';
import '../auth/AuthController.dart';
import '../base_widget/badg_icon.dart';
import '../base_widget/custom_icon_button.dart';
import '../base_widget/custom_scaffold_indicator.dart';
import '../base_widget/not_found.dart';
import '../base_widget/reload_button.dart';
import '../base_widget/sing_in_dialog_view.dart';
import '../base_widget/snack_bar_message.dart';
import '../cart/add_to_cart_view.dart';
import '../cart/cart_list/cart_list_view.dart';
import '../configure/config_controller.dart';
import '../home/all_product/shimmer_placeholder_view.dart';
import '../home/home_controller.dart';
import '../installment/installment_view_controller.dart';
import '../installment/user_info/installment_info_view.dart';
import '../product/product_item_grid_view.dart';
import '../utils/price_controller_display.dart';
import '../utils/price_converter.dart';
import 'full_photo_view.dart';

class ProductDetailView extends StatefulWidget {
  final Products _product;

  const ProductDetailView(this._product, {super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> with SingleTickerProviderStateMixin {
  int imageIndex = 0;
  ScrollController scrollController = ScrollController();

  final PageController pageController = PageController();

  // Timer? timer;
  // bool delay = false;

  @override
  void initState() {
    initData();
    // timer = Timer(Duration(milliseconds: 1500), () async {
    //   setState(() {
    //     delay = true;
    //   });
    // });
    super.initState();
  }

  // @override
  // void dispose() {
  //   if (timer != null) {
  //     timer!.cancel();
  //   }
  //   super.dispose();
  // }

  // @override
  // void deactivate() {
  //   if (timer != null) {
  //     timer!.cancel();
  //   }
  //   super.deactivate();
  // }

  void initData() async {
    Get.find<ProductDetailController>().clearProductData();
    Get.find<ProductDetailController>().clearControllerData();
    await Get.find<ProductDetailController>().getRelatedProduct(widget._product.id!);

    await Get.find<ProductDetailController>().getGenerateShareProductLink(widget._product.id!);
    await Get.find<ShopProfileController>().getShopProfile(widget._product.userId.toString());
    await Get.find<ProductDetailController>().getCounterProduct(widget._product.id!);
    await Get.find<ReviewItemController>().getAllReviewProduct(widget._product.id!);
  }

  @override
  Widget build(BuildContext context) {
    // List<Widget> detailTap = [DetailTap(), ReviewTap()];
    return  CustomScaffoldRefreshIndicator(

          appBar: customAppBarView(
              elevation: 0,
              context: context,
              titleText: '',
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    customImageButton(
                        padding: 10,
                        width: 45,
                        radius: 5,
                        height: 45,
                        onTap: () async {
                          await Share.share(Get.find<ProductDetailController>().shareLink.value);
                        },
                        blur: 0,
                        icon: Image.asset(
                          "assets/images/share_ic.png",
                          width: 21,
                          height: 20,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Obx(() => badgeIcon(
                        topP: -2,
                        endP: -2,
                        visibleBadge: Get.find<HomeController>().cartCount > 0 ? true : false,
                        context: context,
                        badgeText: Get.find<HomeController>().cartCount.toString(),
                        imageIcon: customImageButton(
                          padding: 11,
                          radius: 5,
                          width: 45,
                          height: 45,
                          onTap: () {
                            if (!Get.find<AuthController>().isSignIn()) {
                              signInDialogView(context);
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
              )),
          body: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                controller: scrollController,
                child: Container(

                  color: ColorResource.whiteColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget._product.images!.length > 0
                          ? SizedBox(
                              height: 370.0,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(children: [
                                PageView.builder(
                                  controller: pageController,
                                  itemCount: widget._product.images!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.to(() => FullPhotoView(
                                            '${Get.find<ConfigController>().configModel.baseUrls!.baseProductImageUrl}'
                                            '/${widget._product.images![index]}'));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: ExtendedImage.network(
                                          '${Get.find<ConfigController>().configModel.baseUrls!.baseProductImageUrl}/${widget._product.images![index]}',
                                          width: MediaQuery.of(context).size.width,
                                          fit: BoxFit.fitHeight,
                                          cache: false,
                                          enableMemoryCache: false,
                                          loadStateChanged: (ExtendedImageState state) {
                                            switch (state.extendedImageLoadState) {
                                              case LoadState.failed:
                                                return GestureDetector(
                                                  child: Stack(
                                                    fit: StackFit.expand,
                                                    children: <Widget>[
                                                      Image.asset(
                                                        "assets/images/placeholder_img.png",
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                      Center(
                                                        child: customImageTextButton(
                                                            blur: 1,
                                                            text: textView12(context: context, text: "Reload"),
                                                            height: 50,
                                                            width: 100,
                                                            onTap: () {
                                                              state.reLoadImage();
                                                            },
                                                            icon: const Icon(
                                                              Icons.refresh,
                                                              color: ColorResource.primaryColor,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              case LoadState.loading:
                                                // TODO: Handle this case.
                                                break;
                                              case LoadState.completed:
                                                // TODO: Handle this case.
                                                break;
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  onPageChanged: (index) {
                                    setState(() {
                                      imageIndex = index;
                                    });
                                  },
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      height: 10,
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.center,
                                      child: dotAnimation(imageIndex, widget._product.images!.length)),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10, bottom: 20),
                                        child: customImageButton(
                                            padding: 5,
                                            width: 40,
                                            height: 40,
                                            onTap: () => {
                                                  if (Get.find<AuthController>().isSignIn())
                                                    {
                                                      Get.find<WishlistController>()
                                                          .addWishlist(context, widget._product.id.toString())
                                                    }
                                                  else
                                                    {signInDialogView(context)}
                                                },
                                            icon: Image.asset(
                                              "assets/images/love_ic.png",
                                              width: 24,
                                              height: 24,
                                            ),
                                            blur: 3),
                                      ),
                                    ],
                                  ),
                                ),
                              ]))
                          : const SizedBox.shrink(),

                      widget._product.images!.isNotEmpty
                          ? Container(
                              height: 60,
                              alignment: Alignment.center,
                              child: ListView.builder(
                                itemCount: widget._product.images!.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      pageController.animateToPage(index,
                                          duration: const Duration(microseconds: 300), curve: Curves.easeInOut);
                                    },
                                    child: Container(
                                      width: 60,
                                      margin: const EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(1),
                                          color: Theme.of(context).highlightColor,
                                          border: Border.all(
                                              color:
                                                  imageIndex == index ? ColorResource.primaryColor : Colors.transparent,
                                              width: 2)),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: "assets/images/placeholder_img.png",
                                        fit: BoxFit.contain,
                                        image: widget._product.images!.length > 0
                                            ? '${Get.find<ConfigController>().configModel.baseUrls!.baseProductImageUrl}'
                                                '/${widget._product.images![index]}'
                                            : '',
                                        imageErrorBuilder: (c, o, s) =>
                                            Image.asset("assets/images/placeholder_img.png", fit: BoxFit.contain),
                                      ),
                                    ),
                                  );
                                },
                              ))
                          : const SizedBox.shrink(),

                      widget._product.videoUrl != null
                          ? Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(2),
                              decoration: customDecoration(
                                radius: 4,
                                color: ColorResource.primaryColor,
                              ),
                              child: Text(
                                textAlign: TextAlign.start,
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                widget._product.videoUrl.toString(),
                                style: const TextStyle(
                                    letterSpacing: 0.1,
                                    fontSize: 13,
                                    color: ColorResource.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ))
                          : const SizedBox.shrink(),
                      Container(
                        padding: const EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textView16(
                                context: context,
                                text: widget._product.name.toString(),
                                color: ColorResource.darkTextColor,
                                fontWeight: FontWeight.w500,
                                maxLine: 2),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PriceConverterDisplay.itemPrice(context, widget._product),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  children: [
                                    Container(
                                      child: RatingBarIndicator(
                                        rating: widget._product.rating?.length != 0 && widget._product.rating != null
                                            ? widget._product.rating![0].average!
                                            : 0.0,
                                        itemPadding: const EdgeInsets.all(1),
                                        itemBuilder: (context, index) => Image.asset(
                                          "assets/images/star_on_ic.png",
                                        ),
                                        itemCount: 5,
                                        itemSize: 13.0,
                                        direction: Axis.horizontal,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: textView15(
                                          context: context,
                                          text: widget._product.rating?.length != 0 && widget._product.rating != null
                                              ? "(${widget._product.rating![0].average!.toStringAsFixed(1)})"
                                              : "(0)",
                                          color: ColorResource.secondaryColor,
                                          fontWeight: FontWeight.w700,
                                          maxLine: 1),
                                    ),
                                  ],
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.end,
                                  direction: Axis.vertical,
                                  children: [
                                    Wrap(
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      children: [
                                        textView13(
                                            context: context,
                                            text: widget._product.viewer.toString(),
                                            color: ColorResource.darkTextColor),
                                        const SizedBox(width: 2),
                                        const Icon(
                                          Icons.remove_red_eye_outlined,
                                          size: 15,
                                          color: ColorResource.darkTextColor,
                                        ),
                                      ],
                                    ),
                                    // Obx(() => TextViewSize_13(
                                    //     context: context,
                                    //     text: "${Get.find<ProductDetailController>().getOrderCount} " +
                                    //         "orders".tr +
                                    //         " | ${Get.find<ProductDetailController>().getWishlistCount} " +
                                    //         "wish".tr,
                                    //     maxLine: 1,
                                    //     color: ColorResource.darkTextColor))
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),


                      detailTap(),
                      widget._product.reviewsCount! > 0 ? reviewTap() : const SizedBox.shrink(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 8,
                        color: ColorResource.lightHintTextColor,
                      ),

                                    /*Recommend Product*/
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10),
                      //   child: RecommendWidget(),
                      // ),

                      Container(
                        color: ColorResource.bgItemColor,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                          child: textView16(
                            fontWeight: FontWeight.w700,
                            context: context,
                            text: "relate_product".tr,
                            color: ColorResource.darkTextColor,
                          ),
                        ),
                      ),

                      Get.find<ProductDetailController>().obx(
                          (state) => Container(
                            color: ColorResource.bgItemColor,
                            child: ProductItemGridView(Get.find<ProductDetailController>(),
                                Get.find<ProductDetailController>().getProductList, scrollController, (val) {}),
                          ),
                          onLoading: productShimmerView(context),
                          onError: (s) => onErrorReloadButton(context, s.toString(), height: 300, onTap: () {
                                Get.find<ProductDetailController>().getRelatedProduct(widget._product.id!);
                              }),
                          onEmpty: SizedBox(height: 298, child: notFound(context, 'empty_product'.tr)))
                    ],
                  ),
                ),
              )
                  // : Container(
                  //     child: Center(
                  //       child: CircularProgressIndicator(),
                  //     ),
                  //   ),
                  ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
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
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        textView15(context: context, text: "${"total".tr}:", maxLine: 1, fontWeight: FontWeight.w600),
                        textView25(
                            context: context,
                            text: PriceConverter.convertPrice(
                                context, double.parse(widget._product.unitPrice.toString()),
                                discount: widget._product.discount!, discountType: widget._product.discountType!),
                            color: ColorResource.primaryColor)
                      ],
                    ),
                    Row(
                      children: [
                        widget._product.interestRateStatus != 0
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: customImageButton(
                                    padding: 10,
                                    width: 80,
                                    height: 50,
                                    onTap: () => {
                                          if (Get.find<AuthController>().isSignIn())
                                            {
                                              Get.to(InstallmentInfoView(widget._product.id.toString())),
                                              Get.find<InstallmentViewController>()
                                                  .addProductImg(widget._product.thumbnail.toString(), reset: true)
                                            }
                                          else
                                            {signInDialogView(context)}
                                        },
                                    icon: Image.asset(
                                      "assets/images/installments_ic.png",
                                      width: 24,
                                      height: 24,
                                    ),
                                    radius: 10,
                                    color: ColorResource.primaryColor),
                              )
                            : const SizedBox.shrink(),
                        customTextButton(
                            onTap: () {
                              customBottomSheetDialogWrap(
                                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
                                context: context,
                                child: AddToCartView(
                                  products: widget._product,
                                  function: (val) {
                                    if (!Get.find<AuthController>().isSignIn()) {
                                      signInDialogView(context);
                                    } else {
                                      snackBarMessage(context, val, bgColor: Colors.green);
                                    }
                                  },
                                ),
                              );
                            },
                            text: Center(
                              child: textView16(
                                context: context,
                                text: 'add_to_cart'.tr,
                                fontWeight: FontWeight.w600,
                                color: ColorResource.whiteColor,
                              ),
                            ),
                            color: ColorResource.primaryColor,
                            radius: 10,
                            height: 50),
                      ],
                    )
                  ],
                ),
              )
            ],
          ), onRefresh: () async {
          Get.find<ProductDetailController>().getRelatedProduct(widget._product.id!);
        },
        );


  }

  Widget detailTap() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: textView16(
                    fontWeight: FontWeight.w700, context: context, text: "shop".tr, color: ColorResource.darkTextColor),
              ),
              customImageTextButton(
                  iconAlign: CustomIconAlign.right,
                  blur: 0,
                  height: 40,
                  width: 100,
                  onTap: () {
                    if (Get.find<ShopProfileController>().getShopProfileModel.shop != null) {
                      Get.to(ShopProfileView(Get.find<ShopProfileController>().getShopProfileModel));
                    } else {
                      Get.find<ShopProfileController>().getShopProfile(widget._product.userId.toString());
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 20,
                    color: ColorResource.primaryColor,
                  ),
                  text: textView15(
                      fontWeight: FontWeight.w500,
                      context: context,
                      text: 'visit'.tr,
                      maxLine: 1,
                      color: ColorResource.secondaryColor,
                      textAlign: TextAlign.center,
                      height: 1.1)),
            ],
          ),

          Obx(
            () => Get.find<ShopProfileController>().getShopProfileModel.shop != null
                ? Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Row(children: [
                      customImageButton(
                        padding: 0,
                        width: 60,
                        height: 60,
                        onTap: () {
                          if (Get.find<ShopProfileController>().getShopProfileModel.shop != null) {
                            Get.to(ShopProfileView(Get.find<ShopProfileController>().getShopProfileModel));
                          } else {
                            Get.find<ShopProfileController>().getShopProfile(widget._product.userId.toString());
                          }
                        },
                        icon:  FadeInImage.assetNetwork(
                            placeholder: "assets/images/placeholder_img.png",
                            fit: BoxFit.fitHeight,
                            image:
                                '${Get.find<ConfigController>().configModel.baseUrls?.baseShopImageUrl}/${Get.find<ShopProfileController>().getShopProfileModel.shop!.image!}',
                            width: 60,
                            height: 60,
                            imageErrorBuilder: (c, o, s) => Image.asset(
                              "assets/images/placeholder_img.png",
                              fit: BoxFit.fitWidth,
                              height: 60,
                            ),
                          ),

                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: textView16(
                              context: context,
                              text: Get.find<ShopProfileController>().getShopProfileModel.shop!.name!,
                              maxLine: 2,
                              color: ColorResource.darkTextColor))
                    ]),
                  )
                : const SizedBox.shrink(),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: textView16(
                fontWeight: FontWeight.w700,
                context: context,
                text: "specification".tr,
                color: ColorResource.darkTextColor),
          ),

          Stack(children: [
            widget._product.metaDescription == null
                ? Html(
                    style: {
                      "body": Style(
                        backgroundColor: Colors.white,
                        fontSize: FontSize(16.0),
                        maxLines: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    },
                    data: widget._product.details ?? "empty_description".tr,
                    shrinkWrap: true,
                  )
                : textView15(
                    context: context,
                    color: ColorResource.lightTextColor,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    text: widget._product.metaDescription.toString(),
                    maxLine: 10,
                  ),
            // Container(
            //   decoration: BoxDecoration(
            //       color: Colors.white,
            //       gradient:
            //           LinearGradient(begin: FractionalOffset.center, end: FractionalOffset.bottomCenter, colors: [
            //         Color.fromRGBO(255, 255, 255, 0.011764705882352941),
            //         Colors.white,
            //       ], stops: [
            //         0.5,
            //         0.7
            //       ])),
            // ),
            // widget._product.details != null
            //     ? Align(
            //         alignment: Alignment.bottomRight,
            //         child: CustomIconTextButton(
            //           iconAlign: CustomIconAlign.right,
            //           blur: 0,
            //           height: 40,
            //           width: 90,
            //           radius: 5,
            //           color: Colors.white,
            //           shadowColor: Colors.transparent,
            //           icon: Icon(
            //             Icons.arrow_forward_rounded,
            //             size: 20,
            //             color: ColorResource.primaryColor,
            //           ),
            //           onTap: () {
            //             Get.to(SpecificationView(widget._product.details.toString(), widget._product));
            //           },
            //           text: TextViewSize_15(
            //               context: context,
            //               text: 'more'.tr,
            //               color: ColorResource.secondaryColor,
            //               maxLine: 1,
            //               fontWeight: FontWeight.w500,
            //               height: 1.1),
            //         ),
            //       )
            //     : SizedBox.shrink(),
          ]),
        ],
      ),
    );
  }

  Widget reviewTap() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 8,
          color: ColorResource.lightHintTextColor,
        ),
        Container(
          height: 290,
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: textView16(
                    context: context,
                    text: 'Review (${widget._product.reviewsCount})',
                    color: ColorResource.darkTextColor),
              ),
              Get.find<ReviewItemController>().obx(
                  (state) =>
                      ReviewItemView(Get.find<ReviewItemController>().getReviewModel, scrollController, (val) {}),
                  onError: (s) => onErrorReloadButton(
                        context,
                        s.toString(),
                        height: 198,
                        onTap: () {
                          Get.find<ReviewItemController>().getAllReviewProduct(widget._product.id!);
                        },
                      ),
                  onEmpty: Container(
                      alignment: Alignment.center,
                      height: 198,
                      child:
                          textView16(color: ColorResource.lightTextColor, text: 'empty_review'.tr, context: context))),
              // Padding(
              //   padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
              //   child: CustomTextButton(
              //     blur: 0,
              //     width: MediaQuery.of(context).size.width,
              //     height: 45,
              //     onTap: () {
              //       if (widget._product.reviewsCount! > 0) {
              //         // Get.to(ReviewView());
              //       }
              //     },
              //     text: Center(
              //       child: TextViewSize_15(
              //           context: context,
              //           text: "view_all_review".tr,
              //           maxLine: 1,
              //           color: ColorResource.darkTextColor,
              //           fontWeight: FontWeight.w700),
              //     ),
              //     color: ColorResource.lightHintTextColor,
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
  }

  Widget dotAnimation(int selectIndex, int itemCount) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      child: ListView.builder(
          itemCount: itemCount,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              AnimatedContainer(
                width: selectIndex == index ? 20 : 10,
                height: 10,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                  color: selectIndex == index ? ColorResource.primaryColor : ColorResource.primaryColor05,
                  borderRadius: BorderRadius.circular(100),
                ),
                // Define how long the animation should take.
                duration: const Duration(milliseconds: 700),
                // Provide an optional curve to make the animation feel smoother.
                curve: Curves.easeOutQuart,
              ),
              const SizedBox(
                width: 5,
              )
            ]);
          }),
    );
  }
}
