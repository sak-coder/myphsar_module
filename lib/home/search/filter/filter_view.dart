import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/base_widget/input_text_field_custom.dart';
import 'package:myphsar/base_widget/reload_button.dart';
import 'package:myphsar/category/category_controller.dart';

import '../../../base_colors.dart';
import '../../../base_widget/custom_icon_button.dart';
import '../../../base_widget/myphsar_text_view.dart';
import '../../../base_widget/not_found.dart';
import '../search_view_controller.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  bool checkBox = false;
  int catId = 0;
  String catName = '';

  var selectItemToggle = -1;
  final _startPriceController = TextEditingController();
  final _endPriceController = TextEditingController();

  // GlobalKey<FormState> startPriceKey = GlobalKey();
  // GlobalKey<FormState> endPriceKey = GlobalKey();

  @override
  void initState() {
    Get.find<CategoryController>().getAllCategoryProduct();
    _startPriceController.text =
        Get.find<SearchViewController>().minPrice <= 0 ? "" : Get.find<SearchViewController>().minPrice.toString();
    _endPriceController.text =
        Get.find<SearchViewController>().minPrice <= 0 ? "" : Get.find<SearchViewController>().maxPrice.toString();
    super.initState();
  }

  void clearFilter() {
    catName = '';
    _endPriceController.text = '';
    _startPriceController.text = '';
    selectItemToggle = -1;
    Get.find<SearchViewController>().maxPrice.value = 0;
    Get.find<SearchViewController>().minPrice.value = 0;
    Get.find<SearchViewController>().categoryName.value = "";
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      topSafeArea: true,
      appBar: customAppBarView(
          context: context,
          titleText: "filter".tr,
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              customTextButton(
                height: 40,
                radius: 10,
                blur: 0,
                margin: const EdgeInsets.only(left: 15, right: 15),
                onTap: () {
                  setState(() {
                    clearFilter();
                  });
                },
                text: Center(
                    child: textView15(context: context, text: "clear".tr, maxLine: 1, fontWeight: FontWeight.w700)),
              ),
            ],
          )),
      body: SingleChildScrollView(
        reverse: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: textView15(
                  context: context,
                  text: "price_range".tr,
                  color: ColorResource.darkTextColor,
                  fontWeight: FontWeight.w700),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: InputTextFieldCustom(
                      textAlign: TextAlign.center,
                      hintTxt: "start_price".tr,
                      inputType: TextInputType.number,
                      controller: _startPriceController,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    width: 20,
                    height: 2,
                    color: ColorResource.hintTextColor,
                  ),
                  Expanded(
                    child: InputTextFieldCustom(
                      textAlign: TextAlign.center,
                      inputType: TextInputType.number,
                      hintTxt: "end_price".tr,
                      controller: _endPriceController,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: ColorResource.bgItemColor,
              thickness: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textView15(
                      context: context,
                      text: "category".tr,
                      color: ColorResource.darkTextColor,
                      fontWeight: FontWeight.w700),
                  Row(
                    children: [
                      textView15(
                          context: context,
                          text: catName.toString(),
                          color: ColorResource.primaryColor,
                          maxLine: 1,
                          fontWeight: FontWeight.w700),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Get.find<CategoryController>().obx(
                (state) => MasonryGridView.count(
                    crossAxisCount: 2,
                    itemCount: Get.find<CategoryController>().getAllCategoryModel.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var category = Get.find<CategoryController>().getAllCategoryModel;
                      return Row(
                        children: [
                          Expanded(
                            child: customTextButton(
                                radius: 10,
                                color: selectItemToggle == index ? ColorResource.liteYellowColor : Colors.white,
                                blur: 0,
                                onTap: () => {
                                      setState(() {
                                        catName = category[index].name.toString();
                                        catId = category[index].id!;
                                        selectItemToggle = index;
                                      })
                                    },
                                text: textView14(
                                  maxLine: 2,
                                    fontWeight: FontWeight.w500,
                                    context: context,
                                    text: Get.find<CategoryController>().getAllCategoryModel[index].name!)),
                          ),
                        ],
                      );
                    }),
                onEmpty: SizedBox(height: 300, child: notFound(context, "empty_category".tr)),
                onError: (error) => onErrorReloadButton(
                  context,
                  error.toString(),
                  height: 300,
                  onTap: () async {
                    Get.find<CategoryController>().getAllCategoryProduct();
                  },
                ),
              ),
            ),
            customTextButton(
              color: ColorResource.primaryColor,
              height: 50,
              margin: const EdgeInsets.all(20),
              radius: 10,
              blur: 0,
              onTap: () {
                Get.find<SearchViewController>().applyFilter(
                    catName.toString(),
                    catId.toString(),
                    _startPriceController.text.isEmpty ? 0 : double.parse(_startPriceController.text.toString()),
                    _endPriceController.text.isEmpty ? 0 : double.parse(_endPriceController.text.toString()));

                Get.find<SearchViewController>().applyFilterListener.add(true);
                Navigator.pop(context);
              },
              text: Center(
                  child: textView15(
                      color: Colors.white,
                      context: context,
                      text: "apply".tr,
                      maxLine: 1,
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}
