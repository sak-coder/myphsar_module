import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/app_constants.dart';
import 'package:myphsar/base_widget/custom_decoration.dart';
import 'package:myphsar/base_widget/loader_view.dart';
import 'package:myphsar/order/order_detail/order_detail_model.dart';
import 'package:myphsar/order/order_history_view_controller.dart';
import 'package:myphsar/reviews/review_view.dart';
import 'package:myphsar/shop_profile/shop_profile_controller.dart';
import 'package:myphsar/track_order/track_order_view.dart';
import 'package:myphsar/utils/date_format.dart';

import '../../account/address/address_view_controller.dart';
import '../../account/support/ticket/SupportCenterView.dart';
import '../../base_colors.dart';
import '../../base_widget/custom_appbar_view.dart';
import '../../base_widget/custom_icon_button.dart';
import '../../base_widget/custom_scaffold.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../../base_widget/not_found.dart';
import '../../base_widget/reload_button.dart';
import '../../cart/cart_controller.dart';
import '../../configure/config_controller.dart';
import '../../home/all_product/shimmer_placeholder_view.dart';
import '../../track_order/ce/ce_tracking_order_view.dart';
import '../../utils/price_converter.dart';
import '../order_history_model.dart';

class OrderDetailView extends StatefulWidget {
  final String orderId;
  final OrderHistoryModel _orderHistoryModel;

  const OrderDetailView(this._orderHistoryModel, this.orderId, {super.key});

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView>
    with TickerProviderStateMixin {
  double totalDiscount = 0.0;
  var orderHistoryModel;

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    if (widget._orderHistoryModel.id == 0) {
      await Get.find<OrderHistoryViewController>().getAllOrderHistory((data) {
        orderHistoryModel = data;
      }, widget.orderId);
      await Get.find<ShopProfileController>().getShopProfile(orderHistoryModel.sellerId.toString());
    } else {
      orderHistoryModel = widget._orderHistoryModel;
      await Get.find<ShopProfileController>().getShopProfile(widget._orderHistoryModel.sellerId.toString());
    }

    await Get.find<OrderHistoryViewController>().getOrderDetail(context, widget.orderId);
    Get.find<AddressViewController>().getShippingMethod(isLoading: false);
    Get.find<OrderHistoryViewController>().getOrderHistoryList.forEach((element) {
      totalDiscount += element.discountAmount!;
    });
  }

