import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/account/wishlist/wishlist_controller.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_decoration.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../base_widget/not_found.dart';
import '../../base_widget/reload_button.dart';
import '../../configure/config_controller.dart';
import '../../home/all_product/shimmer_placeholder_view.dart';

class OffersView extends StatefulWidget {
  const OffersView({super.key});

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  @override
  void initState() {
    getOffer();
    super.initState();
  }

  void getOffer() async {
    Get.find<WishlistController>().getOffer(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(context: context, titleText: 'offers'.tr),
      body: Get.find<WishlistController>().obx(
          (state) => Obx(
                () => ListView.builder(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    itemCount: Get.find<WishlistController>().getOfferModel.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                        height: 160,
                        decoration: customDecoration(
                          radius: 10,
                          shadowBlur: 3,
                        ),
                        child: InkWell(
                            onTap: () => {_launchUrl(Get.find<WishlistController>().getOfferModel[index].url!)},
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FadeInImage.assetNetwork(
                                placeholder: "assets/images/placeholder_img.png",
                                fit: BoxFit.cover,
                                image: '${Get.find<ConfigController>().configModel.baseUrls?.baseBannerImageUrl}'
                                    '/${Get.find<WishlistController>().getOfferModel[index].photo}',
                                imageErrorBuilder: (c, o, s) => Image.asset(
                                  "assets/images/placeholder_img.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                      );
                    }),
              ),
          onLoading: offerShimmerView(context),
          onError: (s) =>
              onErrorReloadButton(context, s.toString(), height: MediaQuery.of(context).size.height, onTap: () {
                getOffer();
              }),
          onEmpty: SizedBox(height: MediaQuery.of(context).size.height, child: notFound(context, 'empty_offer'.tr))),
      topSafeArea: true,
    );
  }

  _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
