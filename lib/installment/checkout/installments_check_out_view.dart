import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myphsar/aba_pay/aba_pay_view_controller.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_bottom_sheet_dialog.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/check_out/check_out_controller.dart';
import 'package:myphsar/installment/installment_view_controller.dart';

import '../../app_constants.dart';
import '../../base_colors.dart';
import '../../aba_pay/aba_pay_view.dart';
import '../../account/address/AddressItemView.dart';
import '../../account/address/AddressView.dart';
import '../../account/address/address_view_controller.dart';
import '../../account/address/ParamAddAddressModel.dart';
import '../../base_widget/custom_decoration.dart';
import '../../base_widget/custom_icon_button.dart';
import '../../base_widget/input_text_field_icon.dart';
import '../../base_widget/loader_view.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../../base_widget/reload_button.dart';
import '../../configure/config_controller.dart';
import '../../map/pick_map_view.dart';
import '../../utils/price_converter.dart';
import '../../vtc_pay/vattnac_pay_view_controller.dart';

class InstallmentsCheckOutView extends StatefulWidget {
  final String uuid;
  final String lenderId;

  const InstallmentsCheckOutView(this.uuid, this.lenderId, {super.key});

  @override
  State<InstallmentsCheckOutView> createState() => _InstallmentsCheckOutViewState();
}

class _InstallmentsCheckOutViewState extends State<InstallmentsCheckOutView> with WidgetsBindingObserver {
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
  String cityId = "";

  var tranId;
  bool abaPayStatus = false;
  bool vtnPayStatus = false;
  var _mapModel = MapModel();

