import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';

import 'brand_item_widget.dart';
import 'all_brand_model.dart';

class BrandItemBannerView extends StatefulWidget {
  final List<AllBrandModel> allBrandModel;

  final ScrollController? scrollController;

  final Function function;

  const BrandItemBannerView(this.function, {super.key, required this.allBrandModel, this.scrollController});

  @override
  State<BrandItemBannerView> createState() => _BrandItemBannerViewState();
}

class _BrandItemBannerViewState extends State<BrandItemBannerView> {
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
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 100),
      child: Column(
        children: [
          MasonryGridView.count(
            itemCount: widget.allBrandModel.length,
            crossAxisCount: 1,
            padding: const EdgeInsets.only(bottom: 5),
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.only(right: 5, top: 5, bottom: 5, left: 5),
                  child: BrandItemWidget(
                    allBrandModel: widget.allBrandModel[index],
                  ));
            },
          ),
          Obx(() => Get.find<BaseController>().isLoading.value
              ? const SizedBox(height: 150, child: CupertinoActivityIndicator())
              : Container())
        ],
      ),
    );
  }
}
