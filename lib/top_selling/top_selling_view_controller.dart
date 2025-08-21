import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';
import 'package:myphsar/product/product_model.dart';

class TopSellingViewController extends BaseController {
  final BaseProvider _baseProvider;

  TopSellingViewController(this._baseProvider);

  final _topSellingProduct = <Products>[].obs;

  List<Products> get getTopSellingProductList => _topSellingProduct;

  Future getTopSellingProduct(int offset) async {
    if (offset > 1) {
      infiniteLoading.value = true;
    } else {
      change(true, status: RxStatus.loading());
    }

    await _baseProvider.getBestSellingApiProvider(offset.toString()).then((value) => {
          if (value.statusCode == 200)
            {
              _topSellingProduct.obs.value.addAll(ProductModel.fromJson(value.body).products!.toList()),
              notifySuccessResponse(_topSellingProduct.length)
            }
          else
            {
              if(offset==1){
                change(false, status: RxStatus.error(value.statusCode.toString()))
              }
              //  notifyErrorResponse("Error Code=" + value.statusCode.toString() + " \n" + value.statusText.toString())
            }
        });
  }
}
