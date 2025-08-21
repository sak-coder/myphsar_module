import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/account/address/shipping/shipping_method_model.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_widget/snack_bar_message.dart';

import '../../base_provider.dart';
import '../../cart/cart_controller.dart';
import 'AddressModel.dart';
import 'ParamAddAddressModel.dart';

class AddressViewController extends BaseController {
  final BaseProvider baseProvider;
  RxBool deletingAddress = false.obs;
  RxString addressType = "home_address".tr.obs;
  RxBool addingAddress = false.obs;

  AddressViewController(this.baseProvider);

  final _checkOutAddress = AddressModel().obs;
  final _addressModel = <AddressModel>[].obs;
  final _shippingMethod = <ShippingMethodModel>[].obs;

  final _mapModel = MapModel().obs;

  AddressModel get getCheckOutAddress => _checkOutAddress.value;

  MapModel get getMapModel => _mapModel.value;

  List<AddressModel> get getAddressModelList => _addressModel;

  StreamController mapPickListener = StreamController<MapModel>.broadcast();

  @override
  void onClose() {
    mapPickListener.close();
    super.onClose();
  }

  List<ShippingMethodModel> get getShippingMethodList => _shippingMethod;

  void pickAddress(int index) {
    if (_checkOutAddress.value.id != _addressModel[index].id) {
      Get.find<CartController>().resetAddShippingMethodStatus();
      _checkOutAddress.value = _addressModel[index];
    }
  }

  void addMapModel(String address, double lat, double lang) {
    // mapPickListener.add(1);
    mapPickListener.add(MapModel(address: "address", lat: 11, lang: 11));
  }

  Future deleteAddress(BuildContext context, String id, int index) async {
    deletingAddress.value = true;
    await baseProvider.deleteAddressApiProvider(id).then((value) => {
          if (value.statusCode == 200)
            {
              deletingAddress.value = false,
              _addressModel.obs.value.removeAt(index),
              if (getAddressModelList.isEmpty)
                {
                  notifySuccessResponse(0),
                },
              //  successAlertDialogView(context, "delete_success".tr),
              if (context.mounted) {snackBarMessage(context, 'delete_success'.tr, bgColor: Colors.green)}
            }
          else
            {
              deletingAddress.value = false,
              if (context.mounted) {snackBarMessage(context, 'remove_address_field'.tr)}
            }
        });
  }

  String getShippingTitle(String id) {
    var title = 'empty';
    for (var element in getShippingMethodList) {
      if (id.contains(element.id.toString())) {
        title = element.title.toString();
      }
    }
    return title;
  }

  Future getShippingMethod({bool isLoading=true}) async {
    if(isLoading){
      change(false, status: RxStatus.loading());
    }

     await baseProvider.getShippingMethodListApiProvider().then((value) => {
          if (value.statusCode == 200)
            {
              _shippingMethod.obs.value.clear(),

              value.body.forEach((value) => {
                  _shippingMethod.add(ShippingMethodModel.fromJson(value)),
                },
              ),
              notifySuccessResponse(_shippingMethod.length),
              //    Get.find<SharePrefController>().saveShippingMethodProfile(value.body.toString()),
            }
          else
            {
              notifyErrorResponse(value.statusText.toString())
            }
        });
  }

  Future getAllAddress() async {
    change(true, status: RxStatus.loading());
    await baseProvider.getAddressListApiProvider().then((value) => {
          if (value.statusCode == 200)
            {
              _addressModel.obs.value.clear(),
              value.body.forEach(
                (value) => {
                  _addressModel.add(AddressModel.fromJson(value)),
                },
              ),
              if (_addressModel.isNotEmpty) {pickAddress(0)},
              notifySuccessResponse(_addressModel.length)
            }
          else
            {notifyErrorResponse(value.statusText.toString())}
        });
  }

  Future addAddress(ParamAddAddressModel paramAddAddressModel, BuildContext context) async {
    addingAddress.value = true;
    await baseProvider.addAddressApiProvider(paramAddAddressModel).then((value) => {
          if (value.statusCode == 200)
            {
              addingAddress.value == false,
              getAllAddress(),
              if (context.mounted)
                {
                  Navigator.pop(context),
                }
            }
          else
            {
              addingAddress.value == false,
            }
        });
  }
}

class MapModel {
  String? address;
  double? lat;
  double? lang;

  MapModel({this.address, this.lat, this.lang});
}
