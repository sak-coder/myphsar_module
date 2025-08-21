import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';
import 'package:myphsar/new_arrival/new_arrival_cat_model.dart';

import '../product/product_model.dart';

class NewArrivalViewController extends BaseController {
  BaseProvider _baseProvider;

  NewArrivalViewController(this._baseProvider);

  var _newArrivalProductList = <Products>[].obs;
  var _newArrivalCatList = <NewArrivalCatModel>[].obs;

  List<Products> get getNewArrivalProductList => _newArrivalProductList;

  List<NewArrivalCatModel> get getNewArrivalCatProductList => _newArrivalCatList;

  Future getNewArrivalProduct(int offset) async {
    if (offset > 1) {
      infiniteLoading.value = true;
    } else {
      change(true, status: RxStatus.loading());
    }
    await _baseProvider.getNewArrivalProductApiProvider(offset.toString()).then((value) => {
          if (value.statusCode == 200)
            {
              _newArrivalProductList.obs.value.addAll(ProductModel.fromJson(value.body).products!.toList()),
              notifySuccessResponse(_newArrivalProductList.length)
            }
          else
            {notifyErrorResponse("Error Code=" + value.statusCode.toString() + " \n" + value.statusText.toString())}
        });
  }

  Future getNewArrivalCategoryList(int offset) async {
    change(true, status: RxStatus.loading());
    _newArrivalCatList.obs.value.clear();
    await _baseProvider.getNewArrivalCategoryApiProvider(offset.toString()).then((value) => {
          if (value.statusCode == 200)
            {
              value.body.forEach((val) => {
                    _newArrivalCatList.obs.value.add(NewArrivalCatModel.fromJson(val)),
                  }),
              notifySuccessResponse(_newArrivalCatList.length)
            }
          else
            {
              notifyErrorResponse("Error Code=" + value.statusCode.toString() + " \n" + value.statusText.toString())}
        });
  }
}
