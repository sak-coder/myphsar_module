import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';

class ConnectivityController extends BaseController {
  var connectionType = 0.obs;
  RxBool connectionStatus = false.obs;

  late StreamSubscription<List<ConnectivityResult>> subscription;

  @override
  void onInit() {
    super.onInit();

    subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.mobile)) {
        connectionType.value = 1;
        connectionStatus.value = true;
      } else if (result.contains(ConnectivityResult.wifi)) {
        connectionType.value = 1;
        connectionStatus.value = true;
      } else {
        connectionType.value = 0;
        connectionStatus.value = false;
      }
    });
  }

  @override
  void onClose() {
    subscription.cancel();
  }
}
