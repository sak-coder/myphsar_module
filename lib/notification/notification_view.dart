import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/chat/chat_controller.dart';
import 'package:myphsar/notification/notification_controller.dart';
import 'package:myphsar/base_widget/custom_scaffold_indicator.dart';

import '../base_widget/badg_icon.dart';
import '../base_widget/custom_decoration.dart';
import '../base_widget/custom_icon_button.dart';
import '../base_widget/myphsar_text_view.dart';
import '../base_widget/not_found.dart';
import '../base_widget/reload_button.dart';
import '../cart/cart_list/cart_list_view.dart';
import '../chat/chat_view.dart';
import '../configure/config_controller.dart';
import '../home/all_product/shimmer_placeholder_view.dart';
import '../home/home_controller.dart';
import '../utils/date_format.dart';
import 'detail/notification_detail_view.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> with TickerProviderStateMixin {
  var refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData({bool clearData = false}) async {
    await Get.find<NotificationController>().getAllNotification(clearData);
    await Get.find<ChatController>().getAllChat();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> myTabs = <Widget>[
      notificationWidget(),
      const ChatView(),
    ];
    var tabController = TabController(vsync: this, length: myTabs.length);
    return CustomScaffoldRefreshIndicator(
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
                    fontWeight: FontWeight.w600, context: context, text: 'all'.tr, color: ColorResource.darkTextColor)),
            Obx(() => Tab(
                child: textView15(
                    fontWeight: FontWeight.w600,
                    context: context,
                    text:
                        '${'msg'.tr}(${Get.find<ChatController>().getAllChatModel.uniqueShops != null ? Get.find<ChatController>().getAllChatModel.uniqueShops!.length : "0"})',
                    color: ColorResource.darkTextColor))),
          ],
        ),
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textView25(context: context, text: "notification".tr, color: ColorResource.secondaryColor),
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
          length: myTabs.length,
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: myTabs,
                ),
              ),
            ],
          )),
      onRefresh: () async {
        initData();
      },
    );
  }

  Widget notificationWidget() {
    return Get.find<NotificationController>().obx(
        (state) => ListView.builder(
              padding: const EdgeInsets.only(top: 20),
              itemCount: Get.find<NotificationController>().getAllNotificationModel.length,
              itemBuilder: (BuildContext context, int index) {
                var notificationModel = Get.find<NotificationController>().getAllNotificationModel[index];
                return Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Material(
                        child: InkWell(
                          onTap: () {
                            Get.to(() => NotificationDetailView(notificationModel));
                          },
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 80,
                                height: 80,

                                child: ClipRRect(

                                    child: FadeInImage.assetNetwork(
                                      placeholder: "assets/images/placeholder_img.png",
                                      placeholderFit: BoxFit.fill,
                                      fadeInDuration: const Duration(seconds: 1),
                                      fit: BoxFit.cover,
                                      //  width: 80,height: 80,
                                      image:
                                          '${Get.find<ConfigController>().configModel.baseUrls?.baseNotificationImageUrl}/${notificationModel.image!}',
                                      imageErrorBuilder: (c, o, s) => Image.asset(
                                        "assets/images/placeholder_img.png",
                                        fit: BoxFit.contain,
                                      ),
                                    )),
                              ),
                              Expanded(
                                  flex: 6,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.only(top: 5),
                                    height: 90,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        textView15(
                                          context: context,
                                          text: notificationModel.title!,
                                          maxLine: 2,
                                          color: ColorResource.darkTextColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: textView12(maxLine: 1,
                                              context: context,
                                              text:  notificationModel.description!,
                                              color: ColorResource.lightTextColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: textView12(
                                              context: context,
                                              text: DateFormate.isoStringToLocalDayTime(notificationModel.createdAt!),
                                              color: ColorResource.lightTextColor,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 10, bottom: 10),
                      //   child: Divider(
                      //     height: 1,
                      //     color: ColorResource.lightShadowColor,
                      //   ),
                      // )
                    ],
                  ),
                );
              },
            ),
        onLoading: wishlistShimmerView(context),
        onError: (s) =>
            onErrorReloadButton(context, s.toString(), height: MediaQuery.of(context).size.height, onTap: () {
              initData(clearData: true);
            }),
        onEmpty: SizedBox(height: MediaQuery.of(context).size.height, child: notFound(context, 'empty_noti'.tr)));
  }
}
