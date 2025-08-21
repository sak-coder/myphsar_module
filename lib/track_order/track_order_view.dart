import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/app_constants.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_decoration.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';
import 'package:myphsar/track_order/tracking_order_view_controller.dart';
import 'package:myphsar/utils/date_format.dart';

import '../base_widget/not_found.dart';
import '../base_widget/reload_button.dart';

class TrackOrderView extends StatefulWidget {
  final String orderId;

  const TrackOrderView({super.key, required this.orderId});

  @override
  State<TrackOrderView> createState() => _TrackOrderViewState();
}

class _TrackOrderViewState extends State<TrackOrderView> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    Get.find<TrackingOrderViewController>().getTrackingHistoryDetail(context, widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(context: context, titleText: "tracking".tr),
      body: Get.find<TrackingOrderViewController>().obx(
          (state) => Obx(() => Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              height: 150,
              decoration: customDecoration(radius: 10, shadowBlur: 1),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textView15(context: context, text: "order_placed".tr, fontWeight: FontWeight.w700),
                      textView15(context: context, text: "est_delivery".tr, fontWeight: FontWeight.w700)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textView13(
                          context: context,
                          text: DateFormate.isoStringToLocalDay(
                              Get.find<TrackingOrderViewController>().getTrackingModel.createdAt.toString()),
                          fontWeight: FontWeight.w700),
                      textView13(context: context, text: "", fontWeight: FontWeight.w700)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 22),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 47, right: 47),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                thickness: 5,
                                color: Get.find<TrackingOrderViewController>().getTrackingModel.orderStatus ==
                                        AppConstants.OUT_FOR_DELIVERY
                                    ? ColorResource.primaryColor
                                    : ColorResource.primaryColor02,
                              )),
                              const Expanded(
                                  child: Divider(
                                thickness: 5,
                                color: ColorResource.primaryColor02,
                              )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 30,
                                color: Get.find<TrackingOrderViewController>().getTrackingModel.orderStatus !=
                                        AppConstants.PENDING
                                    ? ColorResource.primaryColor
                                    : ColorResource.primaryColor02,
                              ),
                              Icon(
                                Icons.local_shipping,
                                size: 30,
                                color: Get.find<TrackingOrderViewController>().getTrackingModel.orderStatus ==
                                        AppConstants.OUT_FOR_DELIVERY
                                    ? Colors.green.shade700
                                    : Colors.green.shade100,
                              ),
                              Icon(
                                Icons.check_circle,
                                size: 30,
                                color: Get.find<TrackingOrderViewController>().getTrackingModel.orderStatus ==
                                        AppConstants.DELIVERED
                                    ? ColorResource.primaryColor
                                    : ColorResource.primaryColor02,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textView15(
                          context: context,
                          text: "packaging".tr,
                          fontWeight: FontWeight.w700,
                          color: Get.find<TrackingOrderViewController>().getTrackingModel.orderStatus !=
                                  AppConstants.PENDING
                              ? ColorResource.darkTextColor
                              : ColorResource.primaryColor02),
                      textView15(
                          context: context,
                          text: "in_transit".tr,
                          fontWeight: FontWeight.w700,
                          color: Get.find<TrackingOrderViewController>().getTrackingModel.orderStatus ==
                                  AppConstants.OUT_FOR_DELIVERY
                              ? ColorResource.darkTextColor
                              : ColorResource.primaryColor02),
                      textView15(
                          context: context,
                          text: "drop_off".tr,
                          fontWeight: FontWeight.w700,
                          color: ColorResource.primaryColor02)
                    ],
                  ),
                ],
              ))),
          onError: (s) =>
              onErrorReloadButton(context, s.toString(), height: MediaQuery.of(context).size.height, onTap: () {
                initData();
              }),
          onEmpty: SizedBox(height: MediaQuery.of(context).size.height, child: notFound(context, 'empty_tracking'.tr))),
    );
  }
}
