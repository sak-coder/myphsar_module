import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myphsar/app_constants.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';
import 'package:myphsar/cart/cart_controller.dart';
import 'package:myphsar/check_out/ce_express/ce_city_list_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'available_online_payment_model.dart';

enum SocketStatus { connect, error, success ,fail }

class CheckOutController extends BaseController {
  final BaseProvider _baseProvider;

  CheckOutController(this._baseProvider);



  final RxBool _loading = false.obs;

  final _paymentMethods = <PaymentMethods>[].obs;
  final _ceCityModel = CECityCityListModel().obs;



  List<PaymentMethods> get getAvailableOnlinePaymentModel => _paymentMethods;

  CECityCityListModel get getCeCityModel => _ceCityModel.value;

  bool get getLoading => _loading.value;
  StreamController orderSuccessListener = StreamController<int>.broadcast();
  IO.Socket socket =
      IO.io('https://socket.myphsar.com', IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());


  @override
  void onClose() {
    orderSuccessListener.close();
    recalculateCartAmount();
    socket.disconnect();
    socket.close();
    super.onClose();
  }

  Future connectToSocket(Function(SocketStatus) onEventTrigger) async {
    socket.connect();
    socket.onConnect((data) {
      onEventTrigger(SocketStatus.connect);
    });
    socket.on('success_payment', (data) => onEventTrigger(SocketStatus.success));
    socket.on('fail_payment', (data) => onEventTrigger(SocketStatus.fail));

    socket.onConnectError((data) => onEventTrigger(SocketStatus.error));
    socket.onDisconnect((_) => print('disconnect'));
  }

  Future emitCartSocket(List<dynamic> groupCardId) async {
    socket.emit('join_group', {'cartGroups': groupCardId});
  }

  void recalculateCartAmount() async {
    await Get.find<CartController>().reCalculateCartAmount();
  }

  void showLoader() async {
    _loading.value = true;
  }

  void stopLoader() async {
    _loading.value = false;
  }

  Future placeOrder(BuildContext context, String addressId, String couponCode, Function(bool) callBack) async {
    _loading.value = true;
    await _baseProvider.placeOrderApiProvider(addressId, couponCode).then((value) => {
          if (value.statusCode == 200)
            {_loading.value = false, callBack(true)}
          else
            {
              _loading.value = false, callBack(false)
            }
        });
  }

  Future getCEAvailableCityModel() async {
    await _baseProvider.getCeCityProvider().then((value) => {
          if (value.statusCode == 200)
            {
              _ceCityModel.value = CECityCityListModel.fromJson(value.body),

            }
        });
  }

  Future checkDeliveryFee(String cartId, String shippingId, String shippingMethodId) async {
    await _baseProvider
        .checkDeliveryFeeProvider(cartId: cartId, shippingId: shippingId, shippingMethodId: shippingMethodId)
        .then((value) => {
              if (value.statusCode == 200)
                {
                  _paymentMethods.value = AvailableOnlinePaymentModel.fromJson(value.body).paymentMethods!,
                }
              else
                {notifyErrorResponse("Error Code=${value.statusCode} \n${value.statusText}")}
            });
  }

  Future getAvailableOnlinePayment() async {
    change(true, status: RxStatus.loading());
    await _baseProvider.getAvailableOnlinePaymentProvider().then((value) => {
          if (value.statusCode == 200)
            {
              _loading.value = false,
              _paymentMethods.value = AvailableOnlinePaymentModel.fromJson(value.body).paymentMethods!,
              notifySuccessResponse(_paymentMethods.length)
            }
          else
            {
              _loading.value = false,
              notifyErrorResponse(value.statusText.toString())
            }
        });
  }

  void onLoader(bool status) async {
    _loading.value = status;
  }
}
