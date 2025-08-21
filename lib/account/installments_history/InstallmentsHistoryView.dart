import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/account/installments_history/InstallmentHistoryViewController.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_decoration.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';

import '../../base_widget/custom_icon_button.dart';
import '../../base_widget/not_found.dart';
import '../../base_widget/reload_button.dart';
import '../../home/all_product/shimmer_placeholder_view.dart';
import '../installments_history_detail/InstallmentHistoryDetailView.dart';

class InstallmentsHistoryView extends StatefulWidget {
  const InstallmentsHistoryView({super.key});

  @override
  State<InstallmentsHistoryView> createState() => _InstallmentsHistoryViewState();
}

class _InstallmentsHistoryViewState extends State<InstallmentsHistoryView> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    Get.find<InstallmentHistoryViewController>().getInstallmentHistory();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: customAppBarView(context: context, titleText: 'installments'.tr),
        body: Get.find<InstallmentHistoryViewController>().obx(
            (state) => ListView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                itemCount: Get.find<InstallmentHistoryViewController>().getInstallmentsHistoryListModel.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  var installment =
                      Get.find<InstallmentHistoryViewController>().getInstallmentsHistoryListModel.data![index];

                  return Stack(children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                      padding: const EdgeInsets.all(20),
                      height: 88,
                      width: 10,
                      decoration: customDecorationOnly(
                          bottomLeft: 10,
                          topLeft: 10,
                          shadowBlur: 2,
                          color: installment.statusCode == "1"
                              ? ColorResource.greenColor
                              : installment.statusCode == "3"
                                  ? ColorResource.primaryColor
                                  : ColorResource.yellowColor),
                    ),
                    InkWell(
                      onTap: () async {
                        Get.to(() => InstallmentHistoryDetailView(
                              uuid: installment.uuid.toString(),
                              color: installment.statusCode == "1"
                                  ? ColorResource.greenColor
                                  : installment.statusCode == "3"
                                      ? ColorResource.primaryColor
                                      : ColorResource.yellowColor,
                              textColor: installment.statusCode == "3" ? Colors.white : ColorResource.secondaryColor,
                            ));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 25, right: 20, top: 10),
                        padding: const EdgeInsets.all(10),
                        height: 88,
                        width: MediaQuery.of(context).size.width,
                        decoration: customDecorationOnly(
                            bottomLeft: 7,
                            bottomRight: 10,
                            topRight: 10,
                            topLeft: 7,
                            shadowBlur: 3,
                            offset: const Offset(
                              1,
                              0,
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textView15(
                                context: context,
                                text: '${'id'.tr} ${installment.tranId}',
                                maxLine: 1,
                                color: ColorResource.darkTextColor,
                                fontWeight: FontWeight.w600),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textView14(
                                    context: context,
                                    text: 'price'.tr + installment.productPrice.toString(),
                                    maxLine: 1,
                                    color: ColorResource.lightTextColor,
                                    fontWeight: FontWeight.w500),
                                customTextButton(
                                    height: 35,
                                    width: 80,
                                    blur: 0,
                                    padding: 5,
                                    color: ColorResource.lightHintTextColor,
                                    radius: 5,
                                    text: Center(
                                      child: textView12(
                                          context: context,
                                          text: installment.status.toString(),
                                          color: ColorResource.secondaryColor),
                                    )),
                              ],
                            ),
                            textView14(
                                context: context,
                                text: 'date'.tr + installment.createdAt!,
                                maxLine: 1,
                                color: ColorResource.lightTextColor),
                          ],
                        ),
                      ),
                    ),
                  ]);
                }),
            onLoading: wishlistShimmerView(context),
            onError: (s) =>
                onErrorReloadButton(context, s.toString(), height: MediaQuery.of(context).size.height, onTap: () {
                  initData();
                }),
            onEmpty: SizedBox(
                height: MediaQuery.of(context).size.height, child: notFound(context, 'empty_installments'.tr))));
  }
}
