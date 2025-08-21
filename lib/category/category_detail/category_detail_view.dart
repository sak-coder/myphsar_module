import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';

import '../../base_colors.dart';
import '../../base_widget/custom_appbar_view.dart';
import '../../base_widget/custom_icon_button.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../../base_widget/not_found.dart';
import '../../base_widget/reload_button.dart';
import '../../home/all_product/shimmer_placeholder_view.dart';
import '../../product/product_item_grid_view.dart';
import '../category_model.dart';
import 'category_detail_controller.dart';

class CategoryDetailView extends StatefulWidget {
  final CategoryModel categoryModel;
  final bool isSearchingMode ;

  const CategoryDetailView(this.categoryModel,this.isSearchingMode, {super.key});

  @override
  State<CategoryDetailView> createState() => _CategoryDetailViewState();
}

class _CategoryDetailViewState extends State<CategoryDetailView> {
  ScrollController scrollController = ScrollController();

  bool switchCategoryView = true;

  @override
  void initState() {
    initData();
    if(!widget.isSearchingMode){
      toggleSingleCardSelection(1);
    }else{
      switchCategoryView= false;
    }

    super.initState();
  }

  void initData() async {
    await Get.find<CategoryDetailController>()
        .getAllCategoryDetailProduct(widget.categoryModel.id.toString(), 1, resetData: true);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backGroundColor: ColorResource.bgItemColor,
      appBar: customAppBarView(
          elevation: 0,
          context: context,
          titleText: widget.categoryModel.name.toString(),
          flexibleSpace: Visibility(
            visible: !widget.isSearchingMode,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: customImageButton(
                  padding: 10,
                  height: 45,
                  width: 45,
                  blur: 0,
                  icon: switchCategoryView
                      ? Image.asset(
                          "assets/images/cat_on.png",
                          width: 25,
                          height: 19,
                        )
                      : Image.asset(
                          "assets/images/cat_off.png",
                          width: 25,
                          height: 19,
                        ),
                  onTap: () {
                    setState(() {
                      switchCategoryView = !switchCategoryView;
                    });
                  },
                ),
              ),
            ),
          )),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: switchCategoryView ? 90 : 0,
            ),
            child: Get.find<CategoryDetailController>().obx(
                (state) => SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: EdgeInsets.only(right: switchCategoryView ? 1 : 3,top: 5),
                      child: ProductItemGridView(
                        Get.find<CategoryDetailController>(),
                        Get.find<CategoryDetailController>().getAllProductCategoryList,
                        scrollController,
                        callback,
                        isCategory: true,
                        paddingRight: 3,
                        paddingRightItem: 3,
                      ),
                    )),
                onLoading: productShimmerView(context),
                onError: (s) =>
                    onErrorReloadButton(context, s.toString(), height: MediaQuery.of(context).size.height, onTap: () {
                      initData();
                    }),
                onEmpty: SizedBox(
                    height: MediaQuery.of(context).size.height, child: notFound(context, 'empty_product'.tr))),
          ),

            Visibility(
              visible: switchCategoryView,
              child: Container(
                  height: double.infinity,
                  width: 95,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 3),
                    ],
                  ),
                  child: ListView.builder(
                    itemCount: widget.categoryModel.childes?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.only(left: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Material(
                              child: InkWell(
                                onTap: () {
                                  if (widget.categoryModel.childes![index].toggle) {
                                    return;
                                  }
                                  if (index == 0) {
                                    initData();
                                    toggleSingleCardSelection(0);
                                  } else {
                                    Get.find<CategoryDetailController>().getAllCategoryDetailProduct(
                                        widget.categoryModel.childes![index].id.toString(), 1,
                                        resetData: true);
                                    toggleSingleCardSelection(index);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: textView13(
                                            color: widget.categoryModel.childes![index].toggle
                                                ? ColorResource.primaryColor
                                                : ColorResource.darkTextColor,
                                            fontWeight: widget.categoryModel.childes![index].toggle
                                                ? FontWeight.w600
                                                : FontWeight.w500,
                                            context: context,
                                            text: index == 0
                                                ? "all".tr
                                                : widget.categoryModel.childes![index].name.toString(),
                                            maxLine: 3),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        size: 15,
                                        color: Color(0xFF555555),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                              color: ColorResource.hintTextColor,
                              height: 1,
                            )
                          ],
                        ),
                      );
                    },
                  )),
            ),
        ],
      ),
    );
  }

  void callback(int offset) async {
    await Get.find<CategoryDetailController>()
        .getAllCategoryDetailProduct(widget.categoryModel.id.toString(), offset, resetData: false);
  }

  void toggleSingleCardSelection(int index) {
    for (int indexBtn = 0; indexBtn < widget.categoryModel.childes!.length; indexBtn++) {
      if (indexBtn == index) {
        setState(() {
          widget.categoryModel.childes![indexBtn].toggle = true;
        });
      } else {
        setState(() {
          widget.categoryModel.childes![indexBtn].toggle = false;
        });
      }
    }
  }
}
