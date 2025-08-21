import 'dart:io';

//import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
//import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/aba_pay/aba_pay_model.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';
import 'package:myphsar/base_widget/snack_bar_message.dart';
import 'package:myphsar/check_out/check_out_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import 'aba_payment_model.dart';

class AbaPayViewController extends BaseController {
  final BaseProvider _baseProvider;

  AbaPayViewController(this._baseProvider);

  final _abaPaymentModel = AbaPaymentModel().obs;
  final RxInt _status = 0.obs;

  final RxBool _getRequest = false.obs;
  final RxBool _getAbaPayLoading = false.obs;

  bool get getAbaPayLoading => _getAbaPayLoading.value;

  bool get getRequestStatus => _getRequest.value;

  int get getPaymentStatus => _status.value;

  AbaPaymentModel get getAbaPaymentModel => _abaPaymentModel.value;

  void notifyLoading() {
    change(false, status: RxStatus.success());
  }

  Future getInstallmentsPaymentHash(BuildContext context, String installmentUuid, String lenderId, String paymentId,
      String currency, String addressId, Function(AbaPaymentModel) callbackStatus) async {
    await _baseProvider
        .getAvailableInstallmentsPaymentProvider(
            installmentsUuid: installmentUuid,
            lenderId: lenderId,
            paymentId: paymentId,
            currency: currency,
            addressId: addressId)
        .then((value) => {
              if (value.statusCode == 200)
                {
                  _abaPaymentModel.value = AbaPaymentModel.fromJson(value.body),
                  callbackStatus(AbaPaymentModel.fromJson(value.body))
                }
              else
                {
                  notifyErrorResponse(value.statusText.toString()),
                }
            });
  }

  Future getAbaPayHash(String paymentId, String addressId, String currency,
      {bool isCredit = true, Function(AbaPaymentModel)? callback}) async {
    if (isCredit) {
      change(true, status: RxStatus.loading());
    } else {
      Get.find<CheckOutController>().onLoader(true);
    }

    await _baseProvider
        .getPaymentHashProvider(id: paymentId, currency: currency, addressId: addressId)
        .then((value) => {
              if (value.statusCode == 200)
                {
                  _abaPaymentModel.value = AbaPaymentModel.fromJson(value.body),
                  Get.find<CheckOutController>().onLoader(false),
                  callback!(_abaPaymentModel.value),
                  Get.find<CheckOutController>().onLoader(false),
                }
              else
                {
                  Get.find<CheckOutController>().onLoader(false), notifyErrorResponse(value.statusText.toString())}
            });
  }

  Future getPaymentStatusRequest(BuildContext context, String tranId, Function(int) callbackStatus) async {
    Get.find<CheckOutController>().showLoader();
    await _baseProvider.getPaymentStatusProvider(tranId).then((value) => {
          if (value.statusCode == 200)
            {
              Get.find<CheckOutController>().stopLoader(),
              callbackStatus(AbaPaymentStatusModel.fromJson(value.body).status!)
            }
          else
            {
              Get.find<CheckOutController>().stopLoader(),
              if (value.statusCode != 422) {snackBarMessage(context, value.statusText.toString())},
            }
        });
  }

  Future getInstallmentPaymentStatusRequest(BuildContext context, String tranId, Function(int) callbackStatus) async {
    Get.find<CheckOutController>().showLoader();
    await _baseProvider.getPaymentStatusProvider(tranId).then((value) => {
          if (value.statusCode == 200)
            {
              Get.find<CheckOutController>().stopLoader(),
              callbackStatus(AbaPaymentStatusModel.fromJson(value.body).status!)
            }
          else
            {
              Get.find<CheckOutController>().stopLoader(),
              if (value.statusCode != 422) {snackBarMessage(context, value.statusText.toString())},
            }
        });
  }

  void showLoading() {
    change(true, status: RxStatus.loading());
  }

  @override
  void stopLoading() {
    change(true, status: RxStatus.success());
  }

  void openAbaDeeplink(String abaDeeplink) async {
    if (Platform.isAndroid) {
      final AndroidIntent intent = AndroidIntent(action: 'action_view', data: abaDeeplink);
      await intent.launch().onError(
          (error, stackTrace) => _launchUrl("https://play.google.com/store/apps/details?id=com.paygo24.ibank"));
    } else {
        int isOpen = await LaunchApp.openApp(iosUrlScheme: abaDeeplink);
        if (isOpen == 0) {
        _launchUrl("https://apps.apple.com/al/app/aba-mobile-bank/id968860649");
     }
    }
  }

  _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
