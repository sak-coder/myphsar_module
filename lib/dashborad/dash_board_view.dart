import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/app_constants.dart';
import 'package:myphsar/base_widget/custom_bottom_sheet_dialog.dart';
import 'package:myphsar/category/category_view.dart';
import 'package:myphsar/chat/chat_controller.dart';
import 'package:myphsar/check_out/check_out_controller.dart';
import 'package:myphsar/configure/config_controller.dart';
import 'package:myphsar/dashborad/dash_board_controller.dart';
import 'package:myphsar/home/home_view.dart';
import 'package:myphsar/new_arrival/new_arrival_view.dart';
import 'package:myphsar/order/order_history_model.dart';
import 'package:myphsar/order/order_history_view_controller.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:url_launcher/url_launcher.dart';

import '../account/account_view.dart';
import '../account/installments_history/InstallmentsHistoryView.dart';
import '../auth/AuthController.dart';
import '../base_colors.dart';
import '../base_widget/alert_dialog_view.dart';
import '../base_widget/badg_icon.dart';
import '../base_widget/custom_icon_button.dart';
import '../base_widget/myphsar_text_view.dart';
import '../base_widget/sing_in_dialog_view.dart';
import '../cart/cart_controller.dart';
import '../helper/share_pref_controller.dart';
import '../notification/notification_view.dart';
import '../order/order_detail/order_detail_view.dart';
import '../order/order_history_view.dart';

class DashBoardView extends StatefulWidget {
  final String routeId;
  final GlobalKey<NavigatorState>? navigatorKey;

  const DashBoardView({super.key, this.routeId = "", this.navigatorKey});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  int pageIndex = 0;

  final PersistentTabController _pageController = PersistentTabController();

  @override
  void initState() {
    // setupRemoteConfig();
    initData();

    _pageController.addListener(() {
      if (pageIndex != 0 && pageIndex != 1 && pageIndex != 4) {
        if (!Get.find<AuthController>().isSignIn()) {
          _pageController.jumpToPreviousTab();
          signInDialogView(context);
        }
      }
    });

    // if (widget.routeId == "1") {
    //   notificationDetail();
    // }
    super.initState();
  }

  openUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  // Future setupRemoteConfig() async {
  //   final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  //   // If put #minimumFetchInterval to long it will wait until the duration done
  //   await remoteConfig.setConfigSettings(RemoteConfigSettings(
  //     fetchTimeout: const Duration(minutes: 1),
  //     minimumFetchInterval: const Duration(minutes: 10),
  //   ));
  //   await remoteConfig.fetchAndActivate();
  //
  //
  //   int versionCode = Get.find<ConfigController>().getAppVersionCode;
  //   bool forceUpdate = remoteConfig.getBool("force_update");
  //
  //   if (Platform.isAndroid) {
  //     if (versionCode < remoteConfig.getInt("minimum_android_version_code")) {
  //       updateDialog(forceUpdate, 'https://play.google.com/store/apps/details?id=com.myphsar');
  //     }
  //   } else if (Platform.isIOS) {
  //     if (versionCode < remoteConfig.getInt("minimum_IOS_version_code")) {
  //       updateDialog(forceUpdate, 'https://apps.apple.com/pl/app/myphsar/id1085651694');
  //     }
  //   }
  // }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void updateDialog(bool forceUpdate, url) {
    customConfirmAlertDialogWidgetView(
        dismissAble: forceUpdate == false,
        context: context,
        title: 'update_title_message'.tr,
        message: 'update_body_message'.tr,
        posText: 'update'.tr,
        navText: forceUpdate ? null : 'cancel'.tr,
        onPosClick: () {
          openUrl(url);
        });
  }

  void notificationDetail() {
    setState(() {
      pageIndex = 3;
    });
    _pageController.jumpToTab(3);
  }

  Future<void> getData() async {
    await Get.find<OrderHistoryViewController>()
        .getAllOrderHistoryList(isReload: true);
    Get.find<CartController>().getAllCartList();
    Get.find<ChatController>().getAllChat();

  }

  void initData() async {
    getData();
 //   Get.find<AuthController>().updateToken();
    Get.find<CheckOutController>()
        .orderSuccessListener
        .stream
        .listen((code) async {
      if (code == AppConstants.PAY_SUCCESS_CODE) {
        getData();
        customBottomSheetDialog(
            context: context,
            child: orderSuccessView(true),
            height: MediaQuery.of(context).size.height);
      } else if (code == AppConstants.INSTALLMENT_PAY_SUCCESS_CODE) {
        customBottomSheetDialog(
            context: context,
            child: orderSuccessView(true),
            height: MediaQuery.of(context).size.height);
      } else {
        customBottomSheetDialog(
            context: context,
            child: orderSuccessView(false),
            height: MediaQuery.of(context).size.height);
      }
    });
  }

  bool showUpButton = false;

  Widget orderSuccessView(bool successStatus, {bool isInstallment = false}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  successStatus == true
                      ? Icons.check_circle_outline_rounded
                      : Icons.cancel_outlined,
                  size: 100,
                  color: successStatus == true
                      ? ColorResource.greenColor
                      : ColorResource.primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: textView20(
                      fontWeight: FontWeight.w700,
                      context: context,
                      text: successStatus == true
                          ? "order_completed".tr
                          : "order_fail".tr),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: textView15(
                      color: ColorResource.lightTextColor,
                      context: context,
                      text: successStatus == true
                          ? "order_success_msg".tr
                          : "order_failed".tr),
                ),
                successStatus == true
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: textView15(
                            textAlign: TextAlign.center,
                            color: ColorResource.lightTextColor,
                            maxLine: 2,
                            context: context,
                            text: 'send_receipt_to'.tr +
                                Get.find<SharePrefController>()
                                    .getUserProfile()
                                    .email
                                    .toString()),
                      )
                    : const SizedBox.shrink(),
                successStatus == true
                    ? customTextButton(
                        onTap: () async {
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                          if (isInstallment) {
                            Get.to(() => const InstallmentsHistoryView());
                          } else {
                            pageIndex = 2;
                            _pageController.jumpToTab(2);
                          }
                        },
                        blur: 1,
                        text: Center(
                          child: textView16(
                            context: context,
                            text: 'my_order'.tr,
                            fontWeight: FontWeight.w700,
                            color: ColorResource.greenColor,
                          ),
                        ),
                        color: ColorResource.whiteColor,
                        radius: 10,
                        height: 50)
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 20,
                ),
                customTextButton(
                    onTap: () async {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    text: Center(
                      child: textView16(
                        context: context,
                        text: 'continue_shopping'.tr,
                        fontWeight: FontWeight.w600,
                        color: ColorResource.whiteColor,
                      ),
                    ),
                    color: ColorResource.greenColor,
                    radius: 10,
                    height: 50),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textView12(
                color: ColorResource.lightTextColor,
                maxLine: 2,
                context: context,
                text: 'support_text'.tr,
              ),
              customTextButton(
                  text: textView13(
                    color: ColorResource.greenColor,
                    fontWeight: FontWeight.w700,
                    maxLine: 2,
                    context: context,
                    text: 'contact'.tr,
                  ),
                  blur: 0,
                  radius: 1,
                  onTap: () async {
                    openTelegram("Myphsaronlinemarket");
                  })
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: _tabs(),
      resizeToAvoidBottomInset: true,
      onTabChanged: (index) {
        setState(() {
          pageIndex = index;
        });
      },
      screenTransitionAnimation: const ScreenTransitionAnimation(
        curve: Curves.ease,
        duration: Duration(milliseconds: 500),
      ),
      popAllScreensOnTapAnyTabs: false,
      backgroundColor: Colors.white,
      controller: _pageController,
      navBarBuilder: (navBarConfig) => Style4BottomNavBar(
        navBarDecoration: NavBarDecoration(
          padding: const EdgeInsets.only(left: 5, right: 5),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 0)),
          ],
        ),
        navBarConfig: navBarConfig,
      ),
    );
  }

  TextStyle getTextWeight(int currentIndex) {
    return TextStyle(
        fontWeight:
            pageIndex == currentIndex ? FontWeight.w900 : FontWeight.w400,
        fontSize: 11);
  }

  List<PersistentTabConfig> _tabs() => [
        PersistentTabConfig(
          screen: HomeView(
            globalContext: context,
          ),
          item: ItemConfig(
              icon: Image.asset(
                "assets/images/home_ic.png",
                fit: BoxFit.contain,
                height: 24,
                width: 24,
                color: ColorResource.primaryColor,
              ),
              inactiveIcon: Image.asset(
                fit: BoxFit.contain,
                height: 24,
                width: 24,
                "assets/images/home_ic.png",
                color: ColorResource.lightShadowColor,
              ),
              title: ('home'.tr),
              activeForegroundColor: ColorResource.primaryColor,
              inactiveForegroundColor: ColorResource.lightTextColor,
              textStyle: getTextWeight(0)),
          onSelectedTabPressWhenNoScreensPushed: () => {
            if (pageIndex != 0)
              {
                setState(() {
                  pageIndex = 0;
                }),
                _pageController.jumpToTab(0)
              }
            else
              {Get.find<DashBoardController>().listener.add(true)}
          },
        ),
        PersistentTabConfig(
          screen: CategoryView(
            globalContext: context,
            isSearchingMode: false,
          ),
          item: ItemConfig(
              icon: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Image.asset(
                  "assets/images/category_ic.png",
                  fit: BoxFit.contain,
                  height: 23,
                  width: 23,
                  color: ColorResource.primaryColor,
                ),
              ),
              inactiveIcon: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Image.asset(
                  fit: BoxFit.contain,
                  height: 23,
                  width: 23,
                  "assets/images/category_ic.png",
                  color: ColorResource.lightShadowColor,
                ),
              ),
              title: ('category'.tr),
              activeForegroundColor: ColorResource.primaryColor,
              inactiveForegroundColor: ColorResource.lightTextColor,
              textStyle: getTextWeight(1)),
        ),
        PersistentTabConfig(
          screen: const OrderHistoryView(),
          item: ItemConfig(
              icon: Obx(() => Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: badgeIcon(
                        visibleBadge:
                            Get.find<ChatController>().getUnRedChatCount > 0,
                        topP: -5,
                        endP: -10,
                        context: context,
                        badgeText: Get.find<ChatController>()
                            .getUnRedChatCount
                            .toString(),
                        imageIcon: Image.asset("assets/images/order_ic.png",
                            fit: BoxFit.contain,
                            height: 26,
                            width: 27,
                            color: ColorResource.primaryColor)),
                  )),
              title: ('order'.tr),
              inactiveIcon: Obx(() => Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: badgeIcon(
                        visibleBadge: Get.find<DashBoardController>()
                                .getPendingOrderCount >
                            0,
                        topP: -5,
                        endP: -10,
                        context: context,
                        badgeText: Get.find<DashBoardController>()
                            .getPendingOrderCount
                            .toString(),
                        imageIcon: Image.asset("assets/images/order_ic.png",
                            height: 26,
                            width: 27,
                            fit: BoxFit.contain,
                            color: ColorResource.lightShadowColor)),
                  )),
              activeForegroundColor: ColorResource.primaryColor,
              inactiveForegroundColor: ColorResource.lightTextColor,
              textStyle: getTextWeight(2)),
        ),
        PersistentTabConfig(
          screen: const NotificationView(),
          item: ItemConfig(
              icon: Obx(() => Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: badgeIcon(
                        visibleBadge:
                            Get.find<ChatController>().getUnRedChatCount > 0,
                        topP: -5,
                        endP: -5,
                        context: context,
                        badgeText: Get.find<ChatController>()
                            .getUnRedChatCount
                            .toString(),
                        imageIcon: Image.asset(
                            "assets/images/notification_ic.png",
                            fit: BoxFit.contain,
                            height: 34,
                            width: 23,
                            color: ColorResource.primaryColor)),
                  )),
              title: ('notification'.tr),
              inactiveIcon: Obx(() => Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: badgeIcon(
                        visibleBadge:
                            Get.find<ChatController>().getUnRedChatCount > 0,
                        topP: -5,
                        endP: -5,
                        context: context,
                        badgeText: Get.find<ChatController>()
                            .getUnRedChatCount
                            .toString(),
                        imageIcon: Image.asset(
                            "assets/images/notification_ic.png",
                            fit: BoxFit.contain,
                            height: 34,
                            width: 23,
                            color: ColorResource.lightShadowColor)),
                  )),
              activeForegroundColor: ColorResource.primaryColor,
              inactiveForegroundColor: ColorResource.lightTextColor,
              textStyle: getTextWeight(3)),
        ),
        PersistentTabConfig(
          screen: AccountView(globalContext: context),
          item: ItemConfig(
              icon: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Image.asset("assets/images/account.png",
                    fit: BoxFit.contain,
                    height: 19,
                    width: 19,
                    color: ColorResource.primaryColor),
              ),
              title: ("account".tr),
              inactiveIcon: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Image.asset(
                  fit: BoxFit.contain,
                  "assets/images/account.png",
                  color: ColorResource.lightShadowColor,
                  height: 19,
                  width: 19,
                ),
              ),
              activeForegroundColor: ColorResource.primaryColor,
              inactiveForegroundColor: ColorResource.lightTextColor,
              textStyle: getTextWeight(4)),
        ),
      ];
}

Future<void> openTelegram(String username) async {
  final appUrl = Uri.parse('tg://resolve?domain=$username'); // App deep link
  final webUrl = Uri.parse('https://t.me/$username'); // Web URL fallback

  try {
    // Try opening in Telegram app first
    if (await canLaunchUrl(appUrl)) {
      await launchUrl(appUrl);
    } else if (await canLaunchUrl(webUrl)) {
      // Fallback to web if app not installed
      await launchUrl(webUrl);
    }
  } catch (e) {
    return;
  }
}
