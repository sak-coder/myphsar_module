import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_icon_button.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';
import 'package:myphsar/cart/cart_controller.dart';
import 'package:myphsar/product/product_model.dart';
import 'package:myphsar/product_detail/product_detail_controller.dart';

import '../base_colors.dart';
import '../base_widget/custom_decoration.dart';
import '../configure/config_controller.dart';
import '../home/home_controller.dart';
import '../utils/price_converter.dart';

class AddToCartView extends StatefulWidget {
  final Products products;
  final Function(String) function;

  const AddToCartView({super.key, required this.products, required this.function});

  @override
  State<AddToCartView> createState() => _AddToCartViewState();
}

class _AddToCartViewState extends State<AddToCartView> {
  double variantPrice = 0;

  @override
  void initState() {
    Get.find<ProductDetailController>().clearVariant();
    Get.find<ProductDetailController>().clearQuantity();
    Get.find<ProductDetailController>().initChoiceOption(widget.products);
    Get.find<ProductDetailController>().getSelectVariant(widget.products);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/placeholder_img.png",
                    placeholderFit: BoxFit.contain,
                    width: 90,
                    height: 90,
                    fadeInDuration: const Duration(seconds: 1),
                    fit: BoxFit.contain,
                    image:
                        '${Get.find<ConfigController>().configModel.baseUrls?.baseProductThumbnailUrl}/${widget.products.thumbnail!}',
                    imageErrorBuilder: (c, o, s) => Image.asset(
                      "assets/images/placeholder_img.png",
                      width: 90,
                      height: 90,
                      fit: BoxFit.contain,
                    ),
                  )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textView16(
                        context: context, text: widget.products.name!, maxLine: 2, color: ColorResource.darkTextColor),
                    textView16(
                      fontWeight: FontWeight.w700,
                        context: context,
                        text: PriceConverter.currencySignAlignment(widget.products.unitPrice!),
                        color: ColorResource.primaryColor)
                  ],
                ),
              )
            ],
          ),
          // // Variant color
          widget.products.colors!.isNotEmpty
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    textView15(
                        context: context,
                        text: "color".tr,
                        maxLine: 1,
                        color: ColorResource.lightShadowColor,
                        fontWeight: FontWeight.w700),
                    Container(
                      height: 40,
                      margin: const EdgeInsets.only(top: 5),
                      child: ListView.builder(
                        itemCount: widget.products.colors!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          String colorString = '0xff${widget.products.colors![index].code.toString().substring(1, 7)}';
                          return Padding(
                            padding: const EdgeInsets.only(top: 0, right: 10),
                            child: customImageButton(
                                onTap: () {
                                  Get.find<ProductDetailController>().setColorVariantIndex(index);
                                },
                                blur: 0.5,
                                margin: 2,
                                width: 40,
                                radius: 5,
                                height: 50,
                                color: Color(int.parse(colorString)),
                                padding: 0,
                                icon: Obx(() => Get.find<ProductDetailController>().getColorVariantIndex == index
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    : Container())),
                          );
                        },
                      ),
                    ),
                  ]),
                )
              : const SizedBox.shrink(),
          widget.products.choiceOptions != null
              ? ListView.builder(
                shrinkWrap: true,
                itemCount: widget.products.choiceOptions!.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      textView13(
                          context: context,
                          text: widget.products.choiceOptions![index].title!,
                          maxLine: 1,
                          color: ColorResource.lightShadowColor,
                          fontWeight: FontWeight.w700),
                      const SizedBox(height: 10),
                      MasonryGridView.count(
                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //   crossAxisCount: 4,
                        //   crossAxisSpacing: 3,
                        //   mainAxisSpacing: 10,
                        //   childAspectRatio: (1 / 0.40),
                        // ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.products.choiceOptions![index].options?.length,
                        itemBuilder: (context, i) {
                          return Obx(() => InkWell(
                                onTap: () {
                                  Get.find<ProductDetailController>().setCartVariationIndex(i, index);
                                  Get.find<ProductDetailController>().getSelectVariant(widget.products);
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(2),
                                  padding: const EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  decoration: customDecoration(
                                      borderColor: Get.find<ProductDetailController>().getChoiceOption[index] == i
                                          ? ColorResource.primaryColor
                                          : ColorResource.lightHintTextColor,
                                      color: ColorResource.lightHintTextColor,
                                      radius: 5,
                                      shadowBlur: 0,
                                      shadowColor: ColorResource.hintTextColor),
                                  child: textView12(
                                    text: widget.products.choiceOptions![index].options![i].trim(),
                                    fontWeight: FontWeight.w500,
                                    color: Get.find<ProductDetailController>().getChoiceOption[index] == i
                                        ? ColorResource.primaryColor
                                        : ColorResource.darkTextColor,
                                    context: context,
                                  ),
                                ),
                              ));
                        }, crossAxisCount: 3,
                      ),
                    ]),
                  );
                },
              )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: textView20(context: context, text: "qty".tr, fontWeight: FontWeight.w700),
                ),
                InkWell(
                  onTap: () {
                    Get.find<ProductDetailController>().updateQty(false);
                  },
                  child: Obx(()=>Icon(
                    Icons.remove_circle_outlined,
                    color: Get.find<ProductDetailController>().getQty >1? ColorResource.primaryColor: ColorResource.primaryColor05,
                    size: 30,
                  ),)
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: textView20(
                        context: context,
                        text: Get.find<ProductDetailController>().getQty.toString(),
                        color: ColorResource.darkTextColor),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.find<ProductDetailController>().updateQty(true);
                  },
                  child: const Icon(
                    Icons.add_circle_rounded,
                    color: ColorResource.primaryColor,
                    size: 30,
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 35, bottom: 15),
            child: Divider(
              height: 0.1,
              color: ColorResource.lightShadowColor20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                direction: Axis.vertical,
                children: [
                  textView15(context: context, text: "price_".tr, maxLine: 1, fontWeight: FontWeight.w700),
                  Obx(() => textView25(
                      context: context,
                      text: PriceConverter.convertPrice(
                          context,
                          //  double.parse((widget.products.unitPrice! * Get.find<ProductDetailController>().getQty).toString()),
                          double.parse((Get.find<ProductDetailController>().variantPrice.value > 0
                                  ? Get.find<ProductDetailController>().variantPrice.value*  Get.find<ProductDetailController>().getQty
                                  : widget.products.unitPrice! * Get.find<ProductDetailController>().getQty)
                              .toString()),
                          discount: widget.products.discount!,
                          discountType: widget.products.discountType!),
                      color: ColorResource.primaryColor))
                ],
              ),
              customTextButton(
                  onTap: () async {
                    Get.find<CartController>().addToCart(context, widget.products, callback: (val) async {
                      if (val.isNotEmpty) {
                        widget.function(val);
                      } else {
                        Get.find<HomeController>().cartCount.value++;
                      }
                    });
                    Navigator.pop(context);
                  },
                  text: Center(
                    child: textView16(
                      context: context,
                      text: 'add_to_cart'.tr,
                      fontWeight: FontWeight.w600,
                      color: ColorResource.whiteColor,
                    ),
                  ),
                  color: ColorResource.primaryColor,
                  radius: 10,
                  height: 50),
            ],
          )])
    );
  }
}
