import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';
import 'package:myphsar/product/product_model.dart';

import '../../base_widget/snack_bar_message.dart';
import '../offers/OfferModel.dart';

class WishlistController extends BaseController {
  final BaseProvider _provider;

  WishlistController(this._provider);

  var wishlist = Products();

  final _wishlistModel = <Products>[].obs;
  final _offerModel = <OfferModel>[].obs;

  List<Products> get getAllWishlistModel => _wishlistModel;

  List<OfferModel> get getOfferModel => _offerModel;

  Map<String, dynamic> toJson(String id) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = id;
    return data;
  }

  Future addWishlist(BuildContext context, String productId) async {
    await _provider.addWishlistApiProvider(toJson(productId)).then((value) => {
          if (value.statusCode == 200)
            {
              if (context.mounted) {snackBarMessage(context, "add_to_wishlist".tr, bgColor: Colors.green)}
            }
          else
            {
              if (context.mounted) {snackBarMessage(context, value.statusCode.toString() + value.statusText.toString())}
            }
        });
  }

  Future removeWishlist(BuildContext context, String productId, int index) async {
    //  change(true, status: RxStatus.loading());
    await _provider.removeWishlistApiProvider(productId).then((value) => {
          if (value.statusCode == 200)
            {
              _wishlistModel.obs.value.removeAt(index),
              if (context.mounted)
                {
                  snackBarMessage(context, "delete_success".tr, bgColor: Colors.green),
                },
              notifySuccessResponse(_wishlistModel.length)
            }
          else
            {
              notifySuccessResponse(0),
              if (context.mounted)
                {
                  snackBarMessage(context, value.statusCode.toString() + "delete_wishlist_failed".tr),
                }
            }
        });
  }

  Future getAllWishlist(BuildContext context) async {
    change(true, status: RxStatus.loading());
    await _provider.getAllWishlistApiProvider().then((value) => {
          if (value.statusCode == 200)
            {
              if (value.bodyString == '[]')
                {
                  notifySuccessResponse(0),
                },
              _wishlistModel.obs.value.clear(),
              value.body.forEach((val) => {
                    _provider.getProductDetailApiProvider(val["product_id"].toString()).then((value) => {
                          if (value.statusCode == 200)
                            {
                              wishlist = Products.fromJson(value.body),
                              // wishlist.id = val["product_id"].toString(),
                              _wishlistModel.add(wishlist),
                              notifySuccessResponse(_wishlistModel.length),
                            }
                          else
                            {notifyErrorResponse("Error Code: ${value.statusCode}\n${value.statusText}")}
                        })
                  })
            }
          else
            {notifyErrorResponse("Error Code: ${value.statusCode}\n${value.statusText}")}
        });
  }

  Future getOffer(BuildContext context) async {
    change(true, status: RxStatus.loading());
    await _provider.getOfferApiProvider().then((value) => {
          if (value.statusCode == 200)
            {
              value.body.forEach((val) {
                _offerModel.add(OfferModel.fromJson(val));
              }),
              notifySuccessResponse(_offerModel.length)
            }
          else
            {notifyErrorResponse("Error Code: ${value.statusCode}\n${value.statusText}")}
        });
  }
}
