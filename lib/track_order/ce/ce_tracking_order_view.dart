import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/base_widget/custom_decoration.dart';
import 'package:myphsar/base_widget/custom_scaffold_indicator.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';

import '../../base_widget/custom_appbar_view.dart';
import '../../base_widget/custom_icon_button.dart';
import '../../base_widget/not_found.dart';
import '../../base_widget/reload_button.dart';
import '../../utils/date_format.dart';
import '../tracking_order_view_controller.dart';

class CeTrackingOrderView extends StatefulWidget {
  final String orderId;
  final String orderDate;

  const CeTrackingOrderView({super.key, required this.orderId, required this.orderDate});

  @override
  State<CeTrackingOrderView> createState() => _CeTrackingOrderViewState();
}

class _CeTrackingOrderViewState extends State<CeTrackingOrderView> {
  var key1 = GlobalKey();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    Get.find<TrackingOrderViewController>().getCeTrackingHistoryDetail(context, widget.orderId);
  }

  // Future<void> _makePhoneCall(String phoneNumber) async {
  //   final Uri launchUri = Uri(
  //     scheme: 'tel',
  //     path: phoneNumber,
  //   );
  //   await launchUrl(launchUri);
  // }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldRefreshIndicator(
      appBar: customAppBarView(context: context, titleText: "track_order".tr),
      // bottomNavigationBar: CustomTextButton(
      //   alignmentDirectional: AlignmentDirectional.center,
      //   onTap: () {
      //     _makePhoneCall('010599343');
      //     //   UrlLauncher.launchUrl("tel:21213123123" as Uri);
      //   },
      //   radius: 10,
      //   margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
      //   height: 50,
      //   text: TextViewSize_14(
      //       fontWeight: FontWeight.bold,
      //       color: ColorResource.secondaryColor,
      //       context: context,
      //       text: "Call Deliver: 010599343",
      //       textAlign: TextAlign.center),
      // ),
      body: Get.find<TrackingOrderViewController>().obx(
          (state) => Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: textView12(
                          fontWeight: FontWeight.bold,
                          context: context,
                          color: ColorResource.secondaryColor,
                          text: "date".tr + DateFormate.isoStringToLocalDay(widget.orderDate)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: textView12(
                          fontWeight: FontWeight.bold,
                          color: ColorResource.secondaryColor,
                          context: context,
                          text: "${"order".tr} ${"id".tr}${widget.orderId}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 11, top: 15),
                      child: textView15(fontWeight: FontWeight.bold, context: context, text: "delivery_status".tr),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                          itemCount: Get.find<TrackingOrderViewController>().getCeTrackingModel.data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return LayoutBuilder(builder: (context, constraints) {
                              final tp = TextPainter(
                                  text: TextSpan(
                                      text: Get.find<TrackingOrderViewController>()
                                          .getCeTrackingModel
                                          .data![index]
                                          .statusMsg
                                          .toString()),
                                  textDirection: TextDirection.ltr);
                              tp.layout(maxWidth: constraints.maxWidth);

                              return Container(
                                  padding: const EdgeInsets.only(left: 10, top: 7, right: 5),
                                  decoration: calculateRadius(index),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0, bottom: 5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            textView11(
                                                fontWeight: FontWeight.bold,
                                                color: ColorResource.lightShadowColor,
                                                context: context,
                                                text: DateFormate.isoStringToLocalDay(
                                                    Get.find<TrackingOrderViewController>()
                                                        .getCeTrackingModel
                                                        .data![index]
                                                        .date
                                                        .toString())),
                                            textView10(
                                                color: ColorResource.hintTextColor,
                                                context: context,
                                                text: DateFormate.isoStringToLocalTimeOnly(
                                                    Get.find<TrackingOrderViewController>()
                                                        .getCeTrackingModel
                                                        .data![index]
                                                        .date
                                                        .toString()))
                                          ],
                                        ),
                                      ),
                                      Stack(
                                        children: [
                                          customTextButton(
                                            blur: 0,
                                            alignmentDirectional: AlignmentDirectional.center,
                                            padding: 0,
                                            margin: EdgeInsets.zero,
                                            height: 20,
                                            width: 20,
                                            color: ColorResource.primaryColor,
                                            text: textView12(
                                                height: 1,
                                                fontWeight: FontWeight.bold,
                                                context: context,
                                                text: (index + 1).toString(),
                                                color: ColorResource.whiteColor),
                                          ),
                                          index + 1 <
                                                  Get.find<TrackingOrderViewController>()
                                                      .getCeTrackingModel
                                                      .data!
                                                      .length
                                              ? Container(
                                                  margin: const EdgeInsets.only(left: 9, top: 25),
                                                  width: 2,
                                                  height: tp.height + 8,
                                                  color: ColorResource.orange,
                                                )
                                              : const SizedBox.shrink(),
                                        ],
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 10, left: 10),
                                          child: textView13(
                                              maxLine: 10,
                                              fontWeight: FontWeight.w600,
                                              context: context,
                                              text: Get.find<TrackingOrderViewController>()
                                                  .getCeTrackingModel
                                                  .data![index]
                                                  .statusMsg
                                                  .toString()),
                                        ),
                                      ),
                                    ],
                                  ));
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          onError: (s) =>
              onErrorReloadButton(context, s.toString(), height: MediaQuery.of(context).size.height, onTap: () {}),
          onEmpty: SizedBox(height: MediaQuery.of(context).size.height, child: notFound(context, 'empty_tracking'.tr))),
      onRefresh: () async {
        initData();
      },
    );
  }

  Decoration calculateRadius(int index) {
    if (Get.find<TrackingOrderViewController>().getCeTrackingModel.data!.length == 1) {
      return customDecoration(radius: 10, color: ColorResource.lightHintTextColor);
    }
    if (index == 0) {
      return customDecorationOnly(topLeft: 10, topRight: 10, color: ColorResource.lightHintTextColor);
    } else if (index + 1 < Get.find<TrackingOrderViewController>().getCeTrackingModel.data!.length) {
      return customDecorationOnly(color: ColorResource.lightHintTextColor);
    } else {
      return customDecorationOnly(bottomRight: 10, bottomLeft: 10, color: ColorResource.lightHintTextColor);
    }
  }
}
