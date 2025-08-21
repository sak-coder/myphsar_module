import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/review/review_model.dart';

import '../base_provider.dart';

class ReviewItemController extends BaseController {
  final BaseProvider _baseProvider;

  ReviewItemController(this._baseProvider);

  final _reviewModel = <ReviewModel>[].obs;

  List<ReviewModel> get getReviewModel => _reviewModel;

  Future getAllReviewProduct(int productID) async {
    _reviewModel.clear();
    change(false, status: RxStatus.loading());
    await _baseProvider.getReviewApiProvider(productID.toString()).then((value) => {
          if (value.statusCode == 200)
            {
              value.body.forEach((value) => {_reviewModel.add(ReviewModel.fromJson(value))}),
              notifySuccessResponse(_reviewModel.length)
            }
          else
            {
              {notifyErrorResponse("Error Code: ${value.statusCode}\n${value.statusText}")}
            }
        });
  }
}
