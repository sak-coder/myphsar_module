import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myphsar/review/review_model.dart';

import '../base_colors.dart';
import '../base_widget/custom_decoration.dart';
import '../base_widget/myphsar_text_view.dart';
import '../utils/date_format.dart';

class ReviewItemView extends StatefulWidget {
  final List<ReviewModel> _reviewModel;
  final ScrollController? scrollController;
  final Function function;
  final String? catId;
  final bool isShop;
  final bool isCategory;
  final double paddingButtom;

  ReviewItemView(this._reviewModel, this.scrollController, this.function,
      {this.catId, this.isShop = false, this.isCategory = false, this.paddingButtom = 60});

  @override
  State<ReviewItemView> createState() => _ProductItemGridViewState();
}

class _ProductItemGridViewState extends State<ReviewItemView> {
//TODO Delay render view loading
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget._reviewModel.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          var customer = widget._reviewModel[index].customer;
          return Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(left: 10, right: 0, top: 20, bottom: 2),
              decoration: customDecoration(radius: 10, color: ColorResource.whiteColor, shadowBlur: 2),
              width: widget._reviewModel.length == 1 ? MediaQuery.of(context).size.width - 40 : 320,
              height: 198,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textView20(
                      context: context,
                      text: "${customer!.fName} ${customer.lName}",
                      color: ColorResource.darkTextColor),
                  Expanded(
                      child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: textView15(
                        context: context,
                        text: widget._reviewModel[index].comment.toString(),
                        fontWeight: FontWeight.w400,
                        maxLine: 6,
                        color: ColorResource.lightTextColor),
                  )),
                  const Divider(
                    height: 20,
                    color: ColorResource.darkTextColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating:
                                widget._reviewModel.isNotEmpty ? widget._reviewModel[index].rating!.toDouble() : 0.0,
                            itemPadding: const EdgeInsets.all(1),
                            itemBuilder: (context, index) => Image.asset(
                              "assets/images/star_on_ic.png",
                            ),
                            itemCount: 5,
                            itemSize: 10.0,
                            direction: Axis.horizontal,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: textView13(
                                context: context,
                                text: widget._reviewModel.isNotEmpty ? "(${widget._reviewModel[index].rating})" : "(0)",
                                color: ColorResource.lightTextColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      textView13(
                          context: context,
                          text: DateFormate.isoStringToLocalDay(widget._reviewModel[index].createdAt!),
                          maxLine: 1,
                          fontWeight: FontWeight.w500,
                          color: ColorResource.hintTextColor)
                    ],
                  )
                ],
              ));
        },
      ),
    );
  }
}
