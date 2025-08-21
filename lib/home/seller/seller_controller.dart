import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';

import 'seller_model.dart';

class SellerController extends BaseController {
  final BaseProvider _baseProvider;

  SellerController(this._baseProvider);

  final _allSellerModel = <SellerModel>[].obs;
  final _searchAllSellerModel = <SellerModel>[].obs;

  List<SellerModel> get getAllSellerModel => _allSellerModel;

  List<SellerModel> get getAllSearchSellerModel => _searchAllSellerModel;

  bool willPopStatus(Function callback) {
    if (_allSellerModel.length == _searchAllSellerModel.length) {
      return true;
    } else {
      resetSearch();
      callback();
      return false;
    }
  }

  void resetSearch() {
    _searchAllSellerModel.clear();
    _searchAllSellerModel.addAll(_allSellerModel);
    notifySuccessResponse(_searchAllSellerModel.length);
  }

  void searchShop(String keySearch) {
    var search = keySearch.toLowerCase();
    _searchAllSellerModel.clear();
    if (keySearch.isEmpty) {
      _searchAllSellerModel.addAll(_allSellerModel);
      return;
    }

    for (var product in _allSellerModel) {
      if (product.name!.toLowerCase().contains(search)) {
        _searchAllSellerModel.add(product);
        notifySuccessResponse(_searchAllSellerModel.length);
      } else {
        notifySuccessResponse(_searchAllSellerModel.length);
      }
    }
  }

  Future getAllSeller() async {
    change(true, status: RxStatus.loading());
    await _baseProvider.getAllSellerApiProvider().then((value) => {
          if (value.statusCode == 200)
            {
              value.body.forEach((value) => {
                    _allSellerModel.add(SellerModel.fromJson(value)),
                    _searchAllSellerModel.add(SellerModel.fromJson(value))
                  }),
              notifySuccessResponse(_allSellerModel.length)
            }
          else
            {notifyErrorResponse("Error Code: ${value.statusCode}\n${value.statusText}")}
        });
  }
}
