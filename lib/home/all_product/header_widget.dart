//import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/home/banner/banner_view_controller.dart';

import '../../base_widget/myphsar_text_view.dart';
import '../seller/all_seller_view.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            height: 338.0,
            child: Obx(() => Get.find<BannerViewController>().getMainBannerModel.bannerModelList != null
                ? Container()
                : Container()),
          ),
          Container(
            height: 338.0,
            decoration: const BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(begin: FractionalOffset.center, end: FractionalOffset.bottomCenter, colors: [
                  Color.fromRGBO(213, 212, 212, 0.0),
                  Colors.white,
                ], stops: [
                  0.3,
                  1
                ])),
          )
        ]),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: (270),
            // margin: EdgeInsets.only(top: (10 + MediaQuery.of(context).viewPadding.top)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: (() => {Get.to(const AllSellerView())}),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFFFCEBE7), borderRadius: BorderRadius.circular(10)),
                              height: 110,
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: textView20(
                                        context: context,
                                        text: "brand".tr,
                                      )),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Image.asset(
                                      "assets/images/brand_ic.png",
                                      width: 72,
                                      height: 61,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Container(
                            decoration:
                                BoxDecoration(color: const Color(0xFFFCEBE7), borderRadius: BorderRadius.circular(10)),
                            height: 110,
                            padding: const EdgeInsets.only(left: 10, top: 10, right: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: textView20(
                                      context: context,
                                      text: "top_seller".tr,
                                    )),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Image.asset(
                                    "assets/images/top_seller_ic.png",
                                    width: 70,
                                    height: 68,
                                  ),
                                )
                              ],
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            decoration:
                                BoxDecoration(color: const Color(0xFFFCEBE7), borderRadius: BorderRadius.circular(10)),
                            height: 110,
                            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5, right: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: textView20(
                                      context: context,
                                      text: "new_arrival".tr,
                                    )),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Image.asset(
                                    "assets/images/new_arrival_ic.png",
                                    width: 52,
                                    height: 60,
                                  ),
                                )
                              ],
                            ),
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Container(
                            decoration:
                                BoxDecoration(color: const Color(0xFFFCEBE7), borderRadius: BorderRadius.circular(10)),
                            height: 110,
                            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: textView20(
                                      context: context,
                                      text: "special".tr,
                                    )),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Image.asset(
                                    "assets/images/special_ic.png",
                                    width: 88,
                                    height: 60,
                                  ),
                                )
                              ],
                            ),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
