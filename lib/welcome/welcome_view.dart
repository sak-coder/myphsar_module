import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/dashborad/dash_board_view.dart';
import 'package:myphsar/helper/share_pref_controller.dart';

import '../base_widget/my_text_button.dart';
import '../base_widget/myphsar_text_view.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(_handleSelected);
    super.initState();
  }

  void _handleSelected() {
    setState(() {
      _controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _controller.index > 0
                      ? IconButton(
                          onPressed: () => {routBack(_controller)},
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: ColorResource.secondaryColor,
                          ))
                      : const SizedBox(
                          width: 0,
                        ),
                  TextButton(
                      onPressed: () => {
                            Get.find<SharePrefController>().setFirstTimeOpen(true),
                            Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 2000),
                                  pageBuilder: (context, anim1, anim2) => const DashBoardView(),
                                ))
                          },
                      child: textView20(context: context, text: 'skip'.tr))
                ],
              ),
            ),
            Expanded(
                child: DefaultTabController(
                    length: 3,
                    child:
                        TabBarView(controller: _controller, physics: const NeverScrollableScrollPhysics(), children: [
                      welcomeWidget('welcome_title_1'.tr, 'welcome_message_1'.tr, 'assets/images/welcome_one.png'),
                      welcomeWidget(
                        'welcome_title_2'.tr,
                        'welcome_message_2'.tr,
                        'assets/images/welcome_two.png',
                      ),
                      welcomeWidget('welcome_title_3'.tr, 'welcome_message_3'.tr, 'assets/images/welcome_three.png'),
                    ]))),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dotAnimation(_controller),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customTextButtonCustom(
                        context,
                        () => {
                          Get.find<SharePrefController>().setFirstTimeOpen(true),
                          routNext(_controller),
                        },
                        'next'.tr,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget welcomeWidget(final String title, final String body, final String image) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 90, left: 35, right: 35),
          child: Image.asset(
            image,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25, left: 5, right: 5),
          child: textView23(context: context, text: title, color: ColorResource.secondaryColor),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10, left: 35, right: 35),
            child: textView15(context: context, text: body,maxLine: 4,textAlign: TextAlign.center)),
      ],
    );
  }

  Widget dotAnimation(TabController controller) {
    return Row(
      children: [
        AnimatedContainer(
          width: _controller.index == 0 ? 30 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: _controller.index == 0 ? ColorResource.primaryColor : ColorResource.primaryColor05,
            borderRadius: BorderRadius.circular(100),
          ),
          // Define how long the animation should take.
          duration: const Duration(milliseconds: 700),
          // Provide an optional curve to make the animation feel smoother.
          curve: Curves.easeOutQuart,
        ),
        const SizedBox(
          width: 4,
        ),
        AnimatedContainer(
          // Use the properties stored in the State class.
          width: _controller.index == 1 ? 30 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: _controller.index == 1 ? ColorResource.primaryColor : ColorResource.primaryColor05,
            borderRadius: BorderRadius.circular(100),
          ),

          duration: const Duration(milliseconds: 700),

          curve: Curves.easeOutQuart,
        ),
        const SizedBox(
          width: 4,
        ),
        AnimatedContainer(
          // Use the properties stored in the State class.
          width: _controller.index == 2 ? 30 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: _controller.index == 2 ? ColorResource.primaryColor : ColorResource.primaryColor05,
            borderRadius: BorderRadius.circular(100),
          ),
          // Define how long the animation should take.
          duration: const Duration(milliseconds: 700),
          // Provide an optional curve to make the animation feel smoother.
          curve: Curves.easeOutQuart,
        ),
      ],
    );
  }

  void routNext(TabController controller) {
    if (controller.index == 0) {
      controller.animateTo(1);
    } else if (controller.index == 1) {
      controller.animateTo(2);
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 2000),
            pageBuilder: (context, anim1, anim2) => const DashBoardView(),
          ));
    }
  }

  void routBack(TabController controller) {
    if (controller.index == 2) {
      controller.animateTo(1);
    } else if (controller.index == 1) {
      controller.animateTo(0);
    }
  }
}
