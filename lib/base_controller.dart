import 'package:get/get.dart';

class BaseController extends GetxController with StateMixin {
  RxBool infiniteLoading = false.obs;
  RxBool isLoading = false.obs;
  RxInt isEmptyResponse = 0.obs;
  RxInt responseStatusCode = 0.obs;
  RxString errorMessage = "UnKnow Error".obs;

  RxBool onOrderSuccess = false.obs;

  int get getEmptyStatus => isEmptyResponse.value;

  RxBool get loading => isLoading;

  int get getResponseStatusCode => responseStatusCode.value;

  String get getErrorMessage => errorMessage.value;

  RxBool get getInfiniteLoader => infiniteLoading;

  void setInfiniteLoader(bool status) {
    infiniteLoading.value = status;
  }

  void startLoading() {
    isLoading.value = true;
  }

  void response(int status) {
    isEmptyResponse.value = status;
  }

  void stopLoading() {
    isLoading.value = false;
  }

  void notifySuccessResponse(int dataSize) {
    change(false, status: RxStatus.success());
    infiniteLoading.value = false;
    if (dataSize == 0) {
      change(false, status: RxStatus.empty());
    }
  }

  void notifyErrorResponse(String errorMessage, {bool checkNetwork = true}) {
    infiniteLoading.value = false;
    // if (Get.find<ConnectivityController>().connectionStatus.value == false&& checkNetwork == true) {
    //   return;
    // }
    change(false, status: RxStatus.error(errorMessage));
  }

// bool checkResponse(int size, int statusCode){
//   return size > 0 && statusCode == 200;
// }
}
