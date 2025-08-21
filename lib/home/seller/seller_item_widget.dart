import  'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/base_widget/custom_icon_button.dart';
import 'package:myphsar/shop_profile/shop_profile_model.dart';

import '../../base_widget/myphsar_text_view.dart';
import '../../configure/config_controller.dart';
import '../../shop_profile/shop_profile_view.dart';
import 'seller_model.dart';

class SellerItemWidget extends StatefulWidget {
  final SellerModel allSellerModel;

  const SellerItemWidget({super.key, required this.allSellerModel});

  @override
  State<SellerItemWidget> createState() => _SellerItemWidgetState();
}

String formatNumber(int number) {
  String result = '';

  int digit = 1; //to know when to add a space or not
  while (number > 0) {
    if (digit > 1 && digit % 3 == 1) {
      //don't add a space at the very beginning
      result = '${number % 10} $result';
    } else {
      result = (number % 10).toString() + result;
    }
    digit++;
    number = number ~/ 10; //divides by 10, in other words, shifts 1 digit to the right
  }
  return result;
}
class _SellerItemWidgetState extends State<SellerItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ShopProfileView(
            ShopProfileModel(verified: widget.allSellerModel.seller?.verified, shop: widget.allSellerModel)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(alignment: AlignmentDirectional.centerStart, children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(10),
          //   child: FadeInImage.assetNetwork(
          //     placeholder: "assets/images/banner.png",
          //     placeholderFit: BoxFit.cover,
          //     placeholderCacheHeight: 120,
          //     fadeInDuration: const Duration(seconds: 2),
          //     fit: BoxFit.cover,
          //     height: 120,
          //     image: Get.find<ConfigController>().baseShopBannerUrl + (widget.allSellerModel.banner!),
          //     width: MediaQuery.of(context).size.width,
          //     imageErrorBuilder: (c, o, s) => Image.asset(
          //       "assets/images/banner.png",
          //       fit: BoxFit.cover,
          //       width: MediaQuery.of(context).size.width,
          //       height: 120,
          //     ),
          //   ),
          // ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: 120,
          //   decoration: BoxDecoration(
          //     gradient: const LinearGradient(begin: FractionalOffset.centerLeft, end: FractionalOffset.centerRight, colors: [
          //       Color.fromRGBO(0, 0, 0, 0.63725490196078434),
          //       Color.fromRGBO(114, 112, 112, 0.37254901960784315),
          //     ], stops: [
          //       0.5,
          //       1,
          //     ]),
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 5,bottom: 5),

            child: Row(children: [
              FadeInImage.assetNetwork(
                placeholder: "assets/images/placeholder_img.png",
                fit: BoxFit.contain,
                image:
                    '${Get.find<ConfigController>().configModel.baseUrls?.baseShopImageUrl}/${widget.allSellerModel.image!}',
                width: 80,
                height: 80,
                imageErrorBuilder: (c, o, s) => Image.asset(
                  "assets/images/placeholder_img.png",
                  fit: BoxFit.fitWidth,
                  height: 80,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: SizedBox(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textView14(
                        context: context,
                        fontWeight: FontWeight.w700,
                        text: widget.allSellerModel.name!,
                        maxLine: 2,
                        height: 1.5),
                    customImageTextButton(
                      leftPadding: 0,
                      blur: 0,
                      padding: 0,
                      height: 25,
                      icon: Image.asset("assets/images/phone_ic.png", color: Colors.blue, height: 13,width: 15,),
                      text: textView13(
                          context: context,
                          fontWeight: FontWeight.w500,
                          text: formatNumber(int.tryParse(widget.allSellerModel.contact.toString())!),
                          maxLine: 2,
                          color: ColorResource.lightTextColor),
                    ),
                    customImageTextButton(
                      leftPadding: 0,
                      blur: 0,
                      padding: 0,
                      height: 25,
                      icon: Image.asset(
                        "assets/images/email_ic.png",
                        color: ColorResource.primaryColor,
                        height: 12,
                        width: 15,
                      ),
                      text: textView13(
                          context: context,
                          fontWeight: FontWeight.w500,
                          text: widget.allSellerModel.email!,
                          maxLine: 2,
                          color: ColorResource.lightTextColor),
                    )
                  ],
                ),
              ))
            ]),
          ),
        ]),
      ),
    );
  }
}
