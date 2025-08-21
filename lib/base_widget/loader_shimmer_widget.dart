import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../base_colors.dart';

class LoaderShimmerWidget extends StatelessWidget {
  const LoaderShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 100),
      child: Shimmer.fromColors(
        baseColor: ColorResource.lightHintTextColor,
        highlightColor: ColorResource.whiteColor,
        enabled: true,
        child: SizedBox(
          height: (270),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(color: const Color(0xFFFCEBE7), borderRadius: BorderRadius.circular(10)),
                          height: 110,
                          padding: const EdgeInsets.only(left: 10, top: 10),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(color: const Color(0xFFFCEBE7), borderRadius: BorderRadius.circular(10)),
                          height: 110,
                          padding: const EdgeInsets.only(left: 10, top: 10, right: 5),
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
                          decoration: BoxDecoration(color: const Color(0xFFFCEBE7), borderRadius: BorderRadius.circular(10)),
                          height: 110,
                          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5, right: 15),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(color: const Color(0xFFFCEBE7), borderRadius: BorderRadius.circular(10)),
                          height: 110,
                          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
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
    );
  }
}
