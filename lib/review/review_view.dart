import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';

import '../base_colors.dart';
import '../base_widget/myphsar_text_view.dart';
import '../product/product_model.dart';

class ReviewView extends StatefulWidget {
  final Rating _rating;

  const ReviewView(this._rating, {super.key});

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          Wrap(
            children: [
              textView20(context: context, text: 'all_rate'.tr),
              Wrap(
                children: [
                  RatingBarIndicator(
                    rating: widget._rating.average != 0 ? widget._rating.average! : 0.0,
                    itemPadding: EdgeInsets.all(1),
                    itemBuilder: (context, index) => Image.asset(
                      "assets/images/star_on_ic.png",
                    ),
                    itemCount: 5,
                    itemSize: 13.0,
                    direction: Axis.horizontal,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: textView15(
                        context: context,
                        text: widget._rating.average != 0 ? "(" + widget._rating.average!.toStringAsFixed(1) + ")" : "(0)",
                        color: ColorResource.secondaryColor,
                        fontWeight: FontWeight.w700,
                        maxLine: 1),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
