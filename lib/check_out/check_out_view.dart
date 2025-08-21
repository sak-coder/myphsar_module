import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myphsar/aba_pay/aba_pay_view_controller.dart';
import 'package:myphsar/account/address/AddressView.dart';
import 'package:myphsar/account/address/shipping/shipping_method_model.dart';
import 'package:myphsar/app_constants.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_bottom_sheet_dialog.dart';
import 'package:myphsar/base_widget/custom_scaffold_indicator.dart';
import 'package:myphsar/base_widget/snack_bar_message.dart';
import 'package:myphsar/cart/cart_model.dart';
import 'package:myphsar/check_out/check_out_controller.dart';

import '../aba_pay/aba_pay_view.dart';
import '../account/address/AddressItemView.dart';
import '../account/address/ParamAddAddressModel.dart';
import '../account/address/address_view_controller.dart';
import '../base_colors.dart';
import '../base_widget/custom_confirm_dialog_view.dart';
import '../base_widget/custom_decoration.dart';
import '../base_widget/custom_icon_button.dart';
import '../base_widget/input_text_field_icon.dart';
import '../base_widget/loader_view.dart';
import '../base_widget/myphsar_text_view.dart';
import '../base_widget/not_found.dart';
import '../base_widget/reload_button.dart';
import '../cart/cart_controller.dart';
import '../ccu/ccu_controller.dart';
import '../ccu/ccu_pay_view.dart';
import '../configure/config_controller.dart';
import '../map/pick_map_view.dart';
import '../utils/price_converter.dart';
import '../vtc_pay/vattnac_pay_view_controller.dart';

class CheckOutView extends StatefulWidget {
  final List<dynamic>? groupCarId;

