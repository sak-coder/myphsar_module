import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';

import '../app_constants.dart';
import '../check_out/check_out_controller.dart';
import '../installment/installment_view_controller.dart';

class CcuPayView extends StatefulWidget {
  final String? fromUrl;

  const CcuPayView({super.key, this.fromUrl});

  @override
  State<CcuPayView> createState() => _CcuPayViewState();
}

class _CcuPayViewState extends State<CcuPayView> {
  InAppWebViewController? controllerGlobal;

  InAppWebViewSettings options = InAppWebViewSettings(
    javaScriptEnabled: true,
    javaScriptCanOpenWindowsAutomatically: true,
    supportZoom: false,
  );

  @override
  void initState() {
    Get.find<CheckOutController>().connectToSocket((status) =>
    {
      if (status == SocketStatus.success){
        Get.find<CheckOutController>().orderSuccessListener.add(AppConstants.PAY_SUCCESS_CODE)
      }
      else if(status == SocketStatus.fail){
        Get.find<CheckOutController>().orderSuccessListener.add(AppConstants.PAY_FAILED_CODE)
      }});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(elevation: 1, context: context, titleText: "payment".tr),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            Get.find<CheckOutController>().stopLoader();
            Navigator.pop(context);
          }
        },
        child: InAppWebView(
          initialSettings: options,
          initialUrlRequest: URLRequest(url: WebUri(widget.fromUrl.toString())),
          onWebViewCreated: (controller) async {
            controllerGlobal = controller;
          },
          onLoadStart: (controller, url) async {
            Get.find<CheckOutController>().onLoader(true);
          },
          onLoadStop: (controller, url) async {
            if (url!.path.toString() == "/payment/merchants/ecom/finish.html") {
              Get.find<CheckOutController>().onLoader(false);

            } else {
              Get.find<CheckOutController>().onLoader(true);
            }
          },
        ),
      ),
    );
  }
}
