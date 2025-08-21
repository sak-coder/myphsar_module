import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';
import 'package:myphsar/track_order/ce/ce_tracking_order_model.dart';

import 'tracking_model.dart';

class TrackingOrderViewController extends BaseController {
  final BaseProvider _baseProvider;

  TrackingOrderViewController(this._baseProvider);

  final _trackingModel = TrackingModel().obs;
  final _ceTrackingModel = CeTrackingOrderModel().obs;

  TrackingModel get getTrackingModel => _trackingModel.value;

  CeTrackingOrderModel get getCeTrackingModel => _ceTrackingModel.value;

  Future getTrackingHistoryDetail(BuildContext context, String orderId) async {
    change(true, status: RxStatus.loading());
    await _baseProvider.getTrackingApiProvider(orderId).then((value) => {
          if (value.statusCode == 200)
            {
              _trackingModel.value = TrackingModel.fromJson(value.body),
              notifySuccessResponse(1),
            }
          else
            {
              notifyErrorResponse("Error Code: ${value.statusCode}\n${value.statusText}"),
            }
        });
  }

  Future getCeTrackingHistoryDetail(BuildContext context, String orderId) async {
    change(true, status: RxStatus.loading());
    await _baseProvider.getCeTrackingApiProvider(orderId).then((value) => {
          if (value.statusCode == 200)
            {
              _ceTrackingModel.value = CeTrackingOrderModel.fromJson(value.body),
              notifySuccessResponse(1),
            }
          else
            {
              notifyErrorResponse("Error Code: ${value.statusCode}\n${value.statusText}"),
            }
        });
  }
}
