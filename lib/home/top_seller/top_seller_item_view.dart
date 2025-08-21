import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/home/top_seller/top_seller_model.dart';

import '../../base_colors.dart';
import '../../base_widget/custom_icon_button.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../../configure/config_controller.dart';
import '../../shop_profile/top_seller_shop_profile_view.dart';

class TopSellerItemView extends StatefulWidget {
  final TopSellerModel _topSellerModel;

  final ScrollController? _scrollController;
  final Function? _callBackFunction;
  final double _width;
  final double _height;
  final double? imageSize;
  final int? _index;

  const TopSellerItemView(
      this._index, this._width, this._height, this._topSellerModel, this._scrollController, this._callBackFunction,
      {super.key, this.imageSize = 110});

  @override
  State<TopSellerItemView> createState() => _TopSellerItemViewState();
}

class _TopSellerItemViewState extends State<TopSellerItemView> {
  int offSetCount = 1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          TopSellerShopProfileView(
              shopName: widget._topSellerModel.name.toString(), shopId: widget._topSellerModel.id.toString()),
          opaque: false,
          popGesture: true,
        );
      },
      child: Container(
        height: widget._height,
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  // decoration: BoxDecoration(
                  //   boxShadow: <BoxShadow>[
                  //     BoxShadow(color: ColorResource.lightShadowColor20, blurRadius: 1, offset: Offset(0, 0))
                  //   ],
                  //   borderRadius: BorderRadius.circular(10),
                  //   shape: BoxShape.rectangle,
                  //
                  //   // color: Color(0xFFF6F7F9),
                  // ),
                  child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10)),
                              child: FadeInImage.assetNetwork(
                                placeholder: "assets/images/placeholder_img.png",
                                fit: BoxFit.fill,
                                image: widget._topSellerModel.productImages!.isNotEmpty
                                    ? '${Get.find<ConfigController>().configModel.baseUrls?.baseProductThumbnailUrl}/${widget._topSellerModel.productImages![0]}'
                                    : '',
                                width: widget.imageSize,
                                height: widget.imageSize,
                                imageErrorBuilder: (c, o, s) => Image.asset(
                                  "assets/images/placeholder_img.png",
                                  fit: BoxFit.fitWidth,
                                  height: widget.imageSize,
                                ),
                              )),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(10)),
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/images/placeholder_img.png",
                              fit: BoxFit.fill,
                              image: widget._topSellerModel.productImages!.length > 1
                                  ? '${Get.find<ConfigController>().configModel.baseUrls?.baseProductThumbnailUrl}/${widget._topSellerModel.productImages![1]}'
                                  : '',
                              width: widget.imageSize,
                              height: widget.imageSize,
                              imageErrorBuilder: (c, o, s) => Image.asset(
                                "assets/images/placeholder_img.png",
                                fit: BoxFit.contain,
                                height: widget.imageSize,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10)),
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/images/placeholder_img.png",
                              fit: BoxFit.fill,
                              image: widget._topSellerModel.productImages!.length > 2
                                  ? '${Get.find<ConfigController>().configModel.baseUrls?.baseProductThumbnailUrl}/${widget._topSellerModel.productImages![2]}'
                                  : '',
                              width: widget.imageSize,
                              height: widget.imageSize,
                              imageErrorBuilder: (c, o, s) => Image.asset(
                                "assets/images/placeholder_img.png",
                                fit: BoxFit.fitWidth,
                                height: widget.imageSize,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10)),
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/images/placeholder_img.png",
                              fit: BoxFit.fill,
                              image: widget._topSellerModel.productImages!.length > 3
                                  ? '${Get.find<ConfigController>().configModel.baseUrls?.baseProductThumbnailUrl}/${widget._topSellerModel.productImages![3]}'
                                  : '',
                              width: widget.imageSize,
                              height: widget.imageSize,
                              imageErrorBuilder: (c, o, s) => Image.asset(
                                "assets/images/placeholder_img.png",
                                fit: BoxFit.fitWidth,
                                height: widget.imageSize,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  customImageButton(
                    padding: 0,
                    width: 80,
                    height: 80,
                    blur: 1,
                    onTap: () {
                      Get.to(
                        TopSellerShopProfileView(
                            shopName: widget._topSellerModel.name.toString(),
                            shopId: widget._topSellerModel.id.toString()),
                        opaque: false,
                        popGesture: true,
                      );
                    },
                    icon: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(100)),
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/placeholder_img.png",
                        fit: BoxFit.fitHeight,
                        image:
                            '${Get.find<ConfigController>().configModel.baseUrls?.baseShopImageUrl}/${widget._topSellerModel.image}',
                        width: 80,
                        height: 80,
                        imageErrorBuilder: (c, o, s) => Image.asset(
                          "assets/images/placeholder_img.png",
                          fit: BoxFit.fitWidth,
                          height: 80,
                        ),
                      ),
                    ),
                  )
                ],
              )),
              const SizedBox(
                height: 10,
              ),
              textView20(
                  context: context,
                  text: widget._topSellerModel.name!,
                  color: ColorResource.primaryColor,
                  fontHeight: 1),
              textView12(
                  context: context,
                  text: "${"contact_number".tr}: ${widget._topSellerModel.contact}",
                  color: ColorResource.lightShadowColor)
            ]),
      ),
    );
  }
}
