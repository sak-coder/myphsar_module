import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/check_out/check_out_controller.dart';

import '../base_controller.dart';
import '../base_provider.dart';
import '../base_widget/snack_bar_message.dart';
import '../installment/installment_view_controller.dart';
import 'vtc_payment_model.dart';

class VattanacPayViewController extends BaseController {
  final BaseProvider _baseProvider;

  VattanacPayViewController(this._baseProvider);

  void notifyLoading() {
    change(false, status: RxStatus.success());
  }

  Future getVtcInstallmentsPaymentHash(BuildContext context, String installmentUuid, String lenderId, String paymentId,
      String currency, String addressId, Function(VtcPaymentModel) callbackStatus) async {
    await _baseProvider
        .getAvailableInstallmentsPaymentProvider(
            installmentsUuid: installmentUuid,
            lenderId: lenderId,
            paymentId: paymentId,
            currency: currency,
            addressId: addressId)
        .then((value) => {
              if (value.statusCode == 200)
                {callbackStatus(VtcPaymentModel.fromJson(value.body))}
              else
                {
                  Get.find<InstallmentViewController>().stopLoader(),
                  if (context.mounted)
                    {
                      snackBarMessage(context, (value.statusText.toString())),
                    }
                }
            });
  }

  Future getVtcPaymentHash(BuildContext context, String paymentId, String currency, String addressId,
      Function(VtcPaymentModel) callbackStatus) async {
    await _baseProvider
        .getPaymentHashProvider(id: paymentId, currency: currency, addressId: addressId)
        .then((value) => {
              if (value.statusCode == 200)
                {
                  callbackStatus(VtcPaymentModel.fromJson(value.body))}
              else
                {
                  Get.find<CheckOutController>().stopLoader(),
                  if (context.mounted)
                    {
                      snackBarMessage(context, (value.statusText.toString())),
                    }
                }
            });
  }

  Future getPaidTranStatus({required String tid, required Function(bool) callback}) async {
    await _baseProvider.checkVtnTransactionApiProvider(tid).then((value) => {
          if (value.statusCode == 200)
            {
              if (value.body['success'] == true)
                {
                  callback(true),
                }
              else
                {
                  callback(false),
                }
            }
          else
            {
              callback(false),
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
}
