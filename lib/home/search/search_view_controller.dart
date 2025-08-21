import 'dart:async';

import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';
import 'package:myphsar/helper/share_pref_controller.dart';
import 'package:myphsar/product/product_model.dart';

import 'search_recommend_model.dart';

extension E on String {
  String lastChars(int n) =>substring(n+1);
  String firstChars(int n) =>  substring(length - n);
}

enum TextLocation { start, end }

class SearchViewController extends BaseController {
  BaseProvider provider;
  StreamController applyFilterListener = StreamController<bool>.broadcast();

  SearchViewController(this.provider);

  var _productList = <Products>[].obs;

  // final _recommendSearchModel = SearchRecommendModel().obs;

  final _recommendProductList = <ProductList>[].obs;
  final _recommendCategoryList = <Categories>[].obs;
  final _recommendShopList = <Shops>[].obs;
  final _searchKeyList = <String>[].obs;

  RxBool isSearching = false.obs;

  List<Products> get getProductList => _productList;

  /// SearchRecommendModel get getRecommendSearchList => _recommendSearchModel;

  List<ProductList> get getRecommendProductList => _recommendProductList;

  List<Shops> get getRecommendShopList => _recommendShopList;

  List<Categories> get getRecommendCategoryList => _recommendCategoryList;

  List<String> get getSearchKeyList => _searchKeyList;

  RxBool isFocus = false.obs;

//  RxBool isFilterApply = false.obs;
  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = 0.0.obs;
  RxString categoryName = ''.obs;
  RxString cateId = ''.obs;

  Future resetData() async {
    _productList = <Products>[].obs;
  }

  // String getSearchFormatText(int index, String keyWord, TextLocation textLocation) {
  //   switch (textLocation) {
  //     case TextLocation.start:
  //       return _recommendProductList[index].name.toString().firstChars(keyWord.trim().length);
  //     case TextLocation.end:
  //       return _recommendProductList[index].name.toString().lastChars(keyWord.trim().length);
  //   }
  // }

  void applyFilter(String catName, String catId, double min, double max) {
    categoryName.value = catName;
    minPrice.value = min;
    maxPrice.value = max;
    cateId.value = catId;
  }

  void resetFilter() {
    categoryName.value = '';
    minPrice.value = 0.0;
    maxPrice.value = 0.0;
  }

  Future getSearchProduct(String name, int offset) async {
    if (offset > 1) {
      infiniteLoading.value = true;
    } else {
      change(true, status: RxStatus.loading());
    }
    int textCount = 0;

    if (name.length > 6) {
      textCount = name.length ~/ 2;
      name = name.substring(0, textCount).trim();
    }
    provider
        .getSearchProductApiProvider(name, offset, minPrice.toString(), maxPrice.toString(), cateId.toString())
        .then((value) => {
              if (value.statusCode == 200)
                {
                  _productList.obs.value.addAll(ProductModel.fromJson(value.body).products!.toList()),
                  notifySuccessResponse(_productList.length),
                }
              else if (value.statusCode == 500 || value.statusCode == 403)
                {notifySuccessResponse(0)}
              else
                {notifyErrorResponse(value.statusText.toString())}
            });
  }

  Future getRecommendSearchProduct(String name) async {
    if (name == "") return;

    await provider.getSearchRecommendApiProvider(name).then((value) => {
          if (value.statusCode == 200)
            {
              //  _recommendSearchModel.obs.value.add(SearchRecommendModel.fromJson(value.body)),
              _recommendProductList.clear(),
              _recommendCategoryList.clear(),
              _recommendShopList.clear(),

              _recommendProductList.obs.value.addAll(SearchRecommendModel.fromJson(value.body).productsList!.toList()),
              _recommendShopList.obs.value.addAll(SearchRecommendModel.fromJson(value.body).shops!.toList()),
              _recommendCategoryList.obs.value.addAll(SearchRecommendModel.fromJson(value.body).categories!.toList()),
              // notifySuccessResponse(_productList.length),
            }
          else
            notifyErrorResponse(value.statusText.toString())
        });
  }

  Future getSearchHistoryKeyList() async {
    _searchKeyList.value = Get.find<SharePrefController>().getSaveSearchHistory();
  }
}
