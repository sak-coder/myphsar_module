import 'package:flutter/material.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';

import '../base_widget/snack_bar_message.dart';
import 'review_body_model.dart';

class ReviewViewController extends BaseController {
  final BaseProvider _baseProvider;

  ReviewViewController(this._baseProvider);

  Future submitReviewsProduct(BuildContext context, ReviewBodyModel reviewBodyModel, Function(bool) callback) async {
    await _baseProvider.reviewsProductApiProvider(reviewBodyModel).then((value) => {
          if (value.statusCode == 200)
            {callback(true)}
          else
            {
              callback(false),
              if (context.mounted) {snackBarMessage(context, "${value.statusCode}\n${value.statusText}")}
            }
        });
  }
}
