import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:myphsar/account/address/address_view_controller.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';

import '../base_colors.dart';
import '../base_widget/snack_bar_message.dart';

class PickMapView extends StatefulWidget {
  const PickMapView({super.key});

  @override
  State<PickMapView> createState() => _MapViewState();
}

class _MapViewState extends State<PickMapView> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(context: context, titleText: "shipping_address".tr),
      body: Container(),
      // body: FlutterLocationPicker(
      //     initPosition: const LatLong(11.5564, 104.9282),
      //     searchbarBorderRadius: BorderRadius.circular(15),
      //     searchbarInputFocusBorderp: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(15),
      //     ),
      //     markerIcon: const Icon(
      //       Icons.location_pin,
      //       size: 40,
      //       color: ColorResource.secondaryColor,
      //     ),
      //     searchbarInputBorder: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(15),
      //     ),
      //     searchBarHintText: "search".tr,
      //     locationButtonsColor: Colors.white,
      //     locationButtonBackgroundColor: ColorResource.orange,
      //     selectLocationButtonStyle: ButtonStyle(
      //       backgroundColor: WidgetStateProperty.all(ColorResource.primaryColor),
      //     ),
      //     selectLocationButtonText: 'pick_location'.tr,
      //     selectedLocationButtonTextStyle:
      //         const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
      //     selectLocationButtonLeadingIcon: Image.asset(
      //       "assets/images/location_ic.png",
      //       width: 20,
      //       color: Colors.white,
      //     ),
      //     initZoom: 11,
      //     showZoomController: false,
      //     contributorBadgeForOSMTextColor: ColorResource.greenColor,
      //     minZoomLevel: 5,
      //     maxZoomLevel: 16,
      //     onError: (e) => {snackBarMessage(context, e.toString())},
      //     onPicked: (pickedData) async {
      //       Get.find<AddressViewController>().mapPickListener.add(MapModel(
      //           address: pickedData.address, lat: pickedData.latLong.latitude, lang: pickedData.latLong.longitude));
      //       Navigator.pop(context);
      //     },
      //     onChanged: (pickedData) {}),
    );
  }
}