  bool runningStatus(String s) {
    if (s == AppConstants.PENDING ||
        s == AppConstants.CONFIRMED ||
        s == AppConstants.PROCESSING ||
        s == AppConstants.OUT_FOR_DELIVERY) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar:
            customAppBarView(context: context, titleText: 'order_detail'.tr),
        body: SafeArea(
            child: Get.find<OrderHistoryViewController>().obx(
                (state) => Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 9,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        textView15(
                                            context: context,
                                            text: "receipt".tr +
                                                orderHistoryModel.id.toString(),
                                            color: ColorResource.secondaryColor,
                                            fontWeight: FontWeight.w700),
                                        orderHistoryModel.orderStatus !=
                                                AppConstants.DELIVERED
                                            ? Container(
                                                decoration: customDecoration(
                                                    radius: 5,
                                                    color: ColorResource
                                                        .lightHintTextColor),
                                                padding: const EdgeInsets.only(
                                                  left: 10,
                                                ),
                                                margin: const EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: textView13(
                                                    context: context,
                                                    text: orderHistoryModel
                                                        .orderStatus
                                                        .toString()
                                                        .toUpperCase(),
                                                    maxLine: 1,
                                                    color: ColorResource
                                                        .secondaryColor,
                                                    fontWeight:
                                                        FontWeight.w700))
                                            : const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Icon(
                                                  Icons.check_circle_outline,
                                                  color: ColorResource
                                                      .primaryColor,
                                                  size: 18,
                                                ),
                                              ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: textView12(
                                          context: context,
                                          text: "date".tr +
                                              DateFormate.isoStringToLocalDay(
                                                  orderHistoryModel
                                                      .createdAt!),
                                          color: ColorResource.lightTextColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    // textView13(
                                    //     context: context,
                                    //     text: "${"address".tr}: ${widget._orderHistoryModel.shippingAddressData!.address.toString()}",
                                    //     maxLine: 2,
                                    //     height: 1.4,
                                    //     color: ColorResource.lightTextColor,
                                    //     fontWeight: FontWeight.w500),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const Divider(
                            height: 20,
                            color: ColorResource.hintTextColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textView14(
                                    context: context,
                                    fontWeight: FontWeight.w600,
                                    text: PriceConverter.currencySignAlignment(
                                        orderHistoryModel.shippingCost),
                                    color: ColorResource.primaryColor),
                                textView14(
                                    context: context, text: "delivery_fee".tr),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textView14(
                                    context: context,
                                    fontWeight: FontWeight.w600,
                                    text: PriceConverter.currencySignAlignment(
                                        totalDiscount),
                                    color: ColorResource.primaryColor),
                                textView14(context: context, text: "dis".tr),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textView14(
                                    context: context,
                                    fontWeight: FontWeight.w600,
                                    text: PriceConverter.currencySignAlignment(
                                        Get.find<CartController>()
                                            .getCouponDiscount),
                                    color: ColorResource.primaryColor),
                                textView14(
                                    context: context,
                                    text: "coupon_voucher".tr),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textView14(
                                    context: context,
                                    fontWeight: FontWeight.w600,
                                    text: PriceConverter.currencySignAlignment(
                                        0.0),
                                    color: ColorResource.primaryColor),
                                textView14(context: context, text: "tax".tr),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textView14(
                                    context: context,
                                    text: Get.find<AddressViewController>().getShippingTitle(orderHistoryModel
                                            .shippingMethodId
                                            .toString()),
                                    color: ColorResource.primaryColor),
                                const Icon(Icons.local_shipping_outlined),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 1,
                            color: ColorResource.hintTextColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textView15(
                                    context: context,
                                    fontWeight: FontWeight.w600,
                                    text: PriceConverter.currencySignAlignment(
                                        orderHistoryModel.orderAmount! -
                                            orderHistoryModel.shippingCost!),
                                    color: ColorResource.primaryColor),
                                textView15(
                                    context: context, text: "subtotal".tr),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textView15(
                                    context: context,
                                    text: orderHistoryModel.paymentStatus
                                        .toString(),
                                    color: ColorResource.primaryColor,
                                    fontWeight: FontWeight.w600),
                                textView15(
                                    context: context,
                                    text: "payment_status".tr),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 1,
                            color: ColorResource.hintTextColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textView20(
                                    context: context,
                                    text: PriceConverter.currencySignAlignment(
                                        orderHistoryModel.orderAmount!),
                                    color: ColorResource.primaryColor),
                                textView20(
                                    context: context,
                                    text: "total".tr,
                                    maxLine: 2,
                                    color: ColorResource.darkTextColor),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 10),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/shop_ic.png",
                                  width: 18,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Obx(
                                      () => textView15(
                                          context: context,
                                          text: Get.find<ShopProfileController>()
                                                      .getShopProfileModel
                                                      .shop !=
                                                  null
                                              ? Get.find<
                                                      ShopProfileController>()
                                                  .getShopProfileModel
                                                  .shop!
                                                  .name
                                                  .toString()
                                              : '',
                                          color: ColorResource.darkTextColor,
                                          fontWeight: FontWeight.w700),
                                    )),
                              ],
                            ),
                          ),
                          Obx(() => Get.find<OrderHistoryViewController>()
                                  .getOrderHistoryDetail
                                  .isNotEmpty
                              ? Container(
                                  constraints: const BoxConstraints(
                                      minHeight: 60, minWidth: double.infinity),
                                  padding: const EdgeInsets.only(right: 10),
                                  decoration: customDecoration(
                                      radius: 10,
                                      shadowBlur: 2,
                                      shadowColor:
                                          ColorResource.lightShadowColor50),
                                  margin: const EdgeInsets.only(
                                      top: 10, right: 2, left: 2),
                                  child: ListView.builder(
                                      padding: const EdgeInsets.all(1.5),
                                      shrinkWrap: true,
                                      itemCount:
                                          Get.find<OrderHistoryViewController>()
                                              .getOrderHistoryDetail
                                              .length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        OrderDetailModel orderDetail = Get.find<
                                                OrderHistoryViewController>()
                                            .getOrderHistoryDetail[index];
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 5),
                                              height: 60,
                                              width: 60,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child:
                                                      FadeInImage.assetNetwork(
                                                    placeholder:
                                                        "assets/images/placeholder_img.png",
                                                    placeholderFit:
                                                        BoxFit.contain,
                                                    fadeInDuration:
                                                        const Duration(
                                                            seconds: 1),
                                                    fit: BoxFit.contain,
                                                    image:
                                                        '${Get.find<ConfigController>().configModel.baseUrls?.baseProductThumbnailUrl}/${orderDetail.productDetails!.thumbnail!}',
                                                    imageErrorBuilder:
                                                        (c, o, s) =>
                                                            Image.asset(
                                                      "assets/images/placeholder_img.png",
                                                      fit: BoxFit.contain,
                                                    ),
                                                  )),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            child: textView14(
                                                                context:
                                                                    context,
                                                                text: orderDetail
                                                                    .productDetails!
                                                                    .name
                                                                    .toString(),
                                                                maxLine: 2,
                                                                color: ColorResource
                                                                    .darkTextColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                height: 1.2)),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10,
                                                            bottom: 10),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        textView14(
                                                            context: context,
                                                            text: PriceConverter
                                                                .currencySignAlignment(
                                                                    orderDetail
                                                                        .price!),
                                                            maxLine: 1,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: ColorResource
                                                                .primaryColor),
                                                        Expanded(
                                                          child: textView15(
                                                              height: 0.8,
                                                              context: context,
                                                              text:
                                                                  " | x ${orderDetail.qty}",
                                                              maxLine: 1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: ColorResource
                                                                  .primaryColor),
                                                        ),
                                                        textView12(
                                                            context: context,
                                                            text: orderDetail
                                                                .variant
                                                                .toString(),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: ColorResource
                                                                .lightTextColor),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }))
                              : Center(
                                  child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width: 50,
                                  height: 50,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ))),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20, top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: customTextButton(
                                      onTap: () async {
                                        if (runningStatus(orderHistoryModel
                                            .orderStatus
                                            .toString())) {
                                          if (orderHistoryModel.trackingOrder ==
                                              true) {
                                            Get.to(CeTrackingOrderView(
                                              orderId: orderHistoryModel.id
                                                  .toString(),
                                              orderDate: orderHistoryModel
                                                  .createdAt
                                                  .toString(),
                                            ));
                                          } else {
                                            Get.to(TrackOrderView(
                                                orderId: orderHistoryModel.id
                                                    .toString()));
                                          }
                                          Get.to(TrackOrderView(
                                              orderId: orderHistoryModel.id
                                                  .toString()));
                                        } else {
                                          //TODO: Reorder
                                          //    Get.to(() => ProductDetailView(Get.find<OrderHistoryViewController>().getOrderHistoryDetail[0].productDetails, opaque: false, popGesture: true, preventDuplicates: false);
                                        }
                                      },
                                      text: Center(
                                        child: textView15(
                                          context: context,
                                          text: runningStatus(orderHistoryModel
                                                  .orderStatus
                                                  .toString())
                                              ? 'track_order'.tr
                                              : "reorder".tr,
                                          fontWeight: FontWeight.w600,
                                          color: ColorResource.whiteColor,
                                        ),
                                      ),
                                      color: ColorResource.primaryColor,
                                      radius: 10,
                                      blur: 0,
                                      height: 50),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: customTextButton(
                                      borderColor: ColorResource.primaryColor,
                                      onTap: () async {
                                        if (orderHistoryModel.orderStatus ==
                                            AppConstants.DELIVERED) {
                                          Get.to(() => const ReviewView());
                                        } else {
                                          Get.to(
                                              () => const SupportCenterView());
                                        }
                                      },
                                      text: Center(
                                        child: textView15(
                                          context: context,
                                          text: orderHistoryModel.orderStatus ==
                                                  AppConstants.DELIVERED
                                              ? 'review'.tr
                                              : "support_center".tr,
                                          fontWeight: FontWeight.w600,
                                          color: ColorResource.primaryColor,
                                        ),
                                      ),
                                      color: ColorResource.whiteColor,
                                      blur: 0,
                                      radius: 10,
                                      height: 50),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                onError: (s) => onErrorReloadButton(context, s.toString(),
                        height: MediaQuery.of(context).size.height,
                        onTap: () async {
                      await Get.find<OrderHistoryViewController>()
                          .getAllOrderHistory((data) {
                        orderHistoryModel = data;
                      }, widget.orderId);
                    }),
                onEmpty: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: notFound(context, 'empty_product'.tr)))));
  }
}