  const CheckOutView({super.key, this.groupCarId});

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> with WidgetsBindingObserver {
  var controller = TextEditingController();
  var key = GlobalKey<FormState>();
  int currentSellerId = 0;
  final addressForm = GlobalKey<FormState>();
  final contactForm = GlobalKey<FormState>();
  final numberForm = GlobalKey<FormState>();
  final cityForm = GlobalKey<FormState>();
  var addressController = TextEditingController();
  var contactController = TextEditingController();
  var numberController = TextEditingController();
  var cityController = TextEditingController();
  var _vtnTranId;
  bool abaPayStatus = false;
  bool vtnPayStatus = false;
  bool addressPick = false;
  bool ccuPayStatus = false;
  String cityId = "";
  var _mapModel = MapModel();
  var selectShippingToggle = 5;

  @override
  void initState() {
    initData();
    WidgetsBinding.instance.addObserver(this);
    Get.find<AddressViewController>().mapPickListener.stream.listen((mapModel) {
      mapModel as MapModel;
      _mapModel = mapModel;
      setState(() {
        addressController.text = mapModel.address.toString();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
     WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future initData() async {
    Get.find<CartController>().clearData();
    await Get.find<AddressViewController>().getAllAddress();
    await Get.find<AddressViewController>().getShippingMethod();
    await Get.find<CheckOutController>().getAvailableOnlinePayment();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        Get.find<CheckOutController>().stopLoader();
        if (abaPayStatus) {
          Get.find<AbaPayViewController>().getPaymentStatusRequest(
              context,
              Get.find<AbaPayViewController>().getAbaPaymentModel.tranId.toString(),
              (success) => {
                    if (success == 200) {abaPayStatus = false, onSuccess(true)} else {onSuccess(false)}
                  });
        }

        if (vtnPayStatus) {
          onVtcPaySuccess();
        }
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  var platform = const MethodChannel('vtc');

  Future<void> _getVtcPayment(String externalId, String amount, String currency, String paymentOption) async {
    try {
      await platform.invokeMethod('getVtcPayment',
          {'externalId': externalId, 'amount': amount, 'currency': currency, 'paymentOption': paymentOption});
    } on PlatformException {
      Get.find<CheckOutController>().stopLoader();
    }
  }

  void onVtcPaySuccess() async {
    Get.find<CheckOutController>().showLoader();
    if (Platform.isAndroid) {
      if (_vtnTranId != null) {
        Get.find<VattanacPayViewController>().getPaidTranStatus(
            tid: _vtnTranId,
            callback: (data) {
              onSuccess(data);
            });
      }
    } else {
      try {
        bool statusResponse = await platform.invokeMethod("onVtcPaySuccess");
        onSuccess(statusResponse);
      } on PlatformException {
        Get.find<CheckOutController>().stopLoader();
      }
    }
  }

  void onSuccess(bool status) {
    Get.find<CheckOutController>().stopLoader();
    if (status == true) {
      Get.find<CheckOutController>().orderSuccessListener.add(AppConstants.PAY_SUCCESS_CODE);
    } else {
      Get.find<CheckOutController>().orderSuccessListener.add(AppConstants.PAY_FAILED_CODE);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CustomScaffoldRefreshIndicator(
        appBar: customAppBarView(context: context, titleText: "check_out".tr),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => ListView.builder(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: Get.find<CartController>().getCartModelList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var cartModelList = Get.find<CartController>().getCartModelList;

                      if (cartModelList[index].sellerId != currentSellerId) {
                        cartModelList[index].isDisplaySeller = true;
                        currentSellerId = cartModelList[index].sellerId;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          cartModelList[index].isDisplaySeller == true
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                                  child: textView15(
                                      fontWeight: FontWeight.w700,
                                      context: context,
                                      text: "${"shop".tr}: " + cartModelList[index].shopInfo),
                                )
                              : Container(),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            decoration: customDecoration(
                                radius: 10, shadowBlur: 3, shadowColor: ColorResource.lightShadowColor50),
                            padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: textView14(
                                            context: context,
                                            text: cartModelList[index].name!,
                                            maxLine: 2,
                                            color: ColorResource.darkTextColor,
                                            fontWeight: FontWeight.w700,
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
                                                          context, cartModelList[index].id.toString(), index, (data) {
                                                        Navigator.pop(context);
                                                      });
                                                      setState(() {
                                                        selectShippingToggle = 5;
                                                      });
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
                                          textView20(
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
                                                        setState(() {
                                                          selectShippingToggle = 5;
                                                        });
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
                                                      await Get.find<CartController>()
                                                          .updateCartProductQty(context, cartModelList[index].id!, qty);
                                                      setState(() {
                                                        selectShippingToggle = 5;
                                                      });
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    //     Expanded(
                    //       child: SizedBox(
                    //         height: 40,
                    //         child: InputTextFieldCustom(
                    //           radius: 10,
                    //           formKey: key,
                    //           hintTxt: 'voucher'.tr,
                    //           controller: controller,
                    //           textInputAction: TextInputAction.done,
                    //           inputType: TextInputType.text,
                    //         ),
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 5),
                    //       child: customTextButton(
                    //           padding: 10,
                    //           radius: 10,
                    //           height: 40,
                    //           color: ColorResource.whiteColor,
                    //           blur: 1,
                    //           onTap: () {
                    //             // AlertDialogMessageView(context: context, icon: Image.asset("assets/images/order_place_ic.png",width: 62,), message: 'Your order has been placed successfully');
                    //           },
                    //           text: Center(
                    //             child: textView14(
                    //                 context: context,
                    //                 text: "apply".tr,
                    //                 color: ColorResource.lightTextColor,
                    //                 fontWeight: FontWeight.w600),
                    //           )),
                    //     ),
                    //   ]),
                    // ),

                    const Divider(
                      thickness: 1,
                      color: ColorResource.hintTextColor,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => textView15(
                              context: context,
                              text: PriceConverter.currencySignAlignment(Get.find<CartController>().getSubTotal),
                              color: ColorResource.primaryColor)),
                          textView14(context: context, text: "subtotal".tr),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => textView15(
                              context: context,
                              text: PriceConverter.currencySignAlignment(
                                  Get.find<CartController>().getSelectedShippingCost),
                              color: ColorResource.primaryColor)),
                          textView14(context: context, text: "delivery_fee".tr),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => textView15(
                              context: context,
                              text: PriceConverter.currencySignAlignment(Get.find<CartController>().getTotalDiscount),
                              color: ColorResource.primaryColor)),
                          textView14(context: context, text: "dis".tr),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => textView15(
                              context: context,
                              text: PriceConverter.currencySignAlignment(Get.find<CartController>().getCouponDiscount),
                              color: ColorResource.primaryColor)),
                          textView14(context: context, text: "coupon_voucher".tr),
                        ],
                      ),
                    ),
                    // Divider(
                    //   height: 1,
                    // ),
                  ],
                ),
              ),
              Container(
                height: 7,
                color: ColorResource.lightGrayColor50,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 5,
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Stack(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              customImageButton(
                                  height: 40,
                                  width: 40,
                                  color: ColorResource.lightHintTextColor,
                                  blur: 0,
                                  icon: Image.asset("assets/images/map_ic.png")),
                              const SizedBox(
                                width: 8,
                              ),
                              Obx(() => textView14(
                                  context: context,
                                  text: Get.find<AddressViewController>().getCheckOutAddress.addressType != null
                                      ? "${"shipping_address".tr} : ${Get.find<AddressViewController>().getCheckOutAddress.addressType}"
                                      : "no_address".tr,
                                  color: ColorResource.lightTextColor,
                                  fontWeight: FontWeight.w700)),
                            ],
                          ),
                          Obx(
                            () => Get.find<AddressViewController>().getCheckOutAddress.address != null
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 49),
                                    child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: textView14(
                                            maxLine: 2,
                                            height: 1.3,
                                            context: context,
                                            color: ColorResource.hintTextColor,
                                            text: Get.find<AddressViewController>()
                                                .getCheckOutAddress
                                                .address
                                                .toString())))
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: customTextButton(
                            padding: 10,
                            radius: 10,
                            color: ColorResource.liteYellowColor,
                            blur: 0,
                            onTap: () {
                              // change address
                              pickAddress();
                            },
                            text: Obx(() => textView14(
                                context: context,
                                text: Get.find<AddressViewController>().getAddressModelList.isNotEmpty
                                    ? "change".tr
                                    : 'add_address'.tr,
                                color: ColorResource.lightTextColor,
                                fontWeight: FontWeight.w700))),
                      ),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            customImageButton(
                                height: 40,
                                width: 40,
                                color: ColorResource.lightHintTextColor,
                                blur: 0,
                                icon: const Icon(
                                  Icons.local_shipping_outlined,
                                  color: ColorResource.secondaryColor,
                                )),
                            const SizedBox(
                              width: 8,
                            ),
                            textView14(
                                context: context,
                                text: "shipping_method".tr,
                                color: ColorResource.lightTextColor,
                                fontWeight: FontWeight.w700),
                          ],
                        ),

                        Get.find<AddressViewController>().obx(
                            (state) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: Get.find<AddressViewController>().getShippingMethodList.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          var shipping = Get.find<AddressViewController>().getShippingMethodList;
                                          return Row(
                                            children: [
                                              Checkbox(
                                                  activeColor: ColorResource.primaryColor,
                                                  checkColor: ColorResource.whiteColor,
                                                  value: index == selectShippingToggle,
                                                  onChanged: (status) {
                                                    setState(() {
                                                      selectShippingToggle = index;
                                                      applyShippingMethod(index, shipping);
                                                    });
                                                  }),
                                              Expanded(
                                                child: Material(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: InkWell(
                                                    onTap: () {
                                                      applyShippingMethod(index, shipping);
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(5),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          !shipping[index].dynamicPrice!
                                                              ? Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    textView14(
                                                                        color: ColorResource.lightTextColor,
                                                                        context: context,
                                                                        height: 1.5,
                                                                        text: shipping[index].title.toString()),
                                                                    textView15(
                                                                        height: 2,
                                                                        color: ColorResource.secondaryColor,
                                                                        context: context,
                                                                        text: "  \$${shipping[index].cost}",
                                                                        fontWeight: FontWeight.w700),
                                                                  ],
                                                                )
                                                              : const SizedBox.shrink(),
                                                          textView13(
                                                              color: ColorResource.hintTextColor,
                                                              context: context,
                                                              text: "est_delivery".tr +
                                                                  shipping[index].duration.toString()),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ],
                                ),
                            onError: (s) => onErrorReloadButton(
                                  context,
                                  s.toString(),
                                  height: 298,
                                  onTap: () async {
                                    if (Get.find<AddressViewController>().getAddressModelList.length == 0) {
                                      await Get.find<AddressViewController>().getAllAddress();
                                    }
                                    await Get.find<AddressViewController>().getShippingMethod();
                                  },
                                ),
                            onEmpty: SizedBox(height: 300, child: notFound(context, 'empty_address'.tr))),

                        // Padding(
                        //     padding: const EdgeInsets.only(left: 49),
                        //     child: SizedBox(
                        //         width: MediaQuery.of(context).size.width,
                        //         child:Obx(() => textView15(
                        //             context: context,
                        //             text: Get.find<CartController>().getShippingMethodTitle,
                        //             color: ColorResource.lightTextColor)),)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Wrap(
                  direction: Axis.vertical,
                  children: [
                    textView15(context: context, text: '${"total".tr}: ', maxLine: 1, fontWeight: FontWeight.w700),
                    textView25(
                        context: context,
                        text: PriceConverter.currencySignAlignment(Get.find<CartController>().getTotalAmount),
                        color: ColorResource.primaryColor)
                  ],
                ),
              ),
              customTextButton(
                  onTap: () async {
                    if (Get.find<AddressViewController>().getAddressModelList.isNotEmpty) {
                      if (Get.find<CartController>().gatSelectShippingMethod) {
                        availableOnlinePayment(context);
                      } else {
                        snackBarMessage(context, "choose_shipping_method".tr);
                      }
                    } else {
                      snackBarMessage(context, 'no_address_msg'.tr);
                    }
                  },
                  text: Center(
                    child: textView16(
                      context: context,
                      text: 'process_to_pay'.tr,
                      fontWeight: FontWeight.w600,
                      color: ColorResource.whiteColor,
                    ),
                  ),
                  color: ColorResource.primaryColor,
                  radius: 10,
                  height: 50),
            ],
          ),
        ),
        onRefresh: () async {
          initData();
        },
      ),
      Obx(() => loaderFullScreenView(context, Get.find<CheckOutController>().getLoading))
    ]);
  }

  //
  // void shippingMethod(BuildContext buildContext) {
  //   Get.find<CartController>().clearLoadingStatus();
  //   customBottomSheetDialogWrap(
  //     padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 25),
  //     context: buildContext,
  //     child: Stack(
  //       alignment: AlignmentDirectional.center,
  //       children: [
  //         Obx(
  //           () => Get.find<AddressViewController>().getShippingMethodList.isNotEmpty
  //               ? Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: textView16(
  //                           color: ColorResource.darkTextColor,
  //                           context: context,
  //                           text: "shipping_method".tr,
  //                           fontWeight: FontWeight.w600),
  //                     ),
  //                     ListView.builder(
  //                         shrinkWrap: true,
  //                         physics: const NeverScrollableScrollPhysics(),
  //                         itemCount: Get.find<AddressViewController>().getShippingMethodList.length,
  //                         itemBuilder: (BuildContext context, int index) {
  //                           var shipping = Get.find<AddressViewController>().getShippingMethodList;
  //                           return Container(
  //                             margin: const EdgeInsets.all(5),
  //                             child: Material(
  //                               borderRadius: BorderRadius.circular(15),
  //                               child: InkWell(
  //                                 onTap: () {
  //                                   //TODO: Check multiple shop place order with api
  //                                   if (Get.find<AddressViewController>().getCheckOutAddress.address != null) {
  //                                     // Navigator.pop(context);
  //                                     var cartId = [];
  //                                     Get.find<CartController>().getCartModelList.forEach((cart) async {
  //                                       cart as CartModel;
  //                                       if (!cartId.toString().contains(cart.cartGroupId.toString())) {
  //                                         Get.find<CartController>().addShippingCost(
  //                                             context: buildContext,
  //                                             groupCartId: cart.cartGroupId.toString(),
  //                                             shippingAddressId:
  //                                                 Get.find<AddressViewController>().getCheckOutAddress.id.toString(),
  //                                             shippingMethodId: shipping[index].id.toString(),
  //                                             cost: shipping[index].cost!.toDouble(),
  //                                             title: shipping[index].title.toString(),
  //                                             isCE: shipping[index].dynamicPrice!);
  //                                         cartId.add(cart.cartGroupId.toString());
  //                                       }
  //                                     });
  //                                   } else {
  //                                     snackBarMessage(context, "no_address_msg".tr);
  //                                   }
  //                                 },
  //                                 child: Padding(
  //                                   padding: const EdgeInsets.all(20),
  //                                   child: Column(
  //                                     crossAxisAlignment: CrossAxisAlignment.start,
  //                                     children: [
  //                                       !shipping[index].dynamicPrice!
  //                                           ? Row(
  //                                             children: [
  //                                               textView15(
  //                                                   color: ColorResource.lightTextColor,
  //                                                   context: context,
  //                                                   text: shipping[index].title.toString()),
  //                                               textView16(
  //                                                   color: ColorResource.secondaryColor,
  //                                                   context: context,
  //                                                   text: "${"shipping_price".tr}${shipping[index].cost}\$",
  //                                                   fontWeight: FontWeight.w600),
  //
  //                                             ],
  //                                           )
  //                                           : const SizedBox.shrink(),
  //
  //                                       textView15(
  //                                           color: ColorResource.lightTextColor,
  //                                           context: context,
  //                                           text: "est_delivery".tr + shipping[index].duration.toString()),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           );
  //                         }),
  //                   ],
  //                 )
  //               : SizedBox(
  //                   height: 200,
  //                   child: onErrorReloadButton(context, "Loading Shipping method failed", height: 300, onTap: () async {
  //                     await Get.find<AddressViewController>().getShippingMethod();
  //                   }),
  //                 ),
  //         ),
  //         Obx(() => Get.find<CartController>().getLoadingStatus == true
  //             ? const CircularProgressIndicator()
  //             : const SizedBox.shrink()),
  //       ],
  //     ),
  //   );
  // }

  void applyShippingMethod(int index, List<ShippingMethodModel> shipping) {
    //TODO: Check multiple shop place order with api
    if (Get.find<AddressViewController>().getCheckOutAddress.address != null) {
      var cartId = [];
      setState(() {
        selectShippingToggle = index;
      });
      Get.find<CartController>().getCartModelList.forEach((cart) async {
        cart as CartModel;
        if (!cartId.toString().contains(cart.cartGroupId.toString())) {
          Get.find<CartController>().addShippingCost(
              context: context,
              groupCartId: cart.cartGroupId.toString(),
              shippingAddressId: Get.find<AddressViewController>().getCheckOutAddress.id.toString(),
              shippingMethodId: shipping[index].id.toString(),
              cost: shipping[index].cost!.toDouble(),
              title: shipping[index].title.toString(),
              isCE: shipping[index].dynamicPrice!);
          cartId.add(cart.cartGroupId.toString());
        }
      });
    } else {
      snackBarMessage(context, "no_address_msg".tr);
    }
  }

  Future<void> availableOnlinePayment(BuildContext buildContext) async {
    Get.find<CartController>().clearLoadingStatus();
    Get.find<CheckOutController>().getAvailableOnlinePayment();
    customBottomSheetDialogWrap(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 25),
      context: buildContext,
      child: Wrap(
        children: [
          Get.find<CheckOutController>().obx(
            (state) => ListView.builder(
                padding: const EdgeInsets.only(bottom: 10),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: Get.find<CheckOutController>().getAvailableOnlinePaymentModel.length,
                itemBuilder: (BuildContext context, int index) {
                  var availableOnlinePayment = Get.find<CheckOutController>().getAvailableOnlinePaymentModel;
                  return Container(
                      decoration: customDecoration(radius: 10, shadowBlur: 2),
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: 65,
                      child: Material(
                          color: ColorResource.whiteColor,
                          child: InkWell(
                            onTap: () async {
                              if (availableOnlinePayment[index].paymentOption == AppConstants.CARD_PAY) {
                                Navigator.pop(buildContext);
                                Get.find<CheckOutController>().showLoader();
                                abaPayStatus = false;
                                vtnPayStatus = false;
                                Get.find<AbaPayViewController>().getAbaPayHash(
                                    isCredit: true,
                                    availableOnlinePayment[index].id.toString(),
                                    Get.find<AddressViewController>().getCheckOutAddress.id.toString(),
                                    "USD", callback: (data) {

                                  Get.to(const AbaPayView());
                                });
                              } else if (availableOnlinePayment[index].paymentOption == AppConstants.ABA_PAY) {
                                Navigator.pop(buildContext);
                                Get.find<CheckOutController>().showLoader();
                                abaPayStatus = true;

                                Get.find<AbaPayViewController>().getAbaPayHash(
                                    isCredit: false,
                                    availableOnlinePayment[index].id.toString(),
                                    Get.find<AddressViewController>().getCheckOutAddress.id.toString(),
                                    "USD", callback: (data) {

                                  Get.find<AbaPayViewController>().openAbaDeeplink(
                                    data.deepLink.toString(),
                                  );
                                });
                              } else if (availableOnlinePayment[index].paymentOption == AppConstants.CCU_PAY) {
                                Navigator.pop(buildContext);
                                Get.find<CheckOutController>().showLoader();
                                ccuPayStatus = true;
                                Get.find<CcuController>().getCcuPaymentModel(
                                    availableOnlinePayment[index].id.toString(), "USD", (url) async {

                                  await Get.find<CheckOutController>().emitCartSocket(widget.groupCarId!);
                                  Get.to(CcuPayView(
                                    fromUrl: url,
                                  ));
                                });
                              } else {
                                Navigator.pop(buildContext);
                                vtnPayStatus = true;
                                // autoDismissAlertDialogWidgetView(
                                //     context: context,
                                //     widget: Container(
                                //         alignment: Alignment.center,
                                //         height: 50,
                                //         child: textView15(context: context, text: "Under Maintained")));
                                Get.find<CheckOutController>().showLoader();
                                Get.find<VattanacPayViewController>().getVtcPaymentHash(
                                    context,
                                    availableOnlinePayment[index].id.toString(),
                                    'USD',
                                    Get.find<AddressViewController>().getCheckOutAddress.id.toString(),
                                    (data) => {
                                          _vtnTranId = data.tranId!,
                                          _getVtcPayment(data.tranId!, data.amount.toString(), 'USD', 'credit')
                                        });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FadeInImage(
                                  image: NetworkImage(
                                    availableOnlinePayment[index].lLogo.toString(),
                                  ),
                                  width: 35,
                                  height: 30,
                                  placeholder: const AssetImage("assets/images/elephant_placholder.png"),
                                  imageErrorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.broken_image_outlined,
                                    );
                                  },
                                  fit: BoxFit.fitWidth,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                                        child: textView14(
                                            fontWeight: FontWeight.w700,
                                            context: context,
                                            text: availableOnlinePayment[index].title.toString()),
                                      ),
                                      availableOnlinePayment[index].description != null
                                          ? textView13(
                                              context: context,
                                              text: availableOnlinePayment[index].description.toString(),
                                              color: ColorResource.lightShadowColor,
                                              fontWeight: FontWeight.w600)
                                          : const SizedBox.shrink()
                                    ],
                                  ),
                                ),
                                customImageButton(
                                    blur: 0,
                                    color: ColorResource.lightHintTextColor,
                                    radius: 5,
                                    padding: 0,
                                    height: 25,
                                    width: 25,
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 15,
                                    ))
                              ],
                            ),
                          )));
                }),
            onError: (s) => onErrorReloadButton(context, s.toString(), height: 200, onTap: () {
              Get.find<CheckOutController>().getAvailableOnlinePayment();
            }),
          ),
          Container(
              decoration: customDecoration(
                radius: 10,
                shadowBlur: 2,
              ),
              margin: const EdgeInsets.only(top: 5, bottom: 10),
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: 65,
              child: Material(
                  color: ColorResource.whiteColor,
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      Get.find<CheckOutController>().showLoader();
                      Get.find<CheckOutController>().placeOrder(
                          context, Get.find<AddressViewController>().getCheckOutAddress.id.toString(), '', (status) {
                        if (status == true) {
                          Get.find<CheckOutController>().orderSuccessListener.add(AppConstants.PAY_SUCCESS_CODE);
                        } else {
                          Get.find<CheckOutController>().orderSuccessListener.add(AppConstants.PAY_FAILED_CODE);
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textView15(fontWeight: FontWeight.w700, context: context, text: "cash_delivery".tr),
                        customImageButton(
                            blur: 0,
                            color: ColorResource.lightHintTextColor,
                            radius: 5,
                            padding: 0,
                            height: 25,
                            width: 25,
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                            ))
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }

  void pickAddress() {
    customBottomSheetDialogWrap(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 25),
      context: context,
      child:
          // TextViewSize_15(context: context, text: "Shipping Method",fontWeight: FontWeight.w800),
          SafeArea(
        child: Wrap(
          children: [
            Obx(
              () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: Get.find<AddressViewController>().getAddressModelList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var addressList = Get.find<AddressViewController>().getAddressModelList;
                    return Container(
                      margin: const EdgeInsets.all(5),
                      child: Material(
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                          onTap: () {
                            Get.find<AddressViewController>().pickAddress(index);
                            Navigator.pop(context);
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(10), child: addressItemView(context, addressList[index])),
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: customTextButton(
                blur: 0,
                height: 50,
                width: MediaQuery.of(context).size.width,
                radius: 5,
                color: ColorResource.primaryColor,
                onTap: () async {
                  addOtherAddress();
                },
                text: textView15(
                    context: context,
                    text: "add_other_address".tr,
                    height: 1.7,
                    color: ColorResource.whiteColor,
                    textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addOtherAddress() {
    addressController.text = '';
    contactController.text = '';
    numberController.text = '';
    addressPick = false;
    // Get.find<AddressViewController>().addingAddress.value = false;
    customBottomSheetDialog(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      context: context,
      child: Wrap(
        children: [
          Center(
            child: textView16(
                context: context,
                text: "shipping_address".tr,
                maxLine: 1,
                color: ColorResource.darkTextColor,
                fontWeight: FontWeight.w600),
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: textView16(
                        context: context,
                        text: "choose_address_type".tr,
                        maxLine: 1,
                        color: ColorResource.lightTextColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Obx(
                    () => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            customImageTextButton(
                                text: textView12(
                                    context: context,
                                    text: "home_address".tr,
                                    maxLine: 1,
                                    color: Get.find<AddressViewController>().addressType.value == "home_address".tr
                                        ? ColorResource.whiteColor
                                        : ColorResource.darkTextColor,
                                    fontWeight: FontWeight.w500),
                                blur: 0,
                                height: 40,
                                width: 95,
                                icon: Image.asset("assets/images/home_ic.png",
                                    color: Get.find<AddressViewController>().addressType.value == "home_address".tr
                                        ? ColorResource.whiteColor
                                        : ColorResource.darkTextColor),
                                color: Get.find<AddressViewController>().addressType.value == "home_address".tr
                                    ? ColorResource.orange
                                    : ColorResource.whiteColor,
                                onTap: () {
                                  Get.find<AddressViewController>().addressType.value = "home_address".tr;
                                }),
                            customImageTextButton(
                                text: textView12(
                                    context: context,
                                    text: "office".tr,
                                    maxLine: 1,
                                    color: Get.find<AddressViewController>().addressType.value == "office".tr
                                        ? ColorResource.whiteColor
                                        : ColorResource.darkTextColor,
                                    fontWeight: FontWeight.w500),
                                blur: 0,
                                height: 40,
                                width: 115,
                                icon: Image.asset("assets/images/office_ic.png",
                                    color: Get.find<AddressViewController>().addressType.value == "office".tr
                                        ? ColorResource.whiteColor
                                        : ColorResource.darkTextColor),
                                color: Get.find<AddressViewController>().addressType.value == "office".tr
                                    ? ColorResource.orange
                                    : ColorResource.whiteColor,
                                onTap: () {
                                  Get.find<AddressViewController>().addressType.value = "office".tr;
                                }),
                            customImageTextButton(
                                text: textView12(
                                    context: context,
                                    text: "other".tr,
                                    maxLine: 1,
                                    color: Get.find<AddressViewController>().addressType.value == "other".tr
                                        ? ColorResource.whiteColor
                                        : ColorResource.darkTextColor,
                                    fontWeight: FontWeight.w500),
                                blur: 0,
                                height: 40,
                                width: 110,
                                icon: Image.asset("assets/images/location_ic.png",
                                    color: Get.find<AddressViewController>().addressType.value == "other".tr
                                        ? ColorResource.whiteColor
                                        : ColorResource.darkTextColor),
                                color: Get.find<AddressViewController>().addressType.value == "other".tr
                                    ? ColorResource.orange
                                    : ColorResource.whiteColor,
                                onTap: () {
                                  Get.find<AddressViewController>().addressType.value = "other".tr;
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(5),
                  //   child: DropdownButton<String>(
                  //     icon: Icon(
                  //       Icons.arrow_drop_down_rounded,
                  //       size: 40,
                  //     ),
                  //     hint: Obx(
                  //       () => TextViewSize_15(
                  //           context: context,
                  //           text: Get.find<AddressViewController>().addressType.value,
                  //           maxLine: 1,
                  //           color: ColorResource.darkTextColor,
                  //           fontWeight: FontWeight.w500),
                  //     ),
                  //     underline: Container(),
                  //     items: <String>['home_address'.tr, 'office'.tr, 'other'.tr].map((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: TextViewSize_15(
                  //           context: context,
                  //           text: value,
                  //         ),
                  //       );
                  //     }).toList(),
                  //     onChanged: (text) {
                  //       addressPick = true;
                  //       Get.find<AddressViewController>().addressType.value = text!;
                  //     },
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),

                  const SizedBox(
                    height: 10,
                  ),
                  InputTextFieldWithIcon(
                    readonly: true,
                    onTap: () {
                      Get.find<CheckOutController>().getCEAvailableCityModel().then((value) async => {
                            await AddressView.pickCityDialog(
                                Get.find<CheckOutController>().getCeCityModel.cities!, context, (city) {
                              cityController.text = city.cityName.toString();
                              cityId = city.id.toString();
                            })
                          });
                    },
                    imageIcon: Image.asset(
                      'assets/images/city_ic.png',
                      width: 20,
                      height: 20,
                      color: ColorResource.primaryColor,
                    ),
                    textInputAction: TextInputAction.next,
                    hintTxt: 'province_city1'.tr,
                    controller: cityController,
                    formKey: cityForm,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputTextFieldWithIcon(
                    rightImageIcon: SizedBox(
                      width: 78,
                      child: Row(
                        children: [
                          Container(
                            color: ColorResource.lightShadowColor50,
                            width: 1,
                            height: 48,
                          ),
                          customImageTextButton(
                            text: textView11(context: context, text: "Map", fontWeight: FontWeight.w600),
                            blur: 0,
                            radius: 1,
                            onTap: () {
                              Get.to(const PickMapView());
                            },
                            padding: 0,
                            height: 45,
                            width: 70,
                            icon: Image.asset(
                              "assets/images/pick_ic.png",
                              width: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    imageIcon: Image.asset(
                      'assets/images/map_ic.png',
                      width: 20,
                      height: 20,
                    ),
                    textInputAction: TextInputAction.next,
                    hintTxt: 'address'.tr,
                    controller: addressController,
                    formKey: addressForm,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputTextFieldWithIcon(
                    imageIcon: Image.asset(
                      'assets/images/acc_ic.png',
                      width: 20,
                      height: 20,
                    ),
                    // focusNode: widget.focusNote,
                    textInputAction: TextInputAction.next,
                    hintTxt: "contact_name".tr,
                    controller: contactController,
                    formKey: contactForm,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputTextFieldWithIcon(
                    imageIcon: Image.asset(
                      'assets/images/phone_off_ic.png',
                      width: 20,
                      height: 20,
                    ),
                    // focusNode: widget.focusNote,
                    textInputAction: TextInputAction.done,
                    hintTxt: "contact_number".tr,
                    inputType: TextInputType.phone,
                    controller: numberController,
                    formKey: numberForm,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customTextButton(
                    blur: 0,
                    height: 50,
                    radius: 5,
                    color: ColorResource.primaryColor,
                    width: MediaQuery.of(context).size.width,
                    onTap: () {
                      if (contactController.text.isNotEmpty &&
                          addressController.text.isNotEmpty &&
                          numberController.text.isNotEmpty &&
                          cityId.isNotEmpty) {
                        Get.find<AddressViewController>().addAddress(
                            ParamAddAddressModel(
                                contactPersonName: contactController.text.trim(),
                                addressType: Get.find<AddressViewController>().addressType.value,
                                address: addressController.text.trim(),
                                cityId: cityId,
                                zip: 'empty',
                                phone: numberController.text.trim(),
                                city: '${_mapModel.lat} ${_mapModel.lang}'),
                            context);
                      } else {
                        customErrorBottomDialog(context, "address_alert_message".tr);
                      }
                    },
                    text: textView15(
                        context: context,
                        text: "add_address".tr,
                        maxLine: 1,
                        height: 1.7,
                        color: ColorResource.whiteColor,
                        textAlign: TextAlign.center),
                  )
                ],
              ),
              Obx(() => Get.find<AddressViewController>().addingAddress.value == true
                  ? const CircularProgressIndicator()
                  : Container()),
            ],
          ),
        ],
      ),
      height: 472,
    );
    // customBottomSheetDialog(
    //   padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
    //   height: 377,
    //   //  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
    //   context: context,
    //   child: Column(
    //     children: [
    //       Center(
    //         child: TextViewSize_16(
    //             context: context,
    //             text: "shipping_address".tr,
    //             maxLine: 1,
    //             color: ColorResource.darkTextColor,
    //             fontWeight: FontWeight.w500),
    //       ),
    //       Stack(alignment: Alignment.center, children: [
    //         Column(
    //           //crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Align(
    //               alignment: Alignment.bottomLeft,
    //               child: Padding(
    //                 padding: const EdgeInsets.only(top: 10),
    //                 child: TextViewSize_16(
    //                     context: context,
    //                     text: "choose_address_type".tr,
    //                     maxLine: 1,
    //                     color: ColorResource.darkTextColor,
    //                     fontWeight: FontWeight.w500),
    //               ),
    //             ),
    //             Obx(
    //                   () => Padding(
    //                 padding: const EdgeInsets.only(top: 10, bottom: 10),
    //                 child: Row(
    //                   children: [
    //                     CustomIconTextButton(
    //                         text: TextViewSize_12(
    //                             context: context,
    //                             text: "home_address".tr,
    //                             maxLine: 1,
    //                             color: Get.find<AddressViewController>().addressType.value == "home_address".tr
    //                                 ? ColorResource.whiteColor
    //                                 : ColorResource.darkTextColor,
    //                             fontWeight: FontWeight.w500),
    //                         blur: 0,
    //                         height: 40,
    //                         width: 95,
    //                         icon: Image.asset("assets/images/home_ic.png",
    //                             color: Get.find<AddressViewController>().addressType.value == "home_address".tr
    //                                 ? ColorResource.whiteColor
    //                                 : ColorResource.darkTextColor),
    //                         color: Get.find<AddressViewController>().addressType.value == "home_address".tr
    //                             ? ColorResource.orange
    //                             : ColorResource.whiteColor,
    //                         onTap: () {
    //                           Get.find<AddressViewController>().addressType.value = "home_address".tr;
    //                         }),
    //                     CustomIconTextButton(
    //                         text: TextViewSize_12(
    //                             context: context,
    //                             text: "office".tr,
    //                             maxLine: 1,
    //                             color: Get.find<AddressViewController>().addressType.value == "office".tr
    //                                 ? ColorResource.whiteColor
    //                                 : ColorResource.darkTextColor,
    //                             fontWeight: FontWeight.w500),
    //                         blur: 0,
    //                         height: 40,
    //                         width: 115,
    //                         icon: Image.asset("assets/images/home_ic.png",
    //                             color: Get.find<AddressViewController>().addressType.value == "office".tr
    //                                 ? ColorResource.whiteColor
    //                                 : ColorResource.darkTextColor),
    //                         color: Get.find<AddressViewController>().addressType.value == "office".tr
    //                             ? ColorResource.orange
    //                             : ColorResource.whiteColor,
    //                         onTap: () {
    //                           Get.find<AddressViewController>().addressType.value = "office".tr;
    //                         }),
    //                     CustomIconTextButton(
    //                         text: TextViewSize_12(
    //                             context: context,
    //                             text: "other".tr,
    //                             maxLine: 1,
    //                             color: Get.find<AddressViewController>().addressType.value == "other".tr
    //                                 ? ColorResource.whiteColor
    //                                 : ColorResource.darkTextColor,
    //                             fontWeight: FontWeight.w500),
    //                         blur: 0,
    //                         height: 40,
    //                         width: 110,
    //                         icon: Image.asset("assets/images/location_ic.png",
    //                             color: Get.find<AddressViewController>().addressType.value == "other".tr
    //                                 ? ColorResource.whiteColor
    //                                 : ColorResource.darkTextColor),
    //                         color: Get.find<AddressViewController>().addressType.value == "other".tr
    //                             ? ColorResource.orange
    //                             : ColorResource.whiteColor,
    //                         onTap: () {
    //                           Get.find<AddressViewController>().addressType.value = "other".tr;
    //                         }),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             // Padding(
    //             //   padding: const EdgeInsets.all(5),
    //             //   child: DropdownButton<String>(
    //             //     icon: Icon(
    //             //       Icons.keyboard_arrow_down_rounded,
    //             //       size: 30,
    //             //     ),
    //             //     hint: Obx(
    //             //       () => TextViewSize_18(
    //             //           context: context,
    //             //           text: Get.find<AddressViewController>().addressType.value,
    //             //           maxLine: 1,
    //             //           color: ColorResource.darkTextColor,
    //             //           fontWeight: FontWeight.w700),
    //             //     ),
    //             //     underline: Container(),
    //             //     items: <String>['Home', 'Office', 'Other'].map((String value) {
    //             //       return DropdownMenuItem<String>(
    //             //         value: value,
    //             //         child: TextViewSize_15(context: context, text: value, color: ColorResource.darkTextColor),
    //             //       );
    //             //     }).toList(),
    //             //     onChanged: (text) {
    //             //       addressPick = true;
    //             //       Get.find<AddressViewController>().addressType.value = text!;
    //             //     },
    //             //   ),
    //             // ),
    //             Padding(
    //               padding: const EdgeInsets.only(top: 5, bottom: 5),
    //               child: InputTextFieldWithIcon(
    //                 imageIcon: Image.asset(
    //                   'assets/images/map_ic.png',
    //                   width: 20,
    //                   height: 20,
    //                 ),
    //                 textInputAction: TextInputAction.next,
    //                 hintTxt: 'address'.tr,
    //                 controller: addressController,
    //                 formKey: addressForm,
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(top: 5, bottom: 5),
    //               child: InputTextFieldWithIcon(
    //                 imageIcon: Image.asset(
    //                   'assets/images/acc_ic.png',
    //                   width: 20,
    //                   height: 20,
    //                 ),
    //                 // focusNode: widget.focusNote,
    //                 textInputAction: TextInputAction.next,
    //                 hintTxt: "contact_name".tr,
    //                 controller: contactController,
    //                 formKey: contactForm,
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(top: 5, bottom: 10),
    //               child: InputTextFieldWithIcon(
    //                 imageIcon: Image.asset(
    //                   'assets/images/phone_off_ic.png',
    //                   width: 20,
    //                   height: 20,
    //                 ),
    //                 // focusNode: widget.focusNote,
    //                 textInputAction: TextInputAction.done,
    //                 hintTxt: "contact_number".tr,
    //                 inputType: TextInputType.phone,
    //                 controller: numberController,
    //                 formKey: numberForm,
    //               ),
    //             ),
    //             CustomTextButton(
    //               blur: 0,
    //               height: 50,
    //               radius: 5,
    //               color: ColorResource.primaryColor,
    //               width: MediaQuery.of(context).size.width,
    //               onTap: () {
    //                 if (contactController.text.isNotEmpty &&
    //                     addressController.text.isNotEmpty &&
    //                     numberController.text.isNotEmpty) {
    //                   Get.find<AddressViewController>().addAddress(
    //                       ParamAddAddressModel(
    //                           contactPersonName: contactController.text.trim(),
    //                           addressType: Get.find<AddressViewController>().addressType.value,
    //                           address: addressController.text.trim(),
    //                           zip: 'empty',
    //                           phone: numberController.text.trim(),
    //                           city: 'empty'),
    //                       context);
    //                 } else {
    //                   customErrorBottomDialog(context, "address_alert_message".tr);
    //                 }
    //               },
    //               text: TextViewSize_15(
    //                   context: context,
    //                   text: "add_address".tr,
    //                   maxLine: 1,
    //                   height: 1.7,
    //                   color: ColorResource.whiteColor,
    //                   textAlign: TextAlign.center),
    //             )
    //           ],
    //         ),
    //         Obx(() => Get.find<AddressViewController>().addingAddress.value == true
    //             ? CircularProgressIndicator()
    //             : Container()),
    //       ]),
    //     ],
    //   ),
    // );
  }
}
