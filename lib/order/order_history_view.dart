import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/app_constants.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/base_widget/custom_scaffold_indicator.dart';
import 'package:myphsar/order/order_history_view_controller.dart';

import '../base_colors.dart';
import '../base_widget/badg_icon.dart';
import '../base_widget/custom_icon_button.dart';
import '../base_widget/myphsar_text_view.dart';
import '../base_widget/not_found.dart';
import '../base_widget/reload_button.dart';
import '../cart/cart_list/cart_list_view.dart';
import '../home/all_product/shimmer_placeholder_view.dart';
import '../home/home_controller.dart';
import 'order_history_item_view.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView>
    with TickerProviderStateMixin {
  var refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) => openOrderDetailOnPushNotification());

    //initData();
    super.initState();
  }

  Future<void> initData() async {
    if (Get.find<OrderHistoryViewController>().getOrderHistoryList.isEmpty) {
      await Get.find<OrderHistoryViewController>()
          .getAllOrderHistoryList(isReload: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> orderStatusTap = <Widget>[
      runningTap(),
      deliveredTap(),
      cancelTap()
    ];
    var tabController =
        TabController(vsync: this, length: orderStatusTap.length);
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1.5,
        shadowColor: const Color(0X40000000),
        bottom: TabBar(
          dividerColor: Colors.black12,
          controller: tabController,
          indicatorColor: ColorResource.primaryColor,
          padding: const EdgeInsets.all(0),
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Tab(
                child: textView15(
                    fontWeight: FontWeight.w700,
                    context: context,
                    text: 'running'.tr,
                    color: ColorResource.darkTextColor)),
            Tab(
                child: textView15(
                    fontWeight: FontWeight.w700,
                    context: context,
                    text: 'delivery'.tr,
                    color: ColorResource.darkTextColor)),
            Tab(
                child: textView15(
                    fontWeight: FontWeight.w700,
                    context: context,
                    text: 'canceled'.tr,
                    color: ColorResource.darkTextColor)),
          ],
        ),
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textView25(context: context, text: "orders".tr, color: ColorResource.secondaryColor),
              Obx(() => badgeIcon(
                  topP: -2,
                  endP: -2,
                  visibleBadge: Get.find<HomeController>().cartCount > 0 ? true : false,
                  context: context,
                  badgeText: Get.find<HomeController>().cartCount.toString(),
                  imageIcon: customImageButton(
                    padding: 11,
                    width: 45,
                    height: 45,
                    onTap: () async {
                      Get.to(const CartListView());
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
        ),
      ),
      body: DefaultTabController(
        length: orderStatusTap.length,
        child: TabBarView(
          controller: tabController,
          children: orderStatusTap,
        ),
      ),
    );
  }

  bool runningTapStatus(String s) {
    if (s == AppConstants.PENDING ||
        s == AppConstants.CONFIRMED ||
        s == AppConstants.PROCESSING ||
        s == AppConstants.OUT_FOR_DELIVERY) {
      return true;
    } else {
      return false;
    }
  }

  bool cancelTapStatus(String s) {
    if (s == AppConstants.RETURNED || s == AppConstants.FAILED || s == AppConstants.CANCELLED) {
      return true;
    } else {
      return false;
    }
  }

  Widget runningTap() {
    return CustomScaffoldRefreshIndicator(
      body: Get.find<OrderHistoryViewController>().obx(
          (state) => Stack(
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: Get.find<OrderHistoryViewController>()
                        .getOrderHistoryList
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      var orderHistory = Get.find<OrderHistoryViewController>()
                          .getOrderHistoryList[index];
                      if (runningTapStatus(orderHistory.orderStatus)) {
                        return OrderHistoryItemView(
                            orderHistory, Colors.orange);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  Get.find<OrderHistoryViewController>().getRunningStatus ==
                          true
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: notFound(context, 'empty_running'.tr))
                ],
              ),
          onLoading: wishlistShimmerView(context),
          onError: (s) => onErrorReloadButton(context, s.toString(),
                  height: MediaQuery.of(context).size.height, onTap: () async {
                await Get.find<OrderHistoryViewController>()
                    .getAllOrderHistoryList(isReload: true);
              }),
          onEmpty: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: notFound(context, 'empty_running'.tr))),
      onRefresh: () async {
        await Get.find<OrderHistoryViewController>()
            .getAllOrderHistoryList(isReload: true);
      },
    );
  }

  Widget deliveredTap() {
    return CustomScaffoldRefreshIndicator(
      body: Get.find<OrderHistoryViewController>().obx(
          (state) => Stack(
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: Get.find<OrderHistoryViewController>()
                        .getOrderHistoryList
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      var orderHistory = Get.find<OrderHistoryViewController>()
                          .getOrderHistoryList[index];
                      if (orderHistory.orderStatus == AppConstants.DELIVERED) {
                        return OrderHistoryItemView(orderHistory, Colors.green);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  Get.find<OrderHistoryViewController>()
                              .getDeliverOrderStatus ==
                          true
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: notFound(context, 'empty_deliver'.tr))
                ],
              ),
          onLoading: wishlistShimmerView(context),
          onError: (s) => onErrorReloadButton(context, s.toString(),
                  height: MediaQuery.of(context).size.height, onTap: () async {
                await Get.find<OrderHistoryViewController>()
                    .getAllOrderHistoryList(isReload: true);
              }),
          onEmpty: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: notFound(context, 'empty_deliver'.tr))),
      onRefresh: () async {
        await Get.find<OrderHistoryViewController>()
            .getAllOrderHistoryList(isReload: true);
      },
    );
  }

  Widget cancelTap() {
    return CustomScaffoldRefreshIndicator(
      body: Get.find<OrderHistoryViewController>().obx(
          (state) => Stack(
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: Get.find<OrderHistoryViewController>()
                        .getOrderHistoryList
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      var orderHistory = Get.find<OrderHistoryViewController>()
                          .getOrderHistoryList[index];
                      if (cancelTapStatus(orderHistory.orderStatus)) {
                        return OrderHistoryItemView(orderHistory, Colors.red);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  Get.find<OrderHistoryViewController>().getCancelOrderStatus ==
                          true
                      ? const SizedBox.shrink()
                      : SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: notFound(context, 'empty_failed'.tr))
                ],
              ),
          onLoading: wishlistShimmerView(context),
          onError: (s) => onErrorReloadButton(context, s.toString(),
                  height: MediaQuery.of(context).size.height, onTap: () async {
                await Get.find<OrderHistoryViewController>()
                    .getAllOrderHistoryList(isReload: true);
              }),
          onEmpty: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: notFound(context, 'empty_failed'.tr))),
      onRefresh: () async {
        await Get.find<OrderHistoryViewController>()
            .getAllOrderHistoryList(isReload: true);
      },
    );
  }
}
