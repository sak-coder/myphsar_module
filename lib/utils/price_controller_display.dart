import 'package:flutter/cupertino.dart';

import '../base_colors.dart';
import '../base_widget/myphsar_text_view.dart';
import '../product/product_model.dart';
import 'price_converter.dart';

class PriceConverterDisplay {
  static Widget dynamicPrice(BuildContext context,
      {required double unitPrice, required double discount, required String discountType, bool isCategory = false}) {
    return Row(
      children: [
        discount == 0
            ? normalPrice(context, PriceConverter.currencySignAlignment(unitPrice), discount)
            : discountPrice(
                context,
                PriceConverter.currencySignAlignment(unitPrice),
                PriceConverter.convertPrice(context, double.parse(unitPrice.toString()),
                    discount: discount, discountType: discountType),
                discount,
                isCategory)
      ],
    );
  }

  static Widget dynamicItemPrice(BuildContext context, Products productModel, {bool isCategory = false}) {
    return Row(
      children: [
        productModel.discount == 0
            ? normalPrice(
                context, PriceConverter.currencySignAlignment(productModel.unitPrice!), productModel.discount!)
            : discountPrice(
                context,
                PriceConverter.currencySignAlignment(productModel.unitPrice!),
                PriceConverter.convertPrice(context, double.parse(productModel.unitPrice.toString()),
                    discount: productModel.discount!, discountType: productModel.discountType!),
                productModel.discount!,
                isCategory)
      ],
    );
  }

  static Widget itemPrice(BuildContext context, Products productModel) {
    return Row(
      children: [
        textView23(
            context: context,
            text: PriceConverter.convertPrice(context, double.parse(productModel.unitPrice.toString()),
                discount: productModel.discount!, discountType: productModel.discountType!)),
        productModel.discount != 0
            ? textViewCrossPrice16(
                context: context,
                text: PriceConverter.currencySignAlignment(productModel.unitPrice!),
                color: ColorResource.lightTextColor,
                textDecoration: TextDecoration.lineThrough)
            : const SizedBox.shrink()
      ],
    );
  }

  static Widget discountPrice(
      BuildContext context, String textSize, String discountPrice, double isDiscount, bool isCate) {
    return isCate
        ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            normalPrice(context, discountPrice, isDiscount),
            const SizedBox(
              width: 2,
            ),
            textSize.length <= 7
                ? textViewCrossPrice16(
                    context: context,
                    text: textSize,
                    color: ColorResource.lightTextColor,
                    textDecoration: TextDecoration.lineThrough)
                : textViewCrossPrice12(
                    context: context,
                    text: textSize,
                    color: ColorResource.lightTextColor,
                    textDecoration: TextDecoration.lineThrough),
          ])
        : Row(children: [
            normalPrice(context, discountPrice, isDiscount),
            const SizedBox(
              width: 2,
            ),
            textSize.length <= 7
                ? textViewCrossPrice16(
                    context: context,
                    text: textSize,
                    color: ColorResource.lightTextColor,
                    textDecoration: TextDecoration.lineThrough)
                : textViewCrossPrice12(
                    context: context,
                    text: textSize,
                    color: ColorResource.lightTextColor,
                    textDecoration: TextDecoration.lineThrough),
          ]);
  }

  static Widget normalPrice(BuildContext context, String textSize, double discount) {
    return discount > 0
        ? textSize.length <= 6
            ? textView20(context: context, text: textSize, color: ColorResource.primaryColor)
            : textView15(context: context, text: textSize, color: ColorResource.primaryColor)
        : textView20(context: context, text: textSize, color: ColorResource.primaryColor);
  }
}
