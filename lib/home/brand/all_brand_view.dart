import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';

import '../../base_widget/custom_appbar_view.dart';
import '../../base_widget/input_text_field_icon.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../home_controller.dart';
import 'brand_item_banner_view.dart';

class BrandView extends StatefulWidget {
  const BrandView({super.key});

  @override
  State<BrandView> createState() => _BrandViewState();
}

class _BrandViewState extends State<BrandView> {
  ScrollController scrollController = ScrollController();
  bool delay = false;
  GlobalKey<FormState> searchKey = GlobalKey();
  TextEditingController controller = TextEditingController();
  Timer? timer;

  @override
  void initState() {
    timer = Timer(const Duration(seconds: 1), () async {
      setState(() {
        delay = true;
        initData();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  Future<void> initData() async {
    //  await Get.find<HomeController>().getAllSeller();
    await Get.find<HomeController>().getAllBrands();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      topSafeArea: false,
      appBar: customAppBarView(
          context: context,
          titleText: '',
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 60, top: 50, right: 20),
            child: Expanded(
              child: InputTextFieldWithIcon(
                formKey: searchKey,
                hintTxt: "search".tr,
                controller: controller,
                imageIcon: Image.asset(
                  "assets/images/search_ic.png",
                  width: 19,
                  height: 19,
                ),
                textInputAction: TextInputAction.search,
              ),
            ),
          )),
      //  body: BrandItemBannerView(allBrandModel: Get.find<HomeController>().getAllBrandModel, callDataApiFunction),
      body: GetBuilder<HomeController>(
        builder: (data) => Obx(() => data.getAllBrandModel.isNotEmpty
            ? BrandItemBannerView(allBrandModel: data.getAllBrandModel, callDataApiFunction)
            : Container(
                padding: const EdgeInsets.only(bottom: 150),
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: textView23(context: context, text: "Loading..."),
                ),
              )),
      ),
    );
  }

  void callDataApiFunction(int offset) {
    Get.find<HomeController>().getAllBrands();
  }
}
