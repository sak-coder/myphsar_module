
import 'package:get/get.dart';

import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';
import 'package:myphsar/product/product_model.dart';

import '../new_arrival/new_arrival_cat_model.dart';

class InstallmentProductViewController extends BaseController{
	BaseProvider _baseProvider;
	InstallmentProductViewController(this._baseProvider);
	var _installmentProduct = <Products>[].obs;

	List<Products> get getInstallmentList => _installmentProduct;

	void clearData(){
		_installmentProduct.clear();
	}

	Future getInstallmentProductList(int offset) async {
		if (offset > 1) {
			infiniteLoading.value = true;
		} else {
			change(true, status: RxStatus.loading());
		}

		await _baseProvider.getInstallmentProductApiProvider(offset.toString()).then((value) => {
			if (value.statusCode == 200)
				{
					_installmentProduct.obs.value.addAll(ProductModel.fromJson(value.body).products!.toList()),
					notifySuccessResponse(_installmentProduct.length)
				}
			else
				{
					notifyErrorResponse("Error Code=" + value.statusCode.toString() + " \n" + value.statusText.toString())
					//  notifyErrorResponse("Error Code=" + value.statusCode.toString() + " \n" + value.statusText.toString())
				}
		});
	}
}