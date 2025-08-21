import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';

import '../product/product_model.dart';
import 'shop_profile_model.dart';

class ShopProfileController extends BaseController {
  final BaseProvider _baseProvider;

  ShopProfileController(this._baseProvider);

  final _productList = <Products>[].obs;
  final _sortProductList = <Products>[].obs;
  final _categoryIdList = <String>[].obs;
  final _shopProfileModel = ShopProfileModel().obs;
  var mappingCatStatus = true.obs;

  List<Products> get getProductList => _productList;

  List<Products> get getSortProductList => _sortProductList;

  List<String> get getCategoryList => _categoryIdList;

  ShopProfileModel get getShopProfileModel => _shopProfileModel.value;

  void mapCategoryList() {
    _categoryIdList.clear();
    for (var product in _productList) {
      if (product.categoryIds!.length > 1) {
        if (!_categoryIdList.asMap().containsValue(product.categoryIds![1].name)) {
          _categoryIdList.add(product.categoryIds![1].name!);
        }
      }
    }
  }

  void sortProductByCategory(String cat) {
    _productList.obs.value.addAll(_sortProductList);
    for (int i = 0; i < _productList.length; i++) {
      if (_productList[i].categoryIds!.first.name!.contains(cat)) {
        _productList.add(_productList[i]);
      }
    }
  }

  void clearProductList() async {
    _productList.clear();
  }

  Future getAllShopProduct(String id, int offset) async {
    if (offset > 1) {
      infiniteLoading.value = true;
    } else {
      change(true, status: RxStatus.loading());
    }
    return await _baseProvider.getAllShopProductApiProvider(id, offset.toString()).then((value) => {
          if (value.statusCode == 200)
            {
              _productList.obs.value.addAll(ProductModel.fromJson(value.body).products!.toList()),
              _sortProductList.obs.value.addAll(_productList),
              notifySuccessResponse(_productList.length),
              mapCategoryList()
            }
          else
            {notifyErrorResponse("Error Code: ${value.statusCode}\n${value.statusText}")}
        });
  }

  Future getShopProfile(String shopId, {bool loader = false}) async {
    if (loader) {
      change(true, status: RxStatus.loading());
    }
    await _baseProvider.getSellerProfileApiProvider(shopId).then((value) => {
          if (value.statusCode == 200)
            {_shopProfileModel.value = ShopProfileModel.fromJson(value.body), notifySuccessResponse(1)}
          else
            {
              notifyErrorResponse("Error Code: ${value.statusCode}\n${value.statusText}"),
            }
        });
  }
}
