import 'package:get/get.dart';
import 'package:myphsar/category/category_controller.dart';

import '../../product/product_model.dart';

class CategoryDetailController extends CategoryController {
  CategoryDetailController(super.categoryProvider);

  final _products = <Products>[].obs;

  List<Products> get getAllProductCategoryList => _products;

  void resetCategoryProductData() {
    _products.value = [];
  }

  Future getAllCategoryDetailProduct(String id, int offset, {bool resetData = false}) async {
    if (resetData) {
      _products.obs.value.clear();
    }

    if (offset > 1) {
      infiniteLoading.value = true;
    } else {
      change(true, status: RxStatus.loading());
    }

    await categoryProvider.getAllCategoryDetailApiProvider(id, offset.toString()).then((value) => {
          if (value.statusCode == 200)
            {
              value.body.forEach(
                (value) => {
                  _products.add(Products.fromJson(value)),
                },
              ),
              notifySuccessResponse(_products.length)
            }
          else
            {
              change(false, status: RxStatus.success())
              //   notifyErrorResponse("Error Code: " + value.statusCode.toString() + "\n" + value.statusText.toString())
            }
        });
  }
}
