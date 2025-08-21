import 'dart:async';

import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';

class DashBoardController extends BaseController {

  RxBool callback = false.obs;
  StreamController listener = StreamController<bool>.broadcast();

  StreamController listener1 = StreamController<bool>.broadcast();

  final RxInt _runningOrderCount = 0.obs;

  int get getPendingOrderCount => _runningOrderCount.value;

  @override
  void onClose() {
    listener.close();
    super.onClose();
  }

  void countPendingOrder(int count) {
    _runningOrderCount.value = count;
  }


}
