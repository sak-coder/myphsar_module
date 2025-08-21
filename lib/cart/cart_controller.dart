import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';
import 'package:myphsar/home/home_controller.dart';
import 'package:myphsar/product/product_model.dart';

import '../base_widget/snack_bar_message.dart';
import '../product_detail/product_detail_controller.dart';
import 'cart_model.dart';

class CartController extends BaseController {
  final BaseProvider _baseProvider;

  CartController(this._baseProvider);

  final RxString _shippingTitle = 'Choose Shipping Method'.obs;
  final RxDouble _totalAmount = 0.0.obs;
  final RxDouble _selectShippingCost = 0.0.obs;

  final RxBool _addShippingMethodStatus = false.obs;
  final RxDouble _couponDiscount = 0.0.obs;
  final RxDouble _subTotal = 0.0.obs;
  final RxDouble _totalDiscount = 0.0.obs;
  final RxBool _loadingStatus = false.obs;

  String get getShippingMethodTitle => _shippingTitle.value;

  double get getTotalAmount => _totalAmount.value;

  bool get gatSelectShippingMethod => _addShippingMethodStatus.value;

  double get getSelectedShippingCost => _selectShippingCost.value;

  double get getCouponDiscount => _couponDiscount.value;

  double get getSubTotal => _subTotal.value;

  double get getTotalDiscount => _totalDiscount.value;

  bool get getLoadingStatus => _loadingStatus.value;

  final _cartModelList = <CartModel>[].obs;

  List get getCartModelList => _cartModelList;

  void clearData() {
    _selectShippingCost.value = 0.0;
    _couponDiscount.value = 0.0;
    _shippingTitle.value = 'choose_shipping_method'.tr;
    _addShippingMethodStatus.value = false;
  }

  Future plusQty(int qty, int index) async {
    resetAddShippingMethodStatus();
    _cartModelList.obs.value[index].quantity = qty;
    _cartModelList.refresh();
    _totalAmount.value += _cartModelList.obs.value[index].price!;
    reCalculateTotalPrice(_cartModelList.obs.value, shippingCost: _selectShippingCost.value);
  }

  Future minusQty(int qty, int index) async {
    if (qty == 0) {
      return;
    }
    resetAddShippingMethodStatus();
    _cartModelList.obs.value[index].quantity = qty;
    _cartModelList.refresh();
    _totalAmount.value -= _cartModelList.obs.value[index].price!;

    reCalculateTotalPrice(_cartModelList.obs.value, shippingCost: _selectShippingCost.value);
  }

  Future addShippingCost(
      {required BuildContext context,
      required String groupCartId,
      required String shippingAddressId,
      required String shippingMethodId,
      required double cost,
      required bool isCE,
      String? title}) async {
    _loadingStatus.value = true;
    var checkShipping = <CheckShippingMethod>[].obs;

    await _baseProvider
        .checkChoosingDeliveryMethodProvider(
            isCE: isCE,
            groupCartId: groupCartId,
            shippingAddressId: shippingAddressId,
            shippingMethodId: shippingMethodId)
        .then((value) async => {
              if (value.statusCode == 200)
                {
                  await _baseProvider.checkStatusDeliveryMethodProvider().then((value) => {
                        if (value.statusCode == 200)
                          {
                            if (title != null) {_shippingTitle.value = title},

                            //TODO check with api response object not list
                            value.body.forEach(
                              (value) => {
                                checkShipping.add(CheckShippingMethod.fromJson(value)),
                              },
                            ),
                            if (checkShipping.isNotEmpty)
                              {
                                _selectShippingCost.value = checkShipping.first.shippingCost!.toDouble(),
                                reCalculateTotalPrice(_cartModelList, shippingCost: _selectShippingCost.value),
                                _addShippingMethodStatus.value = true,
                                _loadingStatus.value = false,
                              }
                          }
                        else
                          {
                            if (context.mounted) {snackBarMessage(context, value.statusText.toString())}
                          }
                      })
                }
              else
                {
                  _addShippingMethodStatus.value = false,
                  _loadingStatus.value = false,
                  if (context.mounted) {snackBarMessage(context, value.statusText.toString())}
                }
            });
  }

  Future getAllCartList() async {
    change(true, status: RxStatus.loading());
    _cartModelList.clear();
    await _baseProvider.getCartListApiProvider().then((value) => {
          if (value.statusCode == 200)
            {
              value.body.forEach((element) {
                var cartModel = CartModel.fromJson(element);
                _cartModelList.obs.value.add(cartModel);
                // totalPrice += cartModel.price! * cartModel.quantity!;
                // totalDis+=cartModel.discount!;
              }),

              reCalculateTotalPrice(_cartModelList),
              // _totalAmount.value = totalPrice,
              // _totalDiscount.value = totalDis,
              Get.find<HomeController>().cartCount.value = _cartModelList.obs.value.length,
              notifySuccessResponse(_cartModelList.obs.value.length)
            }
          else
            {
              notifyErrorResponse(value.statusText.toString())
            }
        });
  }

