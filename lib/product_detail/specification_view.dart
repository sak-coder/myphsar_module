import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_decoration.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../product/product_model.dart';

class SpecificationView extends StatelessWidget {
  final String specification;
  final Products product;

  const SpecificationView(this.specification, this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(context: context, titleText: "specification".tr),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // // Variant color
            product.colors!.isNotEmpty
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      textView16(context: context, text: "color".tr, maxLine: 1),
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          itemCount: product.colors!.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            String colorString = '0xff${product.colors![index].code.toString().substring(1, 7)}';
                            return Row(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(right: 10, bottom: 10, top: 10),
                                    height: 30,
                                    width: 30,
                                    alignment: Alignment.center,
                                    decoration: customDecoration(
                                        color: Color(int.parse(colorString)),
                                        radius: 2,
                                        shadowColor: ColorResource.primaryColor05))
                              ],
                            );
                          },
                        ),
                      ),
                    ]),
                  )
                : const SizedBox.shrink(),
            product.choiceOptions != null
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: product.choiceOptions!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          textView16(context: context, text: product.choiceOptions![index].title!, maxLine: 1),
                          const SizedBox(height: 10),
                          GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: (1 / 0.4),
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: product.choiceOptions![index].options?.length,
                            itemBuilder: (context, i) {
                              return Container(
                                alignment: Alignment.center,
                                decoration: customDecoration(
                                    color: ColorResource.whiteColor,
                                    radius: 5,
                                    shadowBlur: 1,
                                    shadowColor: ColorResource.hintTextColor),
                                child: Text(
                                  product.choiceOptions![index].options![i].trim(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            },
                          ),
                        ]),
                      );
                    },
                  )
                : const SizedBox.shrink(),

            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: textView16(
                context: context,
                text: "desc".tr,
                maxLine: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Html(
                onLinkTap: (url, __, _) async {
                  _launchUrl(url!);
                },
                style: {
                  "body": Style(
                    backgroundColor: Colors.white,
                    fontSize: FontSize(18.0),
                    fontWeight: FontWeight.w600,
                  ),
                },
                data: specification,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      )),
    );
  }

  _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
