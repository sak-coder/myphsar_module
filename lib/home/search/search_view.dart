import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myphsar/category/category_detail/category_detail_view.dart';
import 'package:myphsar/category/category_model.dart';
import 'package:myphsar/category/category_view.dart';
import 'package:myphsar/helper/share_pref_controller.dart';
import 'package:myphsar/home/search/search_view_controller.dart';

import '../../base_colors.dart';
import '../../base_widget/custom_appbar_view.dart';
import '../../base_widget/custom_decoration.dart';
import '../../base_widget/custom_icon_button.dart';
import '../../base_widget/custom_scaffold.dart';
import '../../base_widget/input_text_field_icon.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../../base_widget/not_found.dart';
import '../../base_widget/reload_button.dart';
import '../../base_widget/title_row_icon_widget.dart';
import '../../configure/config_controller.dart';
import '../../product/product_item_grid_view.dart';
import '../../shop_profile/top_seller_shop_profile_view.dart';
import '../all_product/shimmer_placeholder_view.dart';
import '../seller/all_seller_view.dart';
import 'filter/filter_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  GlobalKey<FormState> searchKey = GlobalKey();
  var focusNode = FocusNode();
  bool hasFocus = false;
  bool haveTextInput = false;

  @override
  void initState() {
    Get.find<SearchViewController>().applyFilterListener.stream.listen((event) {
      Get.find<SearchViewController>().isFocus.value = false;
      FocusScope.of(context).requestFocus(FocusNode());
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      submitSearch();
    });

    _searchController.addListener(() {
      if (_searchController.text.trim().isNotEmpty) {
        setState(() {
          haveTextInput = true;
        });
      } else {
        setState(() {
          haveTextInput = false;
        });
      }
    });
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          Get.find<SearchViewController>().isFocus.value = true;
          Get.find<SearchViewController>().getSearchHistoryKeyList();
        });
      } else {
        setState(() {
          Get.find<SearchViewController>().isFocus.value = false;
        });
      }
    });
    focusNode.requestFocus();
    Get.find<SearchViewController>().notifySuccessResponse(0);
    super.initState();
  }

  // @override
  // void dispose() {
  //   focusNode.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backGroundColor: ColorResource.bgItemColor,
      appBar: customAppBarView(
        context: context,
        titleText: '',
        flexibleSpace: Container(
          padding: const EdgeInsets.only(left: 60),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: InputTextFieldWithIcon(
                    onTextChange: (data) async {
                      await Get.find<SearchViewController>().getRecommendSearchProduct(_searchController.text.trim());
                    },
                    focusNode: focusNode,
                    formKey: searchKey,
                    hintTxt: "search".tr,
                    controller: _searchController,
                    minIconWidth: 10,
                    onSubmit: (val) => {submitSearch()},
                    textInputAction: TextInputAction.search,
                  ),
                ),
              ),
              customImageButton(
                  width: 50,
                  height: 50,
                  padding: 10,
                  margin: 6,
                  blur: 0,
                  onTap: () {
                    Get.to(() => const FilterView());
                    Get.find<SearchViewController>().isFocus.value = true;
                  },
                  icon: Image.asset(
                    "assets/images/filter_ic.png",
                    width: 17,
                    height: 17,
                  ))
            ],
          ),
        ),
      ),
      body: Obx(() => Stack(children: [
            Visibility(
              visible: Get.find<SearchViewController>().isFocus.value,
              child: Container(
                padding: _searchController.text.isNotEmpty ? const EdgeInsets.all(0) : const EdgeInsets.all(10),
                child: SingleChildScrollView(
                    child: _searchController.text.isNotEmpty
                        ? searchRecommendWidget()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: Get.find<SearchViewController>().getSearchKeyList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 1),
                                decoration: customDecoration(
                                  shadowColor: ColorResource.hintTextColor,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: customImageTextButton(
                                          icon: const Icon(
                                            Icons.history_rounded,
                                            color: ColorResource.lightGrayColor,
                                            size: 17,
                                          ),
                                          radius: 0,
                                          blur: 0,
                                          onTap: () async {
                                            _searchController.text =
                                                Get.find<SearchViewController>().getSearchKeyList[index].toString();
                                            Get.find<SearchViewController>().isFocus.value = false;
                                            FocusScope.of(context).requestFocus(FocusNode());
                                            SystemChannels.textInput.invokeMethod('TextInput.hide');
                                            submitSearch();
                                          },
                                          text: textView14(
                                              context: context,
                                              text: Get.find<SharePrefController>().getSaveSearchHistory()[index],
                                              fontWeight: FontWeight.w500,
                                              color: ColorResource.lightTextColor,
                                              maxLine: 1),
                                          height: 40),
                                    ),
                                    customImageButton(
                                        padding: 10,
                                        width: 50,
                                        height: 40,
                                        onTap: () async {
                                          Get.find<SharePrefController>().removeSearchKeyWord(
                                              Get.find<SharePrefController>().getSaveSearchHistory()[index].toString());
                                          Get.find<SearchViewController>().getSearchHistoryKeyList();
                                        },
                                        icon: const Icon(
                                          Icons.clear_rounded,
                                          color: ColorResource.lightShadowColor,
                                        ),
                                        radius: 0,
                                        blur: 0),
                                  ],
                                ),
                              );
                            },
                          )),
              ),
            ),
            Visibility(
                visible: Get.find<SearchViewController>().isFocus.isTrue ? false : true,
                child: Get.find<SearchViewController>().obx(
                    (state) => SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            filterWidget(),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: textView15(
                                  context: context, fontWeight: FontWeight.w700, text: 'search_result'.tr, maxLine: 2),
                            ),

                            //     : Get.find<SearchViewController>().category.isNotEmpty ||
                            // Get.find<SearchViewController>().maxPrice > 0,
                            ProductItemGridView(Get.find<SearchViewController>(),
                                Get.find<SearchViewController>().getProductList, _scrollController, callBackRequest),
                          ],
                        )),
                    onLoading: productShimmerView(context),
                    onError: (s) => onErrorReloadButton(context, s.toString(),
                            height: MediaQuery.of(context).size.height, onTap: () {
                          Get.find<SearchViewController>().getSearchProduct(_searchController.value.text.trim(), 1);
                        }),
                    onEmpty: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 80),
                          child: filterWidget(),
                        ),
                        notFound(
                          context,
                          '${'key_not_found'.tr}\n"${_searchController.text}" ',
                        ),
                      ],
                    )))
          ])),
    );
  }

  Widget filterWidget() {
    return Visibility(
      visible:
          Get.find<SearchViewController>().maxPrice > 0 || Get.find<SearchViewController>().categoryName.isNotEmpty,
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: textView15(context: context, fontWeight: FontWeight.w700, text: 'filter'.tr, maxLine: 2),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: customDecoration(color: Colors.white, shadowBlur: 0, radius: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Get.find<SearchViewController>().maxPrice > 0
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 5),
                        child: textView14(
                            context: context,
                            fontWeight: FontWeight.w700,
                            text:
                                "${'price_range'.tr} : ${Get.find<SearchViewController>().minPrice.toStringAsFixed(2)}  to \$ ${Get.find<SearchViewController>().maxPrice.toStringAsFixed(2)}",
                            color: ColorResource.secondaryColor,
                            maxLine: 2))
                    : const SizedBox.shrink(),
                Get.find<SearchViewController>().categoryName.toString() != ''
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        child: textView14(
                            context: context,
                            fontWeight: FontWeight.w700,
                            text: "${'category'.tr} : ${Get.find<SearchViewController>().categoryName}",
                            color: ColorResource.secondaryColor,
                            maxLine: 2))
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget searchRecommendWidget() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: Get.find<SearchViewController>().getRecommendProductList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 1),
                child: Row(
                  children: [
                    Expanded(
                      child: customTextButton(
                          radius: 0,
                          blur: 0,
                          onTap: () async {
                            _searchController.text =
                                Get.find<SearchViewController>().getRecommendProductList[index].name.toString();
                            Get.find<SearchViewController>().isFocus.value = false;
                            FocusScope.of(context).requestFocus(FocusNode());
                            SystemChannels.textInput.invokeMethod('TextInput.hide');
                            submitSearch();
                          },
                          // text: RichText(
                          //   text: TextSpan(
                          //     // Here is the explicit parent TextStyle
                          //     style: const TextStyle(
                          //       fontSize: 14.0,
                          //       color: Colors.black,
                          //
                          //     ),
                          //     children: <TextSpan>[
                          //       TextSpan(text:  Get.find<SearchViewController>().getSearchFormatText(index,_searchController.text,TextLocation.start), style: const TextStyle(fontWeight: FontWeight.bold)),
                          //     //  TextSpan(text:  Get.find<SearchViewController>().getSearchFormatText(index,_searchController.text,TextLocation.right)),
                          //     ],
                          //   ),
                          // ),
                          text: textView14(
                              context: context,
                              text: Get.find<SearchViewController>().getRecommendProductList[index].name.toString(),
                              fontWeight: FontWeight.w700,
                              color: ColorResource.lightTextColor,
                              maxLine: 1),
                          height: 40),
                    ),
                    customImageButton(
                        padding: 10,
                        width: 50,
                        height: 40,
                        onTap: () async {
                          Get.find<SharePrefController>().removeSearchKeyWord(
                              Get.find<SearchViewController>().getRecommendProductList[index].name.toString());
                          Get.find<SearchViewController>().getSearchHistoryKeyList();
                        },
                        icon: const Icon(
                          Icons.search,
                          color: ColorResource.lightShadowColor,
                        ),
                        radius: 0,
                        blur: 0),
                  ],
                ),
              );
            },
          ),
          Get.find<SearchViewController>().getRecommendCategoryList.isNotEmpty
              ? Wrap(
                  children: [
                    const Divider(
                      color: ColorResource.bgItemColor,
                      thickness: 10,
                    ),
                    titleRowWidget(
                        context: context,
                        title: 'relate_cat'.tr,
                        fontWeight: FontWeight.w700,
                        padding: const EdgeInsets.only(left: 10),
                        icon: customImageTextButton(
                            blur: 0,
                            text: textView14(context: context, text: "more".tr),
                            textAlignment: Alignment.centerRight,
                            height: 50,
                            iconAlign: CustomIconAlign.right,
                            width: 100,
                            icon: const Icon(Icons.keyboard_arrow_right_outlined)),
                        onTap: () {
                          Get.to(CategoryView(
                            globalContext: context,
                            isSearchingMode: true,
                          ));
                        }),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: Get.find<SearchViewController>().getRecommendCategoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(CategoryDetailView(
                                CategoryModel(
                                    name: Get.find<SearchViewController>().getRecommendCategoryList[index].name,
                                    id: Get.find<SearchViewController>().getRecommendCategoryList[index].id),
                                true));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 20,
                            width: MediaQuery.of(context).size.width,
                            child: textView14(
                              context: context,
                              text: Get.find<SearchViewController>().getRecommendCategoryList[index].name.toString(),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                )
              : const SizedBox.shrink(),
          Get.find<SearchViewController>().getRecommendShopList.isNotEmpty
              ? Wrap(
                  children: [
                    const Divider(
                      color: ColorResource.bgItemColor,
                      thickness: 10,
                    ),
                    titleRowWidget(
                        context: context,
                        title: 'relate_shop'.tr,
                        fontWeight: FontWeight.w700,
                        padding: const EdgeInsets.only(left: 10),
                        icon: customImageTextButton(
                            blur: 0,
                            text: textView14(context: context, text: "more".tr),
                            textAlignment: Alignment.centerRight,
                            height: 50,
                            iconAlign: CustomIconAlign.right,
                            width: 100,
                            icon: const Icon(Icons.keyboard_arrow_right_outlined)),
                        onTap: () {
                          Get.to(const AllSellerView());
                        }),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: Get.find<SearchViewController>().getRecommendShopList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(TopSellerShopProfileView(
                              shopName: Get.find<SearchViewController>().getRecommendShopList[index].name.toString(),
                              shopId: Get.find<SearchViewController>().getRecommendShopList[index].id.toString(),
                            ));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, bottom: 15),
                            height: 30,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                FadeInImage.assetNetwork(
                                  placeholder: "assets/images/placeholder_img.png",
                                  fit: BoxFit.cover,
                                  image:
                                      '${Get.find<ConfigController>().configModel.baseUrls?.baseShopImageUrl}/${Get.find<SearchViewController>().getRecommendShopList[index].image!}',
                                  width: 30,
                                  height: 30,
                                  imageErrorBuilder: (c, o, s) => Image.asset(
                                    "assets/images/placeholder_img.png",
                                    fit: BoxFit.fitWidth,
                                    height: 100,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                textView14(
                                  context: context,
                                  text: Get.find<SearchViewController>().getRecommendShopList[index].name.toString(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  void submitSearch() {
    if (_searchController.text.isNotEmpty) {
      Get.find<SharePrefController>().saveSearchHistory(_searchController.value.text.trim());
      Get.find<SearchViewController>().isSearching.value = true;
      Get.find<SearchViewController>().resetData();
      Get.find<SearchViewController>().getSearchProduct(_searchController.value.text.trim(), 1);
    }
  }

  void callBackRequest(int offset) {
    Get.find<SearchViewController>().getSearchProduct(_searchController.value.text.trim(), offset);
  }
}
