import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';
import 'package:myphsar/order/order_detail/order_detail_model.dart';

import '../base_widget/custom_decoration.dart';
import '../order/order_history_view_controller.dart';
import 'submit_reviews_item_view.dart';

class ReviewView extends StatefulWidget {
  const ReviewView({super.key});

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: customAppBarView(context: context, titleText: 'review'.tr, elevation: 0),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              color: ColorResource.lightHintTextColor,
            child: Center(child: textView15(context: context,fontWeight: FontWeight.w700, text: Get.find<OrderHistoryViewController>().getOrderHistoryDetail.length.toString() + "items".tr),),
            ),
            Obx(() => Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      shrinkWrap: true,
                      itemCount: Get.find<OrderHistoryViewController>().getOrderHistoryDetail.length,
                      itemBuilder: (BuildContext context, int index) {
                        OrderDetailModel orderDetail = Get.find<OrderHistoryViewController>().getOrderHistoryDetail[index];

                        return Container(
                            margin: const EdgeInsets.only(top: 0, bottom: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: customDecoration(radius: 10, shadowBlur: 3),
                            child: SubmitReviewsItemView(orderDetail));
                      }),
                )),
          ],
        ) );
  }
}
