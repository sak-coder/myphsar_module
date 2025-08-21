import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';
import 'package:myphsar/category/category_controller.dart';

import '../base_colors.dart';
import '../auth/AuthController.dart';
import '../base_widget/badg_icon.dart';
import '../base_widget/custom_appbar_view.dart';
import '../base_widget/custom_icon_button.dart';
import '../base_widget/not_found.dart';
import '../base_widget/reload_button.dart';
import '../base_widget/sing_in_dialog_view.dart';
import '../cart/cart_list/cart_list_view.dart';
import '../home/home_controller.dart';
import '../home/all_product/shimmer_placeholder_view.dart';
import '../base_widget/custom_scaffold_indicator.dart';
import 'category_Item_widget.dart';

class CategoryView extends StatefulWidget {
  final BuildContext globalContext;

  final bool isSearchingMode;
  const CategoryView({super.key, required this.globalContext,required this.isSearchingMode});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  var refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    await Get.find<CategoryController>().getAllCategoryProduct();
  }

  @override
  Widget build(BuildContext context) {
    context = widget.globalContext;
    return CustomScaffoldRefreshIndicator(
      refreshIndicatorKey: refreshIndicatorKey,
      appBar: customTextAppBarView(
          context: context,
          flexibleSpace: Padding(
            padding:   EdgeInsets.only(left:widget.isSearchingMode?60:20, right: 20, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textView25(context: context, text: "category".tr, color: ColorResource.secondaryColor),
                Obx(() => badgeIcon(
                    topP: -2,
                    endP: -2,
                    visibleBadge: Get.find<HomeController>().cartCount > 0 ? true : false,
                    context: context,
                    badgeText: Get.find<HomeController>().cartCount.toString(),
                    imageIcon: customImageButton(
                      padding: 11,
                      radius: 5,
                      width: 45,
                      height: 45,
                      onTap: () async {
                        if (!Get.find<AuthController>().isSignIn()) {
                          signInDialogView(widget.globalContext);
                        } else {
                          Get.to(() =>   const CartListView());
                        }
                      },
                      blur: 0,
                      icon: Image.asset(
                        "assets/images/basket_ic.png",
                        width: 24,
                        height: 24,
                      ),
                    )))
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: Container(

          child: Get.find<CategoryController>().obx(
              (state) => MasonryGridView.count(
                    itemCount: Get.find<CategoryController>().getAllCategoryModel.length,
                    crossAxisCount: 3,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10, left: 10),
                          child: CategoryItemWidget(Get.find<CategoryController>().getAllCategoryModel[index]));
                    },
                  ),
              onLoading: categoryShimmerView(context),
              onError: (s) =>
                  onErrorReloadButton(context, s.toString(), height: MediaQuery.of(context).size.height, onTap: () {
                    Get.find<CategoryController>().getAllCategoryProduct();
                  }),
              onEmpty:
                  SizedBox(height: MediaQuery.of(context).size.height, child: notFound(context, 'empty_category'.tr))),
        ),
      ),
      onRefresh: () async {
        initData();
      },
    );
  }
}
