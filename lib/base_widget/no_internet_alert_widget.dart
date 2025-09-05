// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:myphsar/base_widget/custom_decoration.dart';
// import 'package:myphsar/base_widget/myphsar_text_view.dart';
//
// import '../base_colors.dart';
// import '../utils/connectivity_controller.dart';
//
// ObxWidget noInternetAlertWidget(BuildContext context) {
//   return Obx(
//     () => AnimatedContainer(
//       height: Get.find<ConnectivityController>().connectionType.value == 0 ? 40 : 0,
//       // Define how long the animation should take.
//       duration: const Duration(milliseconds: 300),
//       // Provide an optional curve to make the animation feel smoother.
//
//       child: Container(
//         decoration: customDecoration(color: ColorResource.secondaryColor, shadowBlur: 3),
//         alignment: Alignment.center,
//         padding: const EdgeInsets.only(bottom: 5, top: 5),
//         child: textView15(
//           fontWeight: FontWeight.w700,
//           text: Get.find<ConnectivityController>().connectionStatus.isFalse ? "no_internet_con".tr : "connected".tr,
//           context: context,
//           color: ColorResource.whiteColor,
//         ),
//       ),
//     ),
//   );
// }
