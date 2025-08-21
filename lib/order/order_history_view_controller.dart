import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';
import 'package:myphsar/dashborad/dash_board_controller.dart';
import 'package:myphsar/order/order_detail/order_detail_model.dart';
import 'package:myphsar/order/order_history_model.dart';

import '../app_constants.dart';
import '../base_widget/snack_bar_message.dart';

class OrderHistoryViewController extends BaseController {
  final BaseProvider _baseProvider;

  final _orderHistoryModelViewList = <OrderHistoryModel>[].obs;
  final _orderHistoryDetailModel = <OrderDetailModel>[].obs;
  final _orderHistoryModel = OrderHistoryModel().obs;

  final RxBool _runningOrderStatus = false.obs;
  final RxBool _cancelOrderStatus = false.obs;
  final RxBool _deliverOrderStatus = false.obs;
  final RxString _orderNumber = ''.obs;
  final RxBool _isIdFound = false.obs;

  bool get getCheckOrderId => _isIdFound.value;

  bool get getRunningStatus => _runningOrderStatus.value;

  bool get getCancelOrderStatus => _cancelOrderStatus.value;

  String get getPushOrderNumber => _orderNumber.value;

  bool get getDeliverOrderStatus => _deliverOrderStatus.value;

  List get getOrderHistoryList => _orderHistoryModelViewList;

  OrderHistoryModel get getOrderHistoryModel => _orderHistoryModel.value;

  List<OrderDetailModel> get getOrderHistoryDetail => _orderHistoryDetailModel;

  OrderHistoryViewController(this._baseProvider);

  void getOrderHistoryStatus() {
    var runningOrderCount = 0;
    for (var order in _orderHistoryModelViewList.obs.value) {
      if (order.orderStatus == AppConstants.RETURNED ||
          order.orderStatus == AppConstants.FAILED ||
          order.orderStatus == AppConstants.CANCELLED) {
        _cancelOrderStatus.value = true;
      }
      if (order.orderStatus == AppConstants.DELIVERED) {
        _deliverOrderStatus.value = true;
      }

      if (order.orderStatus == AppConstants.PENDING ||
          order.orderStatus == AppConstants.CONFIRMED ||
          order.orderStatus == AppConstants.PROCESSING ||
          order.orderStatus == AppConstants.OUT_FOR_DELIVERY) {
        runningOrderCount++;

        _runningOrderStatus.value = true;
      }
      Get.find<DashBoardController>().countPendingOrder(runningOrderCount);
    }
  }

  Future getAllOrderHistoryList({bool isReload = false}) async {
    _orderHistoryModelViewList.clear();
    change(false, status: RxStatus.loading());
    await _baseProvider.getOrderHistoryApiProvider().then((value) => {
          if (value.statusCode == 200)
            {
              value.body.forEach((orderHistory) {
                _orderHistoryModelViewList.obs.value
                    .add(OrderHistoryModel.fromJson(orderHistory));
              }),
              _orderHistoryModelViewList.obs.value.sort((a, b) {
                var aDate = a.createdAt.toString();
                var bDate = b.createdAt.toString();
                return bDate.compareTo(aDate);
              }),
              notifySuccessResponse(
                  _orderHistoryModelViewList.obs.value.length),
            }
          else
            {notifyErrorResponse(value.statusText.toString())}
        });
    getOrderHistoryStatus();
  }


  Future getAllOrderHistory(Function(OrderHistoryModel)? callback,String orderId ,) async {
  // change(true, status: RxStatus.loading());
    await _baseProvider.getOrderHistoryApiProvider().then((value) => {
          if (value.statusCode == 200)
            {
              value.body.forEach((orderHistory) {
                if (orderId == orderHistory["id"].toString()) {
                  callback!(OrderHistoryModel.fromJson(orderHistory));
                  notifySuccessResponse(1);
                  return;
                }
              }),
            }
          else {notifyErrorResponse(value.statusText.toString())}
        });
  }

  Future getOrderDetail(BuildContext context, String orderId) async {
    _orderHistoryDetailModel.clear();
    await _baseProvider
        .getOrderHistoryDetailApiProvider(orderId)
        .then((value) => {
              if (value.statusCode == 200)
                {
                  value.body.forEach((orderHistory) {
                    _orderHistoryDetailModel
                        .add(OrderDetailModel.fromJson(orderHistory));
                  }),
                }
              else
                {
                  snackBarMessage(
                      context,
                      value.statusCode.toString() +
                          "\n" +
                          value.statusText.toString())
                }
            });
  }
}
