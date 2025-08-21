import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/app_constants.dart';
import 'package:myphsar/base_widget/custom_decoration.dart';
import 'package:myphsar/utils/date_format.dart';
import 'package:myphsar/utils/price_converter.dart';

import '../base_colors.dart';
import '../base_widget/custom_icon_button.dart';
import '../base_widget/myphsar_text_view.dart';
import 'order_detail/order_detail_view.dart';
import 'order_history_model.dart';

class OrderHistoryItemView extends StatefulWidget {
  final OrderHistoryModel _orderHistoryModel;

  final Color statusColor;

  const OrderHistoryItemView(this._orderHistoryModel, this.statusColor, {super.key});

  @override
  State<OrderHistoryItemView> createState() => _OrderHistoryItemViewState();
}

class _OrderHistoryItemViewState extends State<OrderHistoryItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 90,
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
          height: 90,
          width: 10,
          decoration: customDecorationOnly(
              bottomLeft: 10,
              topLeft: 10,
              shadowBlur: 1.5,
              shadowColor: ColorResource.lightGrayColor50,
              color: widget.statusColor),
        ),
        InkWell(
          onTap: () {
            Get.to(OrderDetailView(widget._orderHistoryModel, widget._orderHistoryModel.id.toString()));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 25, right: 20, top: 10),
            padding: const EdgeInsets.all(10),
            height: 90,
            decoration: customDecorationOnly(
                bottomLeft: 7,
                bottomRight: 10,
                topRight: 10,
                topLeft: 7,
                shadowBlur: 1,
                shadowColor: ColorResource.lightShadowColor50,
                offset: const Offset(
                  1,
                  0,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textView15(
                    context: context,
                    text: '${'receipt'.tr}: ${widget._orderHistoryModel.id}',
                    maxLine: 1,
                    color: ColorResource.lightTextColor,
                    fontWeight: FontWeight.w700),
                textView14(
                    context: context,
                    text: PriceConverter.currencySignAlignment(widget._orderHistoryModel.orderAmount!),
                    maxLine: 1,
                    color: ColorResource.lightTextColor,
                    fontWeight: FontWeight.w700),
                textView12(
                    context: context,
                    text: DateFormate.isoStringToLocalDay(widget._orderHistoryModel.createdAt!),
                    maxLine: 1,
                    fontWeight: FontWeight.w500,
                    color: ColorResource.lightTextColor),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, right: 30),
          child: Align(
              alignment: Alignment.topRight,
              child: customTextButton(
                  height: 25,
                  blur: 0,
                  padding: 5,
                  color: ColorResource.lightHintTextColor,
                  radius: 5,
                  onTap: () {},
                  text: textView12(
                      context: context,
                      text: widget._orderHistoryModel.orderStatus.toString().toUpperCase(),
                      color: ColorResource.secondaryColor))),
        ),
        Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.only(bottom: 10, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: textView12(
                      context: context,
                      text: widget._orderHistoryModel.paymentStatus!.toUpperCase(),
                      maxLine: 1,
                      color: ColorResource.secondaryColor,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  widget._orderHistoryModel.paymentMethod == AppConstants.VTC_BANK
                      ? "assets/images/vtn_bank.png"
                      : widget._orderHistoryModel.paymentMethod == AppConstants.ABA_PAY
                          ? "assets/images/aba_pay.png"
                          : widget._orderHistoryModel.paymentMethod == AppConstants.CCU_BANK
                              ? "assets/images/ccu.png"
                              : "assets/images/wallet_ic.png",
                  width: widget._orderHistoryModel.paymentMethod == AppConstants.CCU_BANK ? 50 : 20,
                ),
              ],
            ))
      ]),
    );
  }
}
