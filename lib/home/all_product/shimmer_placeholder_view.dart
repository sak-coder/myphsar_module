import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../base_colors.dart';
import '../../base_widget/custom_decoration.dart';

Widget topSellerShimmerView(BuildContext context, {required Axis axis, double height = 270}) => Shimmer.fromColors(
      period: const Duration(seconds: 2),
      // baseColor: ColorResource.lightGrayColor,
      // highlightColor: ColorResource.lightShadowColor50,
      baseColor: ColorResource.lightGrayColor50,
      highlightColor: ColorResource.lightShadowColor50,
      enabled: true,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: ListView.builder(
          itemCount: 2,
          scrollDirection: axis,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  height: 200,
                  width: axis == Axis.vertical ? double.infinity : 200,
                  decoration: customDecoration(radius: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: customDecoration(radius: 10),
                        height: 20,
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        decoration: customDecoration(radius: 10),
                        height: 10,
                        width: MediaQuery.of(context).size.width / 2.5,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
Widget serviceShimmerView(BuildContext context) {
  return Shimmer.fromColors(
    period: const Duration(seconds: 2),
    baseColor: ColorResource.lightGrayColor50,
    highlightColor: ColorResource.lightShadowColor50,
    enabled: true,
    child: SizedBox(
      height: 150,
      width: double.infinity,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                height: 120,
                width: 120,
                decoration: customDecoration(radius: 10),
              ),

            ],
          );
        },
      ),
    ),
  );
}

Widget recommendShimmerView(BuildContext context) {
  return Shimmer.fromColors(
    period: const Duration(seconds: 2),
    baseColor: ColorResource.lightGrayColor50,
    highlightColor: ColorResource.lightShadowColor50,
    enabled: true,
    child: SizedBox(
      height: 298,
      width: double.infinity,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                height: 190,
                width: 150,
                decoration: customDecoration(radius: 10),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: customDecoration(radius: 10),
                      height: 20,
                      width: 150,
                      margin: const EdgeInsets.only(bottom: 5),
                    ),
                    Container(
                      decoration: customDecoration(radius: 10),
                      height: 20,
                      width: 100,
                      margin: const EdgeInsets.only(bottom: 5),
                    ),
                    SizedBox(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: customDecoration(radius: 10),
                            height: 15,
                            width: 100,
                          ),
                          Container(
                            decoration: customDecoration(radius: 10),
                            height: 15,
                            width: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

Widget dailyDealShimmerView(BuildContext context) {
  return Shimmer.fromColors(
    period: const Duration(seconds: 2),
    baseColor: ColorResource.lightGrayColor50,
    highlightColor: ColorResource.lightShadowColor50,
    enabled: true,
    child: SizedBox(
      height: 298,
      width: double.infinity,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                height: 190,
                width: 150,
                decoration: customDecoration(radius: 10),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: customDecoration(radius: 10),
                      height: 20,
                      width: 150,
                      margin: const EdgeInsets.only(bottom: 5),
                    ),
                    Container(
                      decoration: customDecoration(radius: 10),
                      height: 20,
                      width: 100,
                      margin: const EdgeInsets.only(bottom: 5),
                    ),
                    SizedBox(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: customDecoration(radius: 10),
                            height: 15,
                            width: 100,
                          ),
                          Container(
                            decoration: customDecoration(radius: 10),
                            height: 15,
                            width: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

Widget productShimmerView(BuildContext context) {
  return Shimmer.fromColors(

    period: const Duration(seconds: 2),
    baseColor: ColorResource.lightGrayColor50,
    highlightColor: ColorResource.lightShadowColor50,
    enabled: true,
    child: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(

            margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        height: 190,
                        decoration: customDecoration(radius: 10),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: customDecoration(radius: 10),
                              height: 20,
                              margin: const EdgeInsets.only(bottom: 5),
                            ),
                            Container(
                              decoration: customDecoration(radius: 10),
                              height: 20,
                              margin: const EdgeInsets.only(bottom: 5, right: 50),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: customDecoration(radius: 10),
                                    height: 15,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: customDecoration(radius: 10),
                                    height: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        height: 190,
                        decoration: customDecoration(radius: 10),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: customDecoration(radius: 10),
                              height: 20,
                              margin: const EdgeInsets.only(bottom: 5),
                            ),
                            Container(
                              decoration: customDecoration(radius: 10),
                              height: 20,
                              margin: const EdgeInsets.only(bottom: 5, right: 50),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: customDecoration(radius: 10),
                                    height: 15,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: customDecoration(radius: 10),
                                    height: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

Widget productDetailShimmerView(BuildContext context) {
  return Shimmer.fromColors(
      period: const Duration(seconds: 2),
      baseColor: ColorResource.lightGrayColor50,
      highlightColor: ColorResource.lightShadowColor50,
      enabled: true,
      child: Expanded(
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              width: 60,
              height: 60,
              decoration: customDecoration(radius: 50),
            ),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  height: 30,
                  decoration: customDecoration(radius: 20),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: 100,
                  height: 20,
                  decoration: customDecoration(radius: 20),
                ),
              ]),
            ),
          ],
        ),
      ));
}

Widget categoryShimmerView(BuildContext context) {
  return Shimmer.fromColors(
    period: const Duration(seconds: 2),
    baseColor: ColorResource.lightGrayColor,
    highlightColor: ColorResource.lightShadowColor50,
    enabled: true,
    child: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.only(top: 20, left: 5, right: 5),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        height: 100,
                        width: 100,
                        decoration: customDecoration(radius: 10),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: customDecoration(radius: 10),
                              height: 20,
                              width: 100,
                              margin: const EdgeInsets.only(bottom: 5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        height: 100,
                        width: 100,
                        decoration: customDecoration(radius: 10),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: customDecoration(radius: 10),
                              height: 20,
                              width: 100,
                              margin: const EdgeInsets.only(bottom: 5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        height: 100,
                        width: 100,
                        decoration: customDecoration(radius: 10),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: customDecoration(radius: 10),
                              height: 20,
                              width: 100,
                              margin: const EdgeInsets.only(bottom: 5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

Widget shopNameShimmerView(BuildContext context) {
  return Shimmer.fromColors(
      period: const Duration(seconds: 2),
      baseColor: ColorResource.lightGrayColor50,
      highlightColor: ColorResource.lightShadowColor50,
      enabled: true,
      child: Row(children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          width: 60,
          height: 60,
          decoration: customDecoration(radius: 100),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          height: 20,
          width: 150,
          decoration: customDecoration(radius: 100),
        )
      ]));
}
Widget catListShimmerView(BuildContext context) {
  return Shimmer.fromColors(
      period: const Duration(seconds: 2),
      baseColor: ColorResource.lightGrayColor50,
      highlightColor: ColorResource.lightShadowColor50,
      enabled: true,
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 20),
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(top: 10, left: 20),
              height: 30,
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: customDecoration(radius: 100),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 20),
                        height: 20,
                        decoration: customDecoration(radius: 5),
                      ),

                    ],
                  ),
                ),
              ]),
            );
          }));
}
Widget chatShimmerView(BuildContext context) {
  return Shimmer.fromColors(
      period: const Duration(seconds: 2),
      baseColor: ColorResource.lightGrayColor50,
      highlightColor: ColorResource.lightShadowColor50,
      enabled: true,
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 20),
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(top: 10, left: 20),
              height: 100,
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: customDecoration(radius: 100),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 20),
                        height: 20,
                        decoration: customDecoration(radius: 5),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 50),
                        height: 20,
                        decoration: customDecoration(radius: 5),
                      ),
                    ],
                  ),
                ),
              ]),
            );
          }));
}