  Future reCalculateCartAmount() async {
    double subTotal = 0;
    double totalDis = 0;
    for (var cart in _cartModelList) {
      subTotal += cart.price! * cart.quantity!;
      totalDis += cart.discount! * cart.quantity!;
    }
    subTotal -= totalDis;
    _totalAmount.value = subTotal;
  }

  void reCalculateTotalPrice(List<CartModel> cartModel, {double shippingCost = 0}) {
    double subTotal = 0;
    double totalDis = 0;
    _totalAmount.value = 0;
    for (var cart in cartModel) {
      subTotal += cart.price! * cart.quantity!;
      totalDis += cart.discount! * cart.quantity!;
    }

    if (cartModel.isEmpty) {
      notifySuccessResponse(0);
    }

    _subTotal.value = subTotal;
    subTotal += shippingCost;
    subTotal -= totalDis;
    _totalDiscount.value = totalDis;
    _totalAmount.value = subTotal;
  }

  void resetAddShippingMethodStatus() {
    clearData();
    reCalculateTotalPrice(_cartModelList);
  }

  Future addToCart(BuildContext context, Products product, {required Function(String) callback}) async {
    var productDetail = Get.find<ProductDetailController>();
    Map<String, dynamic> cartParam = {'id': product.id, 'variant': product.variation, 'quantity': productDetail.getQty};

    var choiceOption = product.choiceOptions;
    Map<String, dynamic> choice = {};
    try {
      for (int index = 0; index < choiceOption!.length; index++) {
        choice.addAll(
            {choiceOption[index].name.toString(): choiceOption[index].options![productDetail.getChoiceOption[index]]});
      }

      cartParam.addAll(choice);

      if (product.colors!.isNotEmpty) {
        var selectedColor = product.colors![productDetail.getColorVariantIndex].code.toString();
        cartParam.addAll({'color': selectedColor});
      }
    } catch (val) {
      callback("choose_variant_msg".tr);
    }

    _loadingStatus.value = true;
    await _baseProvider.addToCartApiProvider(cartParam).then((value) => {
          _loadingStatus.value = false,
          if (value.statusCode == 200)
            {
              if (value.body['status'] == 0)
                {callback(value.body['message'].toString())}
              else
                {callback('added_to_cart'.tr), Get.find<CartController>().getAllCartList()},
            }
          else
            {_loadingStatus.value = false, callback("Error Code=${value.statusCode} \n${value.statusText}")}
        });
  }

  //
  // Future addShippingMethod(String shippingId, String allCartId) async {
  //   Map<String, dynamic> shippingParam = {'id': shippingId, 'cart_group_id': allCartId};
  //   _baseProvider.addShippingMethod(shippingParam).then((value) => {if (value.statusCode == 200) {} else {}});
  // }

  Future deleteAllCartProduct() async {
    _baseProvider.deleteAllCartProductApiProvider().then((value) => {
          if (value.statusCode == 200) {clearData(), _totalAmount.value = 0.0} else {}
        });
  }

  Future deleteCartProduct(BuildContext context, String id, int index,Function(int)? callback) async {
    Map<String, dynamic> key = {'key': id};
    _baseProvider.deleteCartProductApiProvider(key).then((value) => {
          if (value.statusCode == 200)
            {
              _cartModelList.obs.value.removeAt(index),
              _cartModelList.obs.value.reactive(),
              reCalculateTotalPrice(_cartModelList.obs.value),
              Get.find<HomeController>().cartCount - 1,
              if(_cartModelList.isEmpty){
                callback!(0)
              }
            }
          else
            {


            }
        });
  }

  Future updateCartProductQty(BuildContext context, int id, int qty) async {
    Map<String, dynamic> updateQty = {'key': id, 'quantity': qty};
    _baseProvider.updateCartProductApiProvider(updateQty).then((value) => {if (value.statusCode == 200) {} else {}});
  }

  void clearLoadingStatus() {
    _loadingStatus.value = false;
  }
}

class CheckShippingMethod {
  double? shippingCost;
  List<CheckShippingMethod>? ship;

  CheckShippingMethod({
    this.shippingCost,
  });

  CheckShippingMethod.fromJson(Map<String, dynamic> json) {
    shippingCost = double.tryParse(json['shipping_cost'].toString());
  }

  CheckShippingMethod.fromJsonList(List<dynamic> json) {
    ship = <CheckShippingMethod>[];
    for (var value in json) {
      ship!.add(CheckShippingMethod.fromJson(value));
    }
  }
}
