import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/base_widget/custom_icon_button.dart';
import 'package:myphsar/configure/config_controller.dart';
import 'package:myphsar/home/home_controller.dart';

import '../../auth/AuthController.dart';
import '../../base_widget/custom_bottom_sheet_dialog.dart';
import '../../base_widget/custom_decoration.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../../base_widget/sing_in_dialog_view.dart';
import '../../base_widget/snack_bar_message.dart';
import '../../cart/add_to_cart_view.dart';
import '../../product/product_model.dart';
import '../../utils/price_controller_display.dart';
import '../../utils/price_converter.dart';
import '../flash_deal/see_all_flash_deal_view.dart';

class FlashDealWidget extends StatelessWidget {
  final ScrollController scrollController;

  const FlashDealWidget(this.scrollController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 335,
      color: Colors.white,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              // padding: EdgeInsets.only(
              //   left: 10,
              //   right: 10,
              //   top: 10,
              // ),
              width: double.infinity,
              height: 175,
              // decoration: BoxDecoration(
              //   color: Color(0xFFF51313),
              // ),
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/flash_deal_bg_img.png",
                    height: 170,
                    fit: BoxFit.fitHeight,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 20),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          textView16(fontWeight:FontWeight.w600,context: context, text: 'flash_deal'.tr, color: Colors.white),
                          Expanded(
                            child: Container(
                              height: 38,
                              margin: const EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                              child: Row(
                                children: [
                                  Obx(
                                    () => customTextButton(
                                        blur: 0,
                                        height: 25,
                                        text: textView13(
                                            context: context,
                                            text: "${Get.find<HomeController>().day.value}d"),
                                        radius: 5,
                                        padding: 3),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2, right: 2),
                                    child: textView15(
                                        context: context, text: ":", color: Colors.white, fontWeight: FontWeight.w500),
                                  ),
                                  Obx(
                                    () => customTextButton(
                                        blur: 0,
                                        height: 25,
                                        text: textView13(
                                            context: context,
                                            text: "${Get.find<HomeController>().hours.value}h"),
                                        radius: 5,
                                        padding: 3),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2, right: 2),
                                    child: textView15(
                                        context: context, text: ":", color: Colors.white, fontWeight: FontWeight.w500),
                                  ),
                                  Obx(
                                    () => customTextButton(
                                        height: 25,
                                        blur: 0,
                                        text: textView13(
                                            context: context,
                                            text: "${Get.find<HomeController>().min.value}m"),
                                        radius: 5,
                                        padding: 3),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2, right: 2),
                                    child: textView15(
                                        context: context, text: ":", color: Colors.white, fontWeight: FontWeight.w500),
                                  ),
                                  Obx(
                                    () => textView13(
                                        color: Colors.white,
                                        context: context,
                                        text: Get.find<HomeController>().sec.toString()),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                Get.to(SeeAllFlashDealView(
                                    Get.find<HomeController>().getFlashDealListModel, scrollController));
                              },
                              child: textView13(context: context, text: "see_all".tr, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Align(
          //
          //     alignment: Alignment.topCenter,
          //     child:  Container(
          //         margin: EdgeInsets.only(top: 55),
          //           height:120,
          //           decoration: BoxDecoration(
          //               color: Colors.white,
          //               gradient: LinearGradient(begin: FractionalOffset.center, end: FractionalOffset.bottomCenter, colors: [
          //                 Color.fromRGBO(213, 212, 212, 0.1),
          //                 Colors.white,
          //               ], stops: [
          //                 0.3, 2,
          //               ])),
          //         ),
          //
          //
          //   ),

          GetBuilder<HomeController>(
            builder: (data) => Container(
              margin: const EdgeInsets.only(top: 55),
              child: Obx(
                () => Get.find<HomeController>().getFlashDealListModel.isNotEmpty
                    ? ListView.builder(
                        itemCount: data.getFlashDealListModel.length <= 20 ? data.getFlashDealListModel.length : 20,
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          Products flashDealModel = data.getFlashDealListModel[index];
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  if (!Get.find<AuthController>().isSignIn()) {
                                    signInDialogView(context);
                                  } else {
                                    customBottomSheetDialogWrap(
                                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30, top: 20),
                                      context: context,
                                      child: AddToCartView(
                                        products: Get.find<HomeController>().getFlashDealListModel[index],
                                        function: (val) {
                                          snackBarMessage(context, val);
                                        },
                                      ),
                                    );
                                  }
                                  // #ទិញ២ដប ថែម ទឹកអនាម័យស្ត្រី Sakura 150ml ១ដប #ក្រែមបន្ទន់សក់
                                },
                                child: Container(
                                    padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                                    width: 179,
                                    height: 276,
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Product image
                                        SizedBox(
                                          height: flashDealModel.metaTitle == null ? 170 : 160,
                                          child: Stack(children: [
                                            Container(
                                              decoration:
                                                  customDecoration(color: Colors.white, radius: 10, shadowBlur: 1),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: FadeInImage.assetNetwork(
                                                  placeholder: "assets/images/placeholder_img.png",
                                                  fit: BoxFit.fill,
                                                  image:
                                                      flashDealModel.images!.isNotEmpty ? '${Get.find<ConfigController>().configModel.baseUrls?.baseProductImageUrl}/${flashDealModel.images![0]}' : "",
                                                  width: 179,
                                                  height: flashDealModel.metaTitle == null ? 170 : 160,
                                                  imageErrorBuilder: (c, o, s) => Image.asset(
                                                    "assets/images/placeholder_img.png",
                                                    fit: BoxFit.fill,
                                                    width: 179,
                                                    height: flashDealModel.metaTitle == null ? 170 : 160,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            flashDealModel.videoUrl != null
                                                ? Align(
                                                    alignment: Alignment.bottomLeft,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        // Padding(
                                                        //   padding: const EdgeInsets.all(8.0),
                                                        //   child: Image.asset("assets/images/ann.png",width: 30,color: Colors.red,),
                                                        // ),
                                                        Expanded(
                                                          child: Container(
                                                              margin: const EdgeInsets.only(top: 10, left: 1, right: 1),
                                                              padding:
                                                                  const EdgeInsets.only(left: 5, right: 5, bottom: 3, top: 3),
                                                              decoration: customDecorationOnly(
                                                                bottomRight: 10,
                                                                bottomLeft: 10,
                                                                color: ColorResource.primaryColor.withOpacity(0.5),
                                                              ),
                                                              child: textView11(
                                                                  color: ColorResource.whiteColor,
                                                                  context: context,
                                                                  height: 1,
                                                                  fontWeight: FontWeight.normal,
                                                                  text: flashDealModel.videoUrl.toString())),
                                                        ),
                                                      ],
                                                    ))
                                                : const SizedBox.shrink(),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: flashDealModel.discount! > 0
                                                  ? Container(
                                                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                                                      decoration: BoxDecoration(
                                                          color: ColorResource.primaryColor,
                                                          borderRadius: BorderRadius.circular(10)),
                                                      child: Text(
                                                        PriceConverter.percentageCalculation(
                                                            context,
                                                            flashDealModel.unitPrice!,
                                                            flashDealModel.discount!,
                                                            flashDealModel.discountType!),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium
                                                            ?.copyWith(fontSize: 15, color: ColorResource.whiteColor),
                                                      ))
                                                  : const SizedBox(),
                                            )
                                          ]),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: textView15(
                                                context: context,
                                                text: flashDealModel.name!,
                                                maxLine: 2,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        flashDealModel.metaTitle != null
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
                                                  height: 1,
                                                  maxLine: 2,
                                                  context: context,
                                                  text: flashDealModel.metaTitle.toString(),
                                                  color: Colors.green,
                                                ))
                                            : const SizedBox.shrink(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            PriceConverterDisplay.dynamicItemPrice(context, flashDealModel),
                                            customImageButton(
                                                padding: 5,
                                                width: 36,
                                                height: 36,
                                                color: const Color(0xFFF6F7F9),
                                                onTap: () => {},
                                                icon: Image.asset(
                                                  "assets/images/love_ic.png",
                                                  width: 24,
                                                  height: 24,
                                                ),
                                                blur: 0),
                                          ],
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          );
                        })
                    : const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
