import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:myphsar/app_constants.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/installment/installment_view_controller.dart';

import '../check_out/check_out_controller.dart';
import 'aba_pay_view_controller.dart';

class AbaPayView extends StatefulWidget {
  const AbaPayView({super.key});

  @override
  State<AbaPayView> createState() => _AbaPayViewState();
}

class _AbaPayViewState extends State<AbaPayView> {
  InAppWebViewController? controllerGlobal;

  InAppWebViewSettings options = InAppWebViewSettings(
    javaScriptEnabled: true,
    cacheEnabled: true,
    javaScriptCanOpenWindowsAutomatically: true,
    supportZoom: false,

    // android: AndroidInAppWebViewOptions(useHybridComposition: true, thirdPartyCookiesEnabled: true),
    // ios: IOSInAppWebViewOptions(
    //   sharedCookiesEnabled: true,
    // ),
  );

  // @override
  // void initState() {
  //   super.initState();
  // }

  // void initData() async {
  //   if (widget.isInstallmentCheckOut == false) {
  //     Get.find<AbaPayViewController>().getAbaPayHash(widget.paymentId,widget.addressModel.id.toString(),"USD" ,);
  //   }
  //   else {
  //      Get.find<AbaPayViewController>().notifyLoading();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(elevation: 1, context: context, titleText: "payment".tr),
      body: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            exitApp(context);
          }
        },
        child: Column(
          children: [
            Expanded(
                child: Obx(
              () => InAppWebView(
                initialSettings: options,
                initialUrlRequest:
                    URLRequest(url: WebUri(Get.find<AbaPayViewController>().getAbaPaymentModel.embledUrl.toString())),
                onWebViewCreated: (controller) async {
                  controllerGlobal = controller;
                  //  PlatformInAppWebViewController.clearAllCache();
                },
                onLoadStart: (controller, url) async {
                  Get.find<CheckOutController>().onLoader(false);
                  if (url!.path.toString() == AppConstants.PAYWAY_CONPLETE ||
                      url.path == AppConstants.INSTALLMENT_PAYWAY_CONPLETE) {
                    Get.find<CheckOutController>().onLoader(true);
                  }
                },
                onLoadStop: (controller, url) async {
                  if (url!.path.toString() == AppConstants.PAYWAY_CONPLETE) {
                    Get.find<CheckOutController>().onLoader(false);
                    onSuccess(AppConstants.PAY_SUCCESS_CODE);
                  } else if (url.path == AppConstants.INSTALLMENT_PAYWAY_CONPLETE) {
                    Get.find<InstallmentViewController>().stopLoader();
                    onSuccess(AppConstants.INSTALLMENT_PAY_SUCCESS_CODE);
                    // onCompletePaymentDialog(
                    //     'thank_you'.tr, 'Your'.tr + "installments".tr + 'place_success_message'.tr);
                  }
                },
              ),
              // Obx(() => Visibility(
              //     visible: Get.find<CheckOutController>().getLoading,
              //     child: Container(
              //       alignment: AlignmentDirectional.center,
              //       height: MediaQuery.of(context).size.height,
              //       width: MediaQuery.of(context).size.width,
              //       color: Colors.white,
              //       child: CircularProgressIndicator(),
              //     ))),
            )),
          ],
        ),
      ),
    );
  }

  void onSuccess(int code) {
    if (code == AppConstants.PAY_SUCCESS_CODE || code == AppConstants.INSTALLMENT_PAY_SUCCESS_CODE) {
      Get.find<CheckOutController>().stopLoader();
      Get.find<CheckOutController>().orderSuccessListener.add(code);
    } else {
      Get.find<CheckOutController>().stopLoader();
    }
  }

  Future exitApp(BuildContext context) async {
    if (await controllerGlobal!.canGoBack()) {
      controllerGlobal!.goBack();
    } else {
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