  @override
  void initState() {
    initData();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Get.find<AddressViewController>().mapPickListener.stream.listen((mapModel) {
      mapModel as MapModel;
      _mapModel = mapModel;
      setState(() {
        addressController.text = mapModel.address.toString();
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future initData() async {
    // Get.find<CartController>().clearData();
    Get.find<InstallmentViewController>().stopLoader();
    await Get.find<InstallmentViewController>().getInstallmentCheckOutDetail(widget.uuid);
    await Get.find<AddressViewController>().getAllAddress();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        Get.find<InstallmentViewController>().stopLoader();
        if (abaPayStatus) {
          Get.find<InstallmentViewController>().getInstallmentTransactionStatus(
              tid: tranId,
              callback: (data) {
                onSuccess(data);
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
      // TODO: Handle this case.
    }
    super.didChangeAppLifecycleState(state);
  }

  var platform = const MethodChannel('vtc');

  Future<void> _getVtcPayment(String externalId, String amount, String currency, String paymentOption) async {
    try {
      await platform.invokeMethod('getVtcPayment',
          {'externalId': externalId, 'amount': amount, 'currency': currency, 'paymentOption': paymentOption});
    } on PlatformException {}
  }

  void onVtcPaySuccess() async {
    Get.find<InstallmentViewController>().showLoader();
    if (Platform.isAndroid) {
      if (tranId != null) {
        Get.find<InstallmentViewController>().getInstallmentTransactionStatus(
            tid: tranId,
            callback: (data) {
              onSuccess(data);
            });
      }
    } else {
      try {
        bool data = await platform.invokeMethod("onVtcPaySuccess");
        onSuccess(data);
      } on PlatformException {
        Get.find<InstallmentViewController>().stopLoader();
      }
    }
  }

  void onSuccess(bool data) {
    Get.find<InstallmentViewController>().stopLoader();
    if (data == true) {
      Get.find<CheckOutController>().orderSuccessListener.add(AppConstants.INSTALLMENT_PAY_SUCCESS_CODE);
      Navigator.popUntil(context, ModalRoute.withName('/'));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CustomScaffold(
        appBar: customAppBarView(context: context, titleText: "check_out".tr),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: Obx(() => Get.find<InstallmentViewController>().getInstallmentCheckOutModel.data != null
                      ? Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textView20(context: context, text: "address".tr, fontWeight: FontWeight.w700),
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(top: 5, bottom: 5),
                                width: MediaQuery.of(context).size.width,
                                decoration: customDecoration(color: Colors.white, radius: 10, shadowBlur: 2),
                                child: Stack(children: [
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
                                          Obx(() => textView15(
                                              context: context,
                                              text: Get.find<AddressViewController>().getCheckOutAddress.addressType !=
                                                      null
                                                  ? Get.find<AddressViewController>()
                                                      .getCheckOutAddress
                                                      .addressType
                                                      .toString()
                                                  : "no_address".tr,
                                              color: ColorResource.hintTextColor,
                                              fontWeight: FontWeight.w600))
                                        ],
                                      ),
                                      Obx(
                                        () => Get.find<AddressViewController>().getCheckOutAddress.address != null
                                            ? Padding(
                                                padding: const EdgeInsets.only(left: 49),
                                                child: SizedBox(
                                                    width: MediaQuery.of(context).size.width,
                                                    child: textView15(
                                                        context: context,
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
                                        padding: 5,
                                        radius: 10,
                                        color: ColorResource.lightHintTextColor,
                                        blur: 0,
                                        onTap: () {
                                          // change address
                                          pickAddress();
                                        },
                                        text: Obx(() => textView15(
                                            context: context,
                                            text: Get.find<AddressViewController>().getAddressModelList.isNotEmpty
                                                ? "change".tr
                                                : 'add_address'.tr,
                                            color: ColorResource.primaryColor,
                                            fontWeight: FontWeight.w500))),
                                  ),
                                ]),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15, bottom: 5),
                                    child: textView20(context: context, text: "product".tr),
                                  ),
                                  Container(
                                    decoration: customDecoration(
                                        radius: 10, shadowBlur: 2, shadowColor: ColorResource.lightShadowColor50),
                                    padding: const EdgeInsets.only(left: 5, top: 5),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(right: 10),
                                          height: 90,
                                          width: 90,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: FadeInImage.assetNetwork(
                                                placeholder: "assets/images/placeholder_img.png",
                                                placeholderFit: BoxFit.contain,
                                                fadeInDuration: const Duration(seconds: 1),
                                                fit: BoxFit.contain,
                                                image:
                                                    '${Get.find<ConfigController>().configModel.baseUrls?.baseProductThumbnailUrl}/${Get.find<InstallmentViewController>().getInstallmentProductImg}',
                                                imageErrorBuilder: (c, o, s) => Image.asset(
                                                  "assets/images/placeholder_img.png",
                                                  fit: BoxFit.contain,
                                                ),
                                              )),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                                            child: Column(
                                              children: [
                                                textView15(
                                                    context: context,
                                                    text: Get.find<InstallmentViewController>()
                                                        .getInstallmentCheckOutModel
                                                        .data!
                                                        .productName
                                                        .toString(),
                                                    fontWeight: FontWeight.w600,
                                                    maxLine: 5,
                                                    color: ColorResource.lightTextColor),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    textView20(
                                                        context: context,
                                                        text: PriceConverter.currencySignAlignment(double.parse(
                                                            Get.find<InstallmentViewController>()
                                                                .getInstallmentCheckOutModel
                                                                .data!
                                                                .totalProductPricing
                                                                .toString())),
                                                        // text: PriceConverter.currencySignAlignment(cartModelList[index].price!),
                                                        maxLine: 1,
                                                        fontWeight: FontWeight.w600,
                                                        color: ColorResource.primaryColor),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20,
                                      bottom: 5,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(() => textView15(
                                            context: context,
                                            text: PriceConverter.currencySignAlignment(double.parse(
                                                Get.find<InstallmentViewController>()
                                                    .getInstallmentCheckOutModel
                                                    .data!
                                                    .totalProductPricing
                                                    .toString())),
                                            color: ColorResource.primaryColor)),
                                        textView15(context: context, text: "total_price".tr),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(() => textView15(
                                            context: context,
                                            text:
                                                '${Get.find<InstallmentViewController>().getInstallmentCheckOutModel.data!.downPayment.toString()} %',
                                            color: ColorResource.primaryColor)),
                                        textView15(context: context, text: "down_payment".tr),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(() => textView15(
                                            context: context,
                                            text:
                                                "${Get.find<InstallmentViewController>().getInstallmentCheckOutModel.data!.interestRate.toString()} %",
                                            color: ColorResource.primaryColor)),
                                        textView15(context: context, text: "interest_rate".tr),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(() => textView15(
                                            context: context,
                                            text:
                                                "${Get.find<InstallmentViewController>().getInstallmentCheckOutModel.data!.installmentFee.toString()} %",
                                            color: ColorResource.primaryColor)),
                                        textView15(context: context, text: "fee".tr),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(() => textView15(
                                            context: context,
                                            text: PriceConverter.currencySignAlignment(double.parse(
                                                Get.find<InstallmentViewController>()
                                                    .getInstallmentCheckOutModel
                                                    .data!
                                                    .totalOutStandingBalance
                                                    .toString())),
                                            color: ColorResource.primaryColor)),
                                        textView15(context: context, text: "outstanding_balance".tr),
                                      ],
                                    ),
                                  ),
                                  // Divider(
                                  //   height: 1,
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height - 100,
                          child: loaderFullScreenView(context, true)))),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Wrap(
                  direction: Axis.vertical,
                  children: [
                    textView15(context: context, text: "total_payable".tr, maxLine: 1, fontWeight: FontWeight.w600),
                    textView25(
                        context: context,
                        text: Get.find<InstallmentViewController>().getInstallmentCheckOutModel.data != null
                            ? PriceConverter.currencySignAlignment(double.parse(Get.find<InstallmentViewController>()
                                .getInstallmentCheckOutModel
                                .data!
                                .totalDownPaymentWithServiceFee
                                .toString()))
                            : "\$0.00",
                        color: ColorResource.primaryColor)
                  ],
                ),
              ),
              customTextButton(
                  onTap: () {
                    //  paymentDialog(context);
                    availableOnlinePayment(context);
                  },
                  text: textView18(
                    context: context,
                    text: 'process_to_pay'.tr,
                    fontWeight: FontWeight.w600,
                    color: ColorResource.whiteColor,
                  ),
                  color: ColorResource.primaryColor,
                  radius: 15,
                  height: 50),
            ],
          ),
        ),
      ),
      Obx(() => loaderFullScreenView(context, Get.find<InstallmentViewController>().getLoading))
    ]);
  }

  // void paymentDialog(BuildContext buildContext) {
  //   bool? isZeroPayment = Get.find<InstallmentViewController>().getInstallmentCheckOutModel.data?.allowZeroPayment;
  //   customBottomSheetDialogWrap(
  //       context: context,
  //       child: Stack(children: [
  //         Wrap(children: [
  //           Padding(
  //             padding: const EdgeInsets.only(bottom: 20),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 TextViewSize_20(context: context, text: 'choose_way_to_pay'.tr),
  //                 CustomIconButton(
  //                     padding: 3,
  //                     height: 30,
  //                     width: 30,
  //                     icon: Icon(Icons.clear),
  //                     onTap: () {
  //                       Navigator.pop(context);
  //                     }),
  //               ],
  //             ),
  //           ),
  //           Opacity(
  //             opacity: isZeroPayment == false ? 1 : 0.3,
  //             child: Container(
  //                 decoration: CustomDecoration(radius: 10, shadowBlur: 2),
  //                 margin: EdgeInsets.only(top: 5, bottom: 5),
  //                 padding: EdgeInsets.only(left: 10, right: 10),
  //                 height: 66,
  //                 child: Material(
  //                     color: ColorResource.whiteColor,
  //                     child: InkWell(
  //                       onTap: () async {
  //                         if (!isZeroPayment!) {
  //                           setState(() {
  //                             abaPayStatus = true;
  //                           });
  //                           Navigator.pop(context);
  //                           Get.find<AbaPayViewController>().openAbaDeeplink(
  //                             Get.find<InstallmentViewController>()
  //                                 .getInstallmentCheckOutModel
  //                                 .data!
  //                                 .paymentMethods!
  //                                 .aba!
  //                                 .deepLink!
  //                                 .toString(),
  //                           );
  //                           // Get.find<AbaPayViewController>().getAbaPayHash(
  //                           //     Get.find<AddressViewController>().getCheckOutAddress.address.toString(),
  //                           //     Get.find<AddressViewController>().getCheckOutAddress.id.toString(),
  //                           //     '',
  //                           //     0.0,
  //                           //     showLoader: false, callback: () {
  //                           //   setState(() {
  //                           //     abaPayStatus = true;
  //                           //   });
  //                           //   Get.find<AbaPayViewController>().openAbaDeeplink(
  //                           //     Get.find<InstallmentViewController>().getInstallmentCheckOutModel.data!.paymentMethods!.aba!.deepLink!,
  //                           //   );
  //                           // });
  //                         }
  //                         //   Get.to(AbaPayView());
  //                       },
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Image.asset(
  //                             "assets/images/aba_pay.png",
  //                             height: 30,
  //                           ),
  //                           SizedBox(
  //                             width: 5,
  //                           ),
  //                           Expanded(
  //                             child: Column(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 TextViewSize_16(context: context, text: "ABA PAY"),
  //                                 TextViewSize_13(
  //                                     context: context,
  //                                     text: "Tap to pay with ABA Mobile",
  //                                     color: ColorResource.lightShadowColor,
  //                                     fontWeight: FontWeight.w400)
  //                               ],
  //                             ),
  //                           ),
  //                           CustomIconButton(
  //                               blur: 0,
  //                               color: ColorResource.lightHintTextColor,
  //                               radius: 5,
  //                               padding: 0,
  //                               height: 25,
  //                               width: 25,
  //                               icon: Icon(
  //                                 Icons.arrow_forward_ios_rounded,
  //                                 size: 15,
  //                               ))
  //                         ],
  //                       ),
  //                     ))),
  //           ),
  //           Opacity(
  //             opacity: isZeroPayment == false ? 1 : 0.3,
  //             child: Container(
  //                 decoration: CustomDecoration(radius: 10, shadowBlur: 2),
  //                 margin: EdgeInsets.only(top: 5, bottom: 5),
  //                 padding: EdgeInsets.only(left: 10, right: 10),
  //                 height: 66,
  //                 child: Material(
  //                     color: ColorResource.whiteColor,
  //                     child: InkWell(
  //                       onTap: () async {
  //                         Navigator.pop(context);
  //                         Get.to(AbaPayView(
  //                           Get.find<AddressViewController>().getCheckOutAddress,
  //                           isInstallmentCheckOut: true,
  //                           paymentId: "1",
  //                         ));
  //                       },
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Image.asset(
  //                             "assets/images/aba_card.png",
  //                             height: 30,
  //                           ),
  //                           SizedBox(
  //                             width: 5,
  //                           ),
  //                           Expanded(
  //                             child: Column(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 TextViewSize_16(context: context, text: "Credit/Debit Card"),
  //                                 Image.asset(
  //                                   "assets/images/aba_accept_card.png",
  //                                   height: 10,
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           CustomIconButton(
  //                               blur: 0,
  //                               color: ColorResource.lightHintTextColor,
  //                               radius: 5,
  //                               padding: 0,
  //                               height: 25,
  //                               width: 25,
  //                               icon: Icon(
  //                                 Icons.arrow_forward_ios_rounded,
  //                                 size: 15,
  //                               ))
  //                         ],
  //                       ),
  //                     ))),
  //           ),
  //           Container(
  //               decoration: CustomDecoration(radius: 10, shadowBlur: 2),
  //               margin: EdgeInsets.only(top: 5, bottom: 5),
  //               padding: EdgeInsets.only(left: 10, right: 10),
  //               height: 66,
  //               child: Material(
  //                   color: ColorResource.whiteColor,
  //                   child: InkWell(
  //                     onTap: () async {
  //                       Navigator.pop(context);
  //                       Get.find<InstallmentViewController>().installmentCheckOut(
  //                           Get.find<InstallmentViewController>()
  //                               .getInstallmentCheckOutModel
  //                               .data!
  //                               .paymentMethods!
  //                               .zeroPayment
  //                               .toString(), (status) {
  //                         if (status) {
  //                           Navigator.popUntil(context, ModalRoute.withName('/'));
  //                           alertDialogMessageView("thank_you".tr,
  //                               context: context,
  //                               message: 'order_success_msg'.tr,
  //                               icon: Image.asset(
  //                                 "assets/images/order_place_ic.png",
  //                                 width: 62,
  //                               ));
  //                         } else {
  //                           alertDialogMessageView("sorry".tr,
  //                               context: context,
  //                               message: 'order_failed'.tr,
  //                               icon: Image.asset(
  //                                 "assets/images/order_place_ic.png",
  //                                 width: 62,
  //                               ));
  //                         }
  //                       });
  //                     },
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         TextViewSize_20(context: context, text: "cash_delivery".tr),
  //                         CustomIconButton(
  //                             blur: 0,
  //                             color: ColorResource.lightHintTextColor,
  //                             radius: 5,
  //                             padding: 0,
  //                             height: 25,
  //                             width: 25,
  //                             icon: Icon(
  //                               Icons.arrow_forward_ios_rounded,
  //                               size: 15,
  //                             ))
  //                       ],
  //                     ),
  //                   ))),
  //         ]),
  //       ]));
  // }

  Future<void> availableOnlinePayment(BuildContext buildContext) async {
    Get.find<InstallmentViewController>().getAvailableInstallmentOnlinePayment(widget.lenderId);
    bool? isZeroPayment = Get.find<InstallmentViewController>().getInstallmentCheckOutModel.data?.allowZeroPayment;
    customBottomSheetDialogWrap(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 25),
      context: buildContext,
      child: Wrap(
        children: [
          Get.find<InstallmentViewController>().obx(
            (state) => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: Get.find<InstallmentViewController>().getAvailableOnlinePaymentModel.length,
                itemBuilder: (BuildContext context, int index) {
                  var availableOnlinePayment = Get.find<InstallmentViewController>().getAvailableOnlinePaymentModel;
                  return Opacity(
                    opacity: isZeroPayment == false ? 1 : 0.3,
                    child: Container(
                        decoration: customDecoration(radius: 10, shadowBlur: 2),
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        height: 66,
                        child: Material(
                            color: ColorResource.whiteColor,
                            child: InkWell(
                              onTap: () async {
                                if (isZeroPayment == false) {
                                  Get.find<InstallmentViewController>().showLoader();
                                  if (availableOnlinePayment[index].paymentOption == AppConstants.CARD_PAY) {
                                    abaPayStatus = false;
                                    vtnPayStatus = false;

                                    Navigator.pop(context);
                                    Get.find<AbaPayViewController>().getInstallmentsPaymentHash(
                                        context,
                                        widget.uuid,
                                        widget.lenderId,
                                        availableOnlinePayment[index].id.toString(),
                                        Get.find<AddressViewController>().getCheckOutAddress.id.toString(),
                                        "USD", (data) {
                                      tranId = data.tranId;
                                      Get.to(const AbaPayView());
                                    });
                                  } else if (availableOnlinePayment[index].paymentOption == AppConstants.ABA_PAY) {
                                    abaPayStatus = true;
                                    Navigator.pop(context);
                                    Get.find<AbaPayViewController>().getInstallmentsPaymentHash(
                                        context,
                                        widget.uuid,
                                        widget.lenderId,
                                        availableOnlinePayment[index].id.toString(),
                                        Get.find<AddressViewController>().getCheckOutAddress.id.toString(),
                                        "USD", (data) {
                                      tranId = data.tranId;
                                      Get.find<AbaPayViewController>().openAbaDeeplink(
                                        data.deepLink.toString(),
                                      );
                                    });
                                  } else if (availableOnlinePayment[index].paymentOption == AppConstants.VTN_PAY) {
                                    vtnPayStatus = true;
                                    Navigator.pop(context);
                                    Get.find<VattanacPayViewController>().getVtcInstallmentsPaymentHash(
                                        context,
                                        widget.uuid,
                                        widget.lenderId,
                                        availableOnlinePayment[index].id.toString(),
                                        'USD',
                                        Get.find<AddressViewController>().getCheckOutAddress.id.toString(),
                                        (data) => {
                                              tranId = data.tranId!,
                                              _getVtcPayment(data.tranId!, data.amount.toString(), 'USD', 'credit')
                                            });
                                  }
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FadeInImage(
                                    image: NetworkImage(
                                      availableOnlinePayment[index].lLogo.toString(),
                                    ),
                                    width: 40,
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
                                        textView16(
                                            context: context, text: availableOnlinePayment[index].title.toString()),
                                        availableOnlinePayment[index].description != null
                                            ? textView13(
                                                context: context,
                                                text: availableOnlinePayment[index].description.toString(),
                                                color: ColorResource.lightShadowColor,
                                                fontWeight: FontWeight.w400)
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
                            ))),
                  );
                }),
            onError: (s) => onErrorReloadButton(context, s.toString(), height: 200, onTap: () {
              Get.find<CheckOutController>().getAvailableOnlinePayment();
            }),
          ),
          isZeroPayment == true
              ? Container(
                  decoration: customDecoration(radius: 10, shadowBlur: 2),
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  height: 66,
                  child: Material(
                      color: ColorResource.whiteColor,
                      child: InkWell(
                        onTap: () async {
                          Get.find<InstallmentViewController>().showLoader();
                          Get.find<InstallmentViewController>().installmentCheckOut(
                              Get.find<InstallmentViewController>()
                                  .getInstallmentCheckOutModel
                                  .data!
                                  .paymentMethods!
                                  .zeroPayment
                                  .toString(), (data) {
                            Get.find<InstallmentViewController>().stopLoader();
                            Get.find<CheckOutController>().orderSuccessListener.add(AppConstants.INSTALLMENT_PAY_SUCCESS_CODE);
                            Navigator.popUntil(context, ModalRoute.withName('/'));
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textView16(context: context, text: "submit".tr),
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
                      )))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  // void availableOnlinePayment(BuildContext buildContext) {
  //   //  Get.find<CartController>().clearLoadingStatus();
  //   Get.find<InstallmentViewController>().getAvailableInstallmentOnlinePayment(widget.lenderId);
  //   bool? isZeroPayment = Get.find<InstallmentViewController>().getInstallmentCheckOutModel.data?.allowZeroPayment;
  //   customBottomSheetDialogWrap(
  //     padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
  //     context: buildContext,
  //     child: Wrap(
  //       children: [
  //         Obx(
  //           () => Get.find<InstallmentViewController>().getAvailableOnlinePaymentModel.length > 0
  //               ? ListView.builder(
  //                   shrinkWrap: true,
  //                   physics: NeverScrollableScrollPhysics(),
  //                   itemCount: Get.find<InstallmentViewController>().getAvailableOnlinePaymentModel.length,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     var availableOnlinePayment = Get.find<InstallmentViewController>().getAvailableOnlinePaymentModel;
  //                     return Container(
  //                         decoration: CustomDecoration(radius: 10, shadowBlur: 2),
  //                         margin: EdgeInsets.only(top: 5, bottom: 5),
  //                         padding: EdgeInsets.only(left: 10, right: 10),
  //                         height: 66,
  //                         child: Material(
  //                             color: ColorResource.whiteColor,
  //                             child: InkWell(
  //                               onTap: () async {
  //                                 Get.find<InstallmentViewController>().stopLoader();
  //                                 if (availableOnlinePayment[index].paymentOption == AppConstants.CARD_PAY) {
  //                                   abaPayStatus = false;
  //                                   vtnPayStatus = false;
  //
  //                                   Get.find<AbaPayViewController>().getInstallmentsPaymentHash(
  //                                       context,
  //                                       widget.uuid,
  //                                       widget.lenderId,
  //                                       availableOnlinePayment[index].id.toString(),
  //                                       'USD',
  //                                       Get.find<AddressViewController>().getCheckOutAddress.id.toString(),
  //                                           (data) => {
  //                                          tranId = data.tranId!,
  //                                          Navigator.pop(context),
  //                                           Get.to(AbaPayView())
  //                                       });
  //
  //
  //
  //                                 } else if (availableOnlinePayment[index].paymentOption == AppConstants.ABA_PAY) {
  //                                   abaPayStatus = true;
  //                              //     Navigator.pop(context);
  //                                   // Get.find<AbaPayViewController>().getAbaPayHash(
  //                                   //     Get.find<AddressViewController>().getCheckOutAddress.address.toString(),
  //                                   //     Get.find<AddressViewController>().getCheckOutAddress.id.toString(),
  //                                   //     '',
  //                                   //     0.0,
  //                                   //     showLoader: false, callback: () {
  //                                   //   setState(() {
  //                                   //     abaPayStatus = true;
  //                                   //   });
  //                                   //   Get.find<AbaPayViewController>().openAbaDeeplink(
  //                                   //     Get.find<InstallmentViewController>().getInstallmentCheckOutModel.data!.paymentMethods!.aba!.deepLink!,
  //                                   //   );
  //                                   // });
  //                                   Get.find<AbaPayViewController>().getInstallmentsPaymentHash(
  //                                       context,
  //                                       widget.uuid,
  //                                       widget.lenderId,
  //                                       availableOnlinePayment[index].id.toString(),
  //                                       'USD',
  //                                       Get.find<AddressViewController>().getCheckOutAddress.id.toString(),
  //                                           (data) => {
  //                                         tranId = data.tranId!,
  //                                         Navigator.pop(context),
  //                                           Get.find<AbaPayViewController>().openAbaDeeplink(
  //                                           data.deepLink.toString(),
  //                                           )
  //                                       });
  //
  //                                 } else if (availableOnlinePayment[index].paymentOption == AppConstants.VTN_PAY) {
  //                                   vtnPayStatus = true;
  //                               //    Navigator.pop(context);
  //                                   Get.find<VattanacPayViewController>().getVtcInstallmentsPaymentHash(
  //                                       context,
  //                                       widget.uuid,
  //                                       widget.lenderId,
  //                                       availableOnlinePayment[index].id.toString(),
  //                                       'USD',
  //                                       Get.find<AddressViewController>().getCheckOutAddress.id.toString(),
  //                                       (data) => {
  //                                             tranId = data.tranId!,
  //                                             Navigator.pop(context),
  //                                             _getVtcPayment(data.tranId!, data.amount.toString(), 'USD', 'credit')
  //                                           });
  //                                 } else {
  //
  //                                 }
  //                               },
  //                               child: Row(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 children: [
  //                                   FadeInImage(
  //                                     image: NetworkImage(
  //                                       availableOnlinePayment[index].lLogo.toString(),
  //                                     ),
  //                                     width: 40,
  //                                     height: 30,
  //                                     placeholder: AssetImage("assets/images/elephant_placholder.png"),
  //                                     imageErrorBuilder: (context, error, stackTrace) {
  //                                       return Icon(
  //                                         Icons.broken_image_outlined,
  //                                       );
  //                                     },
  //                                     fit: BoxFit.fitWidth,
  //                                   ),
  //
  //                                   SizedBox(
  //                                     width: 5,
  //                                   ),
  //                                   Expanded(
  //                                     child: Column(
  //                                       mainAxisAlignment: MainAxisAlignment.center,
  //                                       crossAxisAlignment: CrossAxisAlignment.start,
  //                                       children: [
  //                                         TextViewSize_16(
  //                                             context: context, text: availableOnlinePayment[index].title.toString()),
  //                                         availableOnlinePayment[index].description != null
  //                                             ? TextViewSize_13(
  //                                                 context: context,
  //                                                 text: availableOnlinePayment[index].description.toString(),
  //                                                 color: ColorResource.lightShadowColor,
  //                                                 fontWeight: FontWeight.w400)
  //                                             : SizedBox.shrink()
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   CustomIconButton(
  //                                       blur: 0,
  //                                       color: ColorResource.lightHintTextColor,
  //                                       radius: 5,
  //                                       padding: 0,
  //                                       height: 25,
  //                                       width: 25,
  //                                       icon: Icon(
  //                                         Icons.arrow_forward_ios_rounded,
  //                                         size: 15,
  //                                       ))
  //                                 ],
  //                               ),
  //                             )));
  //                   })
  //               : Container(
  //                   height: 200,
  //                   child:
  //                       OnErrorReloadButton(context, "", height: MediaQuery.of(context).size.height, onTap: () async {
  //                     await Get.find<InstallmentViewController>().getAvailableInstallmentOnlinePayment(widget.lenderId);
  //                   }),
  //                 ),
  //         ),
  //       ],
  //     ),
  //     // Obx(() =>
  //     //     Get.find<CartController>().getLoadingStatus == true ? CircularProgressIndicator() : SizedBox.shrink()),
  //   );
  // }

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

    Get.find<AddressViewController>().addingAddress.value = false;
    customBottomSheetDialogWrap(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      context: context,
      child: Wrap(
        children: [
          Center(
            child: textView16(
                context: context,
                text: "shipping_address".tr,
                maxLine: 1,
                color: ColorResource.darkTextColor,
                fontWeight: FontWeight.w500),
          ),
          Stack(alignment: Alignment.center, children: [
            Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: textView16(
                        context: context,
                        text: "choose_address_type".tr,
                        maxLine: 1,
                        color: ColorResource.darkTextColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Obx(
                  () => Padding(
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
                            icon: Image.asset("assets/images/home_ic.png",
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
                // Padding(
                //   padding: const EdgeInsets.all(5),
                //   child: DropdownButton<String>(
                //     icon: Icon(
                //       Icons.keyboard_arrow_down_rounded,
                //       size: 30,
                //     ),
                //     hint: Obx(
                //       () => TextViewSize_18(
                //           context: context,
                //           text: Get.find<AddressViewController>().addressType.value,
                //           maxLine: 1,
                //           color: ColorResource.darkTextColor,
                //           fontWeight: FontWeight.w700),
                //     ),
                //     underline: Container(),
                //     items: <String>['Home', 'Office', 'Other'].map((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: TextViewSize_15(context: context, text: value, color: ColorResource.darkTextColor),
                //       );
                //     }).toList(),
                //     onChanged: (text) {
                //       addressPick = true;
                //       Get.find<AddressViewController>().addressType.value = text!;
                //     },
                //   ),
                // ),
                InputTextFieldWithIcon(
                  readonly: true,
                  onTap: () async {
                    //TODO: context warning
                    Get.find<CheckOutController>().getCEAvailableCityModel().then((value) => {
                          AddressView.pickCityDialog(Get.find<CheckOutController>().getCeCityModel.cities!, context,
                              (city) {
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
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: InputTextFieldWithIcon(
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
                            text: textView12(context: context, text: "Map", fontWeight: FontWeight.w700),
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: InputTextFieldWithIcon(
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: InputTextFieldWithIcon(
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
          ]),
        ],
      ),
    );
  }
}
