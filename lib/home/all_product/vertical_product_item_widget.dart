import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_decoration.dart';

import '../../base_colors.dart';
import '../../base_widget/custom_icon_button.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../../configure/config_controller.dart';
import '../../product/product_model.dart';
import '../../product_detail/product_detail_view.dart';
import '../../utils/price_controller_display.dart';
import '../../utils/price_converter.dart';

class VerticalProductItemWidget extends StatefulWidget {
  final double? width;
  final Products product;
  final bool isCategory;
  final int maxLine;

  const VerticalProductItemWidget(
      {super.key, this.width, required this.product, this.isCategory = false, this.maxLine = 2});

  @override
  State<VerticalProductItemWidget> createState() => _VerticalProductItemWidgetState();
}

class _VerticalProductItemWidgetState extends State<VerticalProductItemWidget> {
  bool wishlistStatus = false;

  void toggleWishlist(bool status) {
    wishlistStatus = wishlistStatus != status;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Get.to(() => ProductDetailView(widget.product), opaque: false, popGesture: true, preventDuplicates: false);
      },
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 0),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //   Product image
            SizedBox(
              height: 165,
              child: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    fit: BoxFit.contain,
                    cacheHeight: 300,
                    '${Get.find<ConfigController>().configModel.baseUrls?.baseProductThumbnailUrl}/${widget.product.thumbnail!}',
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Image.asset(
                        "assets/images/placeholder_img.png",
                        fit: BoxFit.contain,
                      );
                    },
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {

                      if (loadingProgress == null) return child;
                      return Container(
                        alignment: Alignment.center,
                        height: 180,
                        child: const CupertinoActivityIndicator(color: ColorResource.lightShadowColor50),
                      );
                    },
                  ),
                  // child: FadeInImage.assetNetwork(
                  // 	placeholder: "assets/images/placeholder_img.png",
                  // 	placeholderCacheHeight: 179,
                  // 	placeholderFit: BoxFit.fitHeight,
                  // 	placeholderScale: 50,
                  // 	fadeInDuration: Duration(seconds: 2),
                  // 	fit: BoxFit.fitHeight,s
                  // 	imageCacheHeight: 250,
                  // 	imageScale: 50,
                  // 	image:
                  // 	'${'${Get.find<ConfigController>().configModel.baseUrls?.baseProductThumbnailUrl}/' + widget.product.thumbnail!}',
                  // 	width: MediaQuery.of(context).size.width,
                  // 	height: 179,
                  // 	imageErrorBuilder: (c, o, s) => Image.asset(
                  // 		"assets/images/placeholder_img.png",
                  // 		height: 179,
                  // 		scale: 50,
                  // 		fit: BoxFit.fitHeight,
                  // 	),
                  // )
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: widget.product.discount! > 0
                        ? Container(
                            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 3, top: 3),
                            decoration: BoxDecoration(
                                color: ColorResource.primaryColor, borderRadius: BorderRadius.circular(100)),
                            child: textView12(
                                color: ColorResource.whiteColor,
                                context: context,
                                fontWeight: FontWeight.bold,
                                text: PriceConverter.percentageCalculation(context, widget.product.unitPrice!,
                                    widget.product.discount!, widget.product.discountType!)))
                        : const SizedBox(),
                  ),
                ),
              ]),
            ),
            widget.product.videoUrl != null
                ? Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(2),
                    decoration: customDecoration(
                      radius: 4,
                      color: ColorResource.primaryColor,
                    ),
                    child: Text(
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      widget.product.videoUrl.toString(),
                      style: const TextStyle(
                          letterSpacing: 0.1,
                          fontSize: 13,
                          color: ColorResource.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ))
                : const SizedBox.shrink(),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textView15(context: context, text: widget.product.name.toString(), maxLine: widget.maxLine),
                  widget.product.metaTitle != null
                      ? customTextButton(
                          // onTap: () {
                          //   Get.to(HashTagView(
                          //     hashTag: widget.product.metaTitle.toString().substring(1),
                          //   ));
                          // },
                          blur: 0,
                          radius: 0,
                          padding: 0,
                          text: textView12(
                            maxLine: widget.maxLine,
                            context: context,
                            height: 1,
                            text: widget.product.metaTitle.toString(),
                            color: Colors.green,
                          ))
                      : const SizedBox.shrink(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PriceConverterDisplay.dynamicItemPrice(context, widget.product, isCategory: widget.isCategory),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: widget.product.rating?.length != 0 && widget.product.rating != null
                                ? widget.product.rating![0].average!
                                : 0.0,
                            itemPadding: const EdgeInsets.all(1),
                            itemBuilder: (context, index) => Image.asset(
                              "assets/images/star_on_ic.png",
                            ),
                            itemCount: 5,
                            itemSize: 9.0,
                            direction: Axis.horizontal,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: textView13(
                                context: context,
                                text: widget.product.rating?.length != 0 && widget.product.rating != null
                                    ? "(${widget.product.rating![0].average!.toStringAsFixed(1)})"
                                    : "(0)",
                                color: ColorResource.lightTextColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(
                            Icons.remove_red_eye_outlined,
                            size: 13,
                            color: ColorResource.primaryColor,
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          textView12(
                              fontWeight: FontWeight.normal,
                              context: context,
                              text: widget.product.viewer.toString(),
                              color: ColorResource.secondaryColor),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
