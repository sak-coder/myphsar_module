import 'dart:async';

import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';
import 'package:myphsar/category/category_model.dart';

class CategoryController extends BaseController {
  final BaseProvider categoryProvider;
  StreamController listener = StreamController<bool>.broadcast();
  CategoryController(this.categoryProvider);

  final categoryModel = <CategoryModel>[].obs;

  List<CategoryModel> get getAllCategoryModel => categoryModel;

  Future getAllCategoryProduct() async {
    // _categoryModel.clear();
    if (categoryModel.isNotEmpty) {
      return;
    }
    change(true, status: RxStatus.loading());
    await categoryProvider.getAllCategoryApiProvider().then((value) => {
          if (value.statusCode == 200)
            {
              value.body.forEach(
                (value) => {categoryModel.add(CategoryModel.fromJson(value))},
              ),
              notifySuccessResponse(categoryModel.length)
            }
          else
            {notifyErrorResponse("Error Code: ${value.statusCode}\n${value.statusText}")}
        });
  }
}
