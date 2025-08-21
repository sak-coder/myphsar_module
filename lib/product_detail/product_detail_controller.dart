import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';

import '../product/product_model.dart';

class ProductDetailController extends BaseController {
  BaseProvider baseProvider;

  ProductDetailController(this.baseProvider);

  final _productList = <Products>[].obs;
  final RxInt _orderCount = 0.obs;
  final RxInt _wishlistCount = 0.obs;
  final RxInt _qty = 1.obs;
  RxString shareLink = ''.obs;
  RxBool isVariantPick = false.obs;
  final List _variantIndex = [].obs;
  final List<int> _variantName = [0].obs;
  final RxInt _colorVariantIndex = 0.obs;
  RxString selectedVariant = ''.obs;
  RxDouble variantPrice = 0.0.obs;

  List<Products> get getProductList => _productList;

  int get getColorVariantIndex => _colorVariantIndex.value;

  int get getQty => _qty.value;

  int get getOrderCount => _orderCount.value;

  int get getWishlistCount => _wishlistCount.value;

  List get getChoiceOption => _variantIndex;

  double get getVariantPrice => variantPrice.value;

  Future clearControllerData() async {
    shareLink.value = '';
  }

  void setCartVariationIndex(int variantIndex, int productIndex) {
    _variantIndex[productIndex] = variantIndex;

    isVariantPick.value = true;
  }

  void clearProductData() async {
    _productList.clear();
  }

  void clearVariant() {
    _variantIndex.clear();
    _variantName.clear();
    _colorVariantIndex.value = 0;
    variantPrice.value = 0;
  }

  void initChoiceOption(Products products) {
    int index = 0;
    products.choiceOptions?.forEach((element) {
      _variantIndex.add(element);
      setCartVariationIndex(0, index);
      index++;
    });
  }

  Future getSelectVariant(Products products) async {
    await getVariant(products);
    products.variation?.forEach((element) async {
      if (selectedVariant.value.contains(element.type.toString())) {
        variantPrice.value = element.price!;
      }
    });
  }

  Future getVariant(Products products) async {
    selectedVariant.value = '';
    if (products.colors!.isNotEmpty) {
      selectedVariant.value = mergeString(products.colors![getColorVariantIndex].name.toString());
    }

    for (int i = 0; i < products.choiceOptions!.length; i++) {
      if (i + 1 == products.choiceOptions!.length) {
        selectedVariant.value += products.choiceOptions![i].options![_variantIndex[i]].toString().trim();
      } else {
        selectedVariant.value += mergeString(products.choiceOptions![i].options![_variantIndex[i]].toString().trim());
      }
    }
  }

  String mergeString(var s1) {
    return "$s1-";
  }

  void initFirstLoad(int index) {
    setCartVariationIndex(0, index);
  }

  void setColorVariantIndex(int index) {
    _colorVariantIndex.value = index;
  }

  void updateQty(bool isPlus) {
    if (isPlus) {
      _qty.value++;
    } else {
      if (_qty.value > 1) {
        _qty.value--;
      }
    }
  }

  Future getRelatedProduct(int productID) async {
    // change(true, status: RxStatus.loading());
    await baseProvider.getRelatedProductApiProvider(productID.toString()).then((value) => {
          if (value.statusCode == 200)
            {
              _productList.obs.value.addAll(ProductModel.fromJsonList(value.body).products!.toList()),
              notifySuccessResponse(_productList.obs.value.length)
            }
          else
            {
              change(false, status: RxStatus.error()),
            }
        });
  }

  Future getCounterProduct(int productID) async {
    //  change(true, status: RxStatus.loading());
    await baseProvider.getProductCountApiProvider(productID.toString()).then((value) => {
          if (value.statusCode == 200)
            {_orderCount.value = value.body['order_count'], _wishlistCount.value = value.body['wishlist_count']}
        });
  }

  Future getGenerateShareProductLink(int productID) async {
    //  change(true, status: RxStatus.loading());
    await baseProvider.getShareProductLinkApiProvider(productID.toString()).then((value) => {
          if (value.statusCode == 200) {shareLink.value = value.body}
        });
  }

  void clearQuantity() {
    _qty.value = 1;
  }
}
