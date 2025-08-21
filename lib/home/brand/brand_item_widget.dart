import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/home/brand/all_brand_model.dart';

import '../../base_widget/custom_icon_button.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../../configure/config_controller.dart';

class BrandItemWidget extends StatefulWidget {
  final AllBrandModel allBrandModel;

  const BrandItemWidget({super.key, required this.allBrandModel});

  @override
  State<BrandItemWidget> createState() => _BrandItemWidgetState();
}

class _BrandItemWidgetState extends State<BrandItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 3),
        ],
      ),
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage.assetNetwork(
            placeholder: "assets/images/placeholder_img.png",
            placeholderFit: BoxFit.contain,
            placeholderCacheHeight: 120,
            fadeInDuration: const Duration(seconds: 2),
            fit: BoxFit.fitHeight,
            height: 120,
            image:
                widget.allBrandModel.image != null ? '${Get.find<ConfigController>().configModel.baseUrls?.baseBrandImageUrl}/${widget.allBrandModel.image!}' : "",
            width: MediaQuery.of(context).size.width,
            imageErrorBuilder: (c, o, s) => Image.asset(
              "assets/images/placeholder_img.png",
              fit: BoxFit.fitWidth,
              height: 120,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: customImageButtonShadowBg(
                  padding: 5,
                  width: 36,
                  height: 36,
                  onTap: () => {},
                  icon: Image.asset(
                    "assets/images/love_ic.png",
                    width: 24,
                    height: 24,
                  ),
                  blur: 1),
            ),
            textView20(context: context, text: widget.allBrandModel.name!)
          ]),
        ),
      ]),
    );
  }
}
