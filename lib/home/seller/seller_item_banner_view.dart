import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/home/seller/seller_item_widget.dart';

import 'seller_controller.dart';

class SellerItemBannerView extends StatefulWidget {
  final ScrollController? scrollController;

  final Function function;

  const SellerItemBannerView(this.function, {super.key, this.scrollController});

  @override
  State<SellerItemBannerView> createState() => _SellerItemBannerViewState();
}

class _SellerItemBannerViewState extends State<SellerItemBannerView> {
  int offSetCount = 1;

  @override
  void initState() {
    widget.scrollController?.addListener(() {
      if (widget.scrollController?.position.pixels == widget.scrollController?.position.maxScrollExtent) {
        offSetCount++;
        widget.function(offSetCount);
      }
    });
    super.initState();
  }

//TODO Delay render view loading
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Obx(() => ListView.builder(
              itemCount: Get.find<SellerController>().getAllSearchSellerModel.length,
              padding: const EdgeInsets.only(bottom: 5),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.all(5),
                    child: SellerItemWidget(
                      allSellerModel: Get.find<SellerController>().getAllSearchSellerModel[index],
                    ));
              },
            )));
  }
}
