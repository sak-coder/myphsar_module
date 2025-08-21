import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/home/search/search_view_controller.dart';

import '../../base_widget/custom_appbar_view.dart';
import '../../base_widget/custom_scaffold.dart';
import '../../base_widget/not_found.dart';
import '../../base_widget/reload_button.dart';
import '../../product/product_item_grid_view.dart';
import '../home/all_product/shimmer_placeholder_view.dart';

class HashTagView extends StatefulWidget {
  final String hashTag;

  const HashTagView({super.key, required this.hashTag});

  @override
  State<HashTagView> createState() => _HashTagViewState();
}

class _HashTagViewState extends State<HashTagView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    submitSearch(widget.hashTag);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(
        context: context,
        titleText: widget.hashTag,
      ),
      body: Get.find<SearchViewController>().obx(
          (state) => SingleChildScrollView(
              controller: _scrollController,
              child: ProductItemGridView(Get.find<SearchViewController>(),
                  Get.find<SearchViewController>().getProductList, _scrollController, callRequest)),
          onLoading: productShimmerView(context),
          onError: (s) =>
              onErrorReloadButton(context, s.toString(), height: MediaQuery.of(context).size.height, onTap: () {
                Get.find<SearchViewController>().getSearchProduct(widget.hashTag, 1);
              }),
          onEmpty: SizedBox(
              height: 500,
              child: notFound(context, '${'key_not_found'.tr}\n"${widget.hashTag}" ',
                  image: "assets/images/search_empty.png", width: MediaQuery.of(context).size.width))),
    );
  }

  void submitSearch(String hashtag) {
    Get.find<SearchViewController>().isSearching.value = true;
    Get.find<SearchViewController>().resetData();
    Get.find<SearchViewController>().getSearchProduct(hashtag, 1);
  }

  void callRequest(int offset) {
    Get.find<SearchViewController>().getSearchProduct(widget.hashTag, offset);
  }
}
