import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_decoration.dart';
import 'package:myphsar/installment/installment_view_controller.dart';

import '../../auth/AuthController.dart';
import '../../base_colors.dart';
import '../../base_widget/custom_icon_button.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../../base_widget/sing_in_dialog_view.dart';
import '../../configure/config_controller.dart';
import '../../installment/user_info/installment_info_view.dart';
import '../../product/product_model.dart';
import '../../product_detail/product_detail_view.dart';
import '../../utils/price_controller_display.dart';
import '../../utils/price_converter.dart';

class ProductItemWidget extends StatefulWidget {
  final double? width;
  final Products product;
  final bool isCategory;
  final double elevation;

  const ProductItemWidget(
      {super.key, this.width, required this.product, this.isCategory = false, this.elevation = 1.5});

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Get.to(() => ProductDetailView(widget.product), opaque: true, popGesture: true,preventDuplicates: false);
      },
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: widget.elevation),
          ],
        ),
        child: Column(
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                // child: ConstrainedBox(
                //   constraints: new BoxConstraints(
                //     minHeight: 150.0,
                //     maxHeight: 179,
                //     maxWidth: MediaQuery.of(context).size.width,
                //   ),

                child: Image.network(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  fit: BoxFit.contain,
                  cacheHeight: 350,
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
              Align(
                alignment: Alignment.topRight,
                child: Column(children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(5),
                  //   child: CustomIconButtonBlurBg(
                  //       padding: 5,
                  //       width: 36,
                  //       height: 36,
                  //       onTap: () => {
                  //             if (Get.find<AuthController>().isSignIn())
                  //               {Get.find<WishlistController>().addWishlist(context, widget.product.id.toString())}
                  //             else
                  //               {SignInDialogView(context)}
                  //           },
                  //       icon: Image.asset(
                  //         "assets/images/love_ic.png",
                  //         width: 24,
                  //         height: 24,
                  //       ),
                  //       blur: 1),
                  // ),
                  /*  Installment status */
                  widget.product.interestRateStatus != 0
                      ? Padding(
                          padding: const EdgeInsets.all(5),
                          child: customImageButton(
                              padding: 6,
                              width: 36,
                              height: 36,
                              onTap: () => {
                                    if (Get.find<AuthController>().isSignIn())
                                      {
                                        Get.to(InstallmentInfoView(widget.product.id.toString())),
                                        Get.find<InstallmentViewController>()
                                            .addProductImg(widget.product.thumbnail.toString(), reset: true)
                                      }
                                    else
                                      {signInDialogView(context)}
                                  },
                              icon: Image.asset(
                                "assets/images/installments_ic.png",
                                width: 24,
                                height: 24,
                              ),
                              blur: 3,
                              color: ColorResource.primaryColor),
                        )
                      : const SizedBox(),
                  widget.product.interestRateStatus != 0
                      ? customTextButton(
                          blur: 0,
                          color: ColorResource.lightWhiteShadowColor20,
                          radius: 100,
                          padding: 4,
                          height: 22,
                          text: textView12(
                              context: context,
                              text: "installment_tag".tr,
                              color: ColorResource.darkTextColor,
                              fontFamily: 'KantumruyPro'),
                        )
                      : const SizedBox(),
                ]),
              ),
            ]),
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
                  widget.product.seller?.verified == 1
                      ? Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5, bottom: 3),
                              child: textView12(
                                  context: context,
                                  fontWeight: FontWeight.w500,
                                  text: "Verified",
                                  maxLine: 1,
                                  color: ColorResource.lightTextColor),
                            ),
                            const Icon(
                              Icons.verified,
                              size: 15,
                              color: Colors.lightBlueAccent,
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                  textView14(
                    context: context,
                    text: widget.product.name.toString(),
                    maxLine: 4,
                    height: 1.2,
                  ),
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
                            maxLine: 4,
                            context: context,
                            text: widget.product.metaTitle.toString(),
                            color: Colors.green,
                          ))
                      : const SizedBox.shrink(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PriceConverterDisplay.dynamicItemPrice(context, widget.product, isCategory: widget.isCategory),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(
                            Icons.remove_red_eye_outlined,
                            size: 11,
                            color: ColorResource.primaryColor,
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          textView10(
                              fontWeight: FontWeight.normal,
                              context: context,
                              text: widget.product.viewer.toString(),
                              color: ColorResource.secondaryColor),
                        ],
                      )
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         RatingBarIndicator(
                  //           rating: widget.product.rating?.length != 0 && widget.product.rating != null
                  //               ? widget.product.rating![0].average!
                  //               : 0.0,
                  //           itemPadding: EdgeInsets.all(1),
                  //           itemBuilder: (context, index) => Image.asset(
                  //             "assets/images/star_on_ic.png",
                  //           ),
                  //           itemCount: 5,
                  //           itemSize: 9.0,
                  //           direction: Axis.horizontal,
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.all(2),
                  //           child: TextViewSize_13(
                  //               context: context,
                  //               text: widget.product.rating?.length != 0 && widget.product.rating != null
                  //                   ? "(" + widget.product.rating![0].average!.toStringAsFixed(1) + ")"
                  //                   : "(0)",
                  //               color: ColorResource.lightTextColor,
                  //               fontWeight: FontWeight.w500),
                  //         ),
                  //       ],
                  //     ),
                  //     Wrap(
                  //       crossAxisAlignment: WrapCrossAlignment.center,
                  //       children: [
                  //         Icon(
                  //           Icons.remove_red_eye_outlined,
                  //           size: 13,
                  //           color: ColorResource.primaryColor,
                  //         ),
                  //         SizedBox(
                  //           width: 1,
                  //         ),
                  //         TextViewSize_12(
                  //             fontWeight: FontWeight.normal,
                  //             context: context,
                  //             text: widget.product.viewer.toString(),
                  //             color: ColorResource.secondaryColor),
                  //       ],
                  //     )
                  //   ],
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
