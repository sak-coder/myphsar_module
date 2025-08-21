import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/configure/config_controller.dart';

import '../../base_widget/custom_appbar_view.dart';
import 'FaqExpendView.dart';

class FaqView extends StatefulWidget {
  const FaqView({super.key});

  @override
  State<FaqView> createState() => _FaqViewState();
}

class _FaqViewState extends State<FaqView> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(context: context, titleText: 'FAQ'),
      body: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: Get.find<ConfigController>().configModel.faq!.length,
          itemBuilder: (BuildContext context, int index) {
            return FaqExpendView(Get.find<ConfigController>().configModel.faq![index]);
          }),
    );
  }
}
