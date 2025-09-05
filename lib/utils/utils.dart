import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Utils {
  // static Future<void> startLoading() async {
  //   Get.dialog(Container(
  //     color: Colors.transparent,
  //     child: Center(child: LoadingAnimationWidget.waveDots(color: Colors.red, size: 50)),
  //   ));
  // }

  static Future<void> stopLoading() async {
    Get.back();
  }

  static Future<void> showError(String error) async {
    Get.snackbar(error, 'Successfully created',
        margin: const EdgeInsets.all(20),
        colorText: Colors.red,
        animationDuration: const Duration(milliseconds: 500),
        icon: const Icon(Icons.icecream_outlined),
        // backgroundGradient: const LinearGradient(
        //   begin: Alignment.topRight,
        //   end: Alignment.bottomLeft,
        //   stops: [
        //     0.1,
        //     0.4,
        //     0.6,
        //     0.9,
        //   ],
        //   colors: [
        //     Colors.yellow,
        //     Colors.red,
        //     Colors.indigo,
        //     Colors.teal,
        //   ],
        // ),
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }
}