Widget wishlistShimmerView(BuildContext context) {
  return Shimmer.fromColors(
      period: const Duration(seconds: 2),
      baseColor: ColorResource.lightGrayColor50,
      highlightColor: ColorResource.lightShadowColor50,
      enabled: true,
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 20),
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(top: 10, left: 20),
              height: 100,
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: 100,
                  height: 100,
                  decoration: customDecoration(radius: 10),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        height: 20,
                        decoration: customDecoration(radius: 5),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        height: 20,
                        decoration: customDecoration(radius: 5),
                      ),
                    ],
                  ),
                ),
              ]),
            );
          }));
}

Widget shopShimmerView(BuildContext context) {
  return Shimmer.fromColors(
      baseColor: ColorResource.lightGrayColor50,
      highlightColor: ColorResource.lightShadowColor50,
      enabled: true,
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(top: 10, left: 20),
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, bottom: 5, top: 10),
                        height: 80,
                        width: 80,
                        decoration: customDecoration(radius: 5),
                      ),
                      Expanded(
                        flex: 10,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10, bottom: 5, right: 20),
                              height: 25,
                              decoration: customDecoration(radius: 5),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10, bottom: 5, right: 20),
                              height: 15,
                              decoration: customDecoration(radius: 5),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10, bottom: 5, right: 20),
                              height: 15,
                              decoration: customDecoration(radius: 5),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            );
          }));
}

Widget supportTicketShimmerView(BuildContext context) {
  return Shimmer.fromColors(
      baseColor: ColorResource.lightGrayColor50,
      highlightColor: ColorResource.lightShadowColor50,
      enabled: true,
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(top: 10, left: 20),
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, bottom: 5, top: 10),
                        height: 30,
                        width: 30,
                        decoration: customDecoration(radius: 5),
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, bottom: 5),
                          height: 20,
                          decoration: customDecoration(radius: 5),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, bottom: 5, right: 20),
                        height: 20,
                        width: 60,
                        decoration: customDecoration(radius: 5),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 50, bottom: 5, top: 0),
                    height: 20,
                    width: 200,
                    decoration: customDecoration(radius: 5),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 50),
                    height: 20,
                    width: 150,
                    decoration: customDecoration(radius: 5),
                  ),
                ],
              ),
            );
          }));
}

Widget offerShimmerView(BuildContext context) {
  return Shimmer.fromColors(
      baseColor: ColorResource.lightGrayColor,
      highlightColor: ColorResource.whiteColor,
      enabled: true,
      child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 160,
              decoration: customDecoration(radius: 10),
            );
          }));
}
