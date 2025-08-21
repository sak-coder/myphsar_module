import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/account/installments_history_detail/InstHistoryDetailViewController.dart';
import 'package:myphsar/base_widget/custom_decoration.dart';
import 'package:myphsar/base_widget/custom_icon_button.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';

import '../../base_widget/custom_appbar_view.dart';
import '../../base_widget/not_found.dart';
import '../../base_widget/reload_button.dart';
import 'InstallmentHistoryDetailModel.dart';

class InstallmentHistoryDetailView extends StatefulWidget {
  final String uuid;
  final Color color;
  final Color textColor;

  const InstallmentHistoryDetailView(
      {super.key, required this.uuid, required this.color, this.textColor = Colors.white});

  @override
  State<InstallmentHistoryDetailView> createState() => _InstallmentHistoryDetailViewState();
}

class _InstallmentHistoryDetailViewState extends State<InstallmentHistoryDetailView> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    Get.find<InstHistoryDetailViewController>().getInstallmentsHistoryDetail(widget.uuid);
  }

  DataRow _getDataRow(MfpsTable model) {
    return DataRow(
      cells: <DataCell>[
        DataCell(textView13(text: model.period.toString(), context: context, fontWeight: FontWeight.w500)),
        DataCell(textView13(text: model.principal.toString(), context: context, fontWeight: FontWeight.w500)),
        DataCell(textView13(text: model.interestRate.toString(), context: context, fontWeight: FontWeight.w500)),
        DataCell(textView13(text: model.amountToBePaid.toString(), context: context, fontWeight: FontWeight.w500)),
        DataCell(textView13(text: model.balance.toString(), context: context, fontWeight: FontWeight.w500)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: customAppBarView(context: context, titleText: "installment_detail".tr, elevation: 0),
        body: Get.find<InstHistoryDetailViewController>().obx(
            (state) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(1.5),
                          padding: const EdgeInsets.all(20),
                          decoration: customDecoration(radius: 20, shadowBlur: 2),
                          width: MediaQuery.of(context).size.width,
                          child: Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textView15(
                                      context: context,
                                      color: ColorResource.darkTextColor,
                                      text: "outstanding_balance".tr),
                                  textView25(
                                      context: context,
                                      color: ColorResource.secondaryColor,
                                      text:
                                          "${Get.find<InstHistoryDetailViewController>().getInstallmentHistoryDetail.mfpsTotalAmountToBePaid.toString()} "),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  textView15(
                                      context: context,
                                      color: ColorResource.darkTextColor,
                                      text: "installment_term".tr),
                                  textView20(
                                      context: context,
                                      color: ColorResource.secondaryColor,
                                      text:
                                          "${Get.find<InstHistoryDetailViewController>().getInstallmentHistoryDetail.installDuration.toString()} "),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 1.5, right: 1.5, bottom: 1.5, top: 10),
                          padding: const EdgeInsets.all(20),
                          decoration:
                              customDecoration(radius: 10, shadowBlur: 0, color: ColorResource.lightHintTextColor),
                          width: MediaQuery.of(context).size.width,
                          child: Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customImageTextButton(
                                    color: ColorResource.lightHintTextColor,
                                    blur: 0,
                                    height: 40,
                                    icon: Image.asset("assets/images/shop_ic.png"),
                                    text: textView15(
                                        context: context,
                                        color: ColorResource.darkTextColor,
                                        text: Get.find<InstHistoryDetailViewController>()
                                            .getInstallmentHistoryDetail
                                            .product!
                                            .shop!
                                            .fullName
                                            .toString()),
                                  ),
                                  customImageTextButton(
                                    color: ColorResource.lightHintTextColor,
                                    blur: 0,
                                    height: 40,
                                    icon: Image.asset("assets/images/phone_ic.png"),
                                    text: textView15(
                                        context: context,
                                        color: ColorResource.darkTextColor,
                                        text: Get.find<InstHistoryDetailViewController>()
                                            .getInstallmentHistoryDetail
                                            .product!
                                            .shop!
                                            .phone
                                            .toString()),
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: FadeInImage.assetNetwork(
                                            placeholder: "assets/images/placeholder_img.png",
                                            placeholderFit: BoxFit.fitHeight,
                                            fadeInDuration: const Duration(seconds: 1),
                                            fit: BoxFit.fitHeight,
                                            height: 80,
                                            image: Get.find<InstHistoryDetailViewController>()
                                                .getInstallmentHistoryDetail
                                                .product!
                                                .thumbnail
                                                .toString(),
                                            imageErrorBuilder: (c, o, s) => Image.asset(
                                              "assets/images/placeholder_img.png",
                                              fit: BoxFit.fitHeight,
                                              height: 80,
                                            ),
                                          )),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: textView15(
                                              context: context,
                                              color: ColorResource.secondaryColor,
                                              text:
                                                  "${Get.find<InstHistoryDetailViewController>().getInstallmentHistoryDetail.product?.name.toString()} ",
                                              maxLine: 4),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5),
                          child: textView20(context: context, text: "installment_info".tr),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textView15(
                                context: context,
                                text: "full_name".tr,
                                height: 1.5,
                                color: ColorResource.hintTextColor),
                            textView15(
                                context: context,
                                text: Get.find<InstHistoryDetailViewController>()
                                    .getInstallmentHistoryDetail
                                    .fullName
                                    .toString(),
                                height: 1.5),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textView15(
                                context: context, text: "email".tr, height: 1.5, color: ColorResource.hintTextColor),
                            textView15(
                                context: context,
                                text: Get.find<InstHistoryDetailViewController>()
                                    .getInstallmentHistoryDetail
                                    .email
                                    .toString(),
                                height: 1.5),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textView15(
                                context: context, text: "age".tr, height: 1.5, color: ColorResource.hintTextColor),
                            textView15(
                                context: context,
                                text: Get.find<InstHistoryDetailViewController>()
                                    .getInstallmentHistoryDetail
                                    .age
                                    .toString(),
                                height: 1.5),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textView15(
                                context: context,
                                text: "phone_number".tr,
                                height: 1.5,
                                color: ColorResource.hintTextColor),
                            textView15(
                                context: context,
                                text: Get.find<InstHistoryDetailViewController>()
                                    .getInstallmentHistoryDetail
                                    .phone
                                    .toString(),
                                height: 1.5),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: textView15(
                                    context: context,
                                    text: "permanent_address".tr,
                                    height: 1.5,
                                    color: ColorResource.hintTextColor)),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: textView15(
                                    context: context,
                                    text: Get.find<InstHistoryDetailViewController>()
                                        .getInstallmentHistoryDetail
                                        .currentAddress
                                        .toString(),
                                    height: 1.5,
                                    maxLine: 3),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textView15(
                                context: context,
                                text: "job_position".tr,
                                height: 1.5,
                                color: ColorResource.hintTextColor),
                            textView15(
                                context: context,
                                text: Get.find<InstHistoryDetailViewController>()
                                    .getInstallmentHistoryDetail
                                    .jobPosition
                                    .toString(),
                                height: 1.5),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textView15(
                                context: context, text: "salary".tr, height: 1.5, color: ColorResource.hintTextColor),
                            textView15(
                                context: context,
                                text:
                                    "\$ ${Get.find<InstHistoryDetailViewController>().getInstallmentHistoryDetail.salary.toString()}",
                                height: 1.5),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textView15(
                                context: context,
                                text: "province_city".tr,
                                height: 1.5,
                                color: ColorResource.hintTextColor),
                            textView15(
                                context: context,
                                text: Get.find<InstHistoryDetailViewController>()
                                    .getInstallmentHistoryDetail
                                    .city
                                    .toString(),
                                height: 1.5),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textView15(
                                context: context,
                                text: "occupation".tr,
                                height: 1.5,
                                color: ColorResource.hintTextColor),
                            textView15(
                                context: context,
                                text: Get.find<InstHistoryDetailViewController>()
                                    .getInstallmentHistoryDetail
                                    .jobType
                                    .toString(),
                                height: 1.5),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5),
                          child: textView20(context: context, text: "id_info".tr),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textView15(
                                context: context, text: "id_num".tr, height: 1.5, color: ColorResource.hintTextColor),
                            textView15(
                                context: context,
                                text: Get.find<InstHistoryDetailViewController>()
                                    .getInstallmentHistoryDetail
                                    .cardNumber
                                    .toString(),
                                height: 1.5),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textView15(
                                context: context, text: "dob".tr, height: 1.5, color: ColorResource.hintTextColor),
                            textView15(
                                context: context,
                                text: Get.find<InstHistoryDetailViewController>()
                                    .getInstallmentHistoryDetail
                                    .dob
                                    .toString(),
                                height: 1.5),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textView15(
                                context: context, text: "home_num".tr, height: 1.5, color: ColorResource.hintTextColor),
                            textView15(
                                context: context,
                                text: Get.find<InstHistoryDetailViewController>()
                                    .getInstallmentHistoryDetail
                                    .permanentHomeNumber
                                    .toString(),
                                height: 1.5),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textView15(
                                context: context,
                                text: "street_num".tr,
                                height: 1.5,
                                color: ColorResource.hintTextColor),
                            textView15(
                                context: context,
                                text: Get.find<InstHistoryDetailViewController>()
                                    .getInstallmentHistoryDetail
                                    .permanentStreetNumber
                                    .toString(),
                                height: 1.5),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: textView15(
                                    context: context,
                                    text: "place_birth".tr,
                                    height: 1.5,
                                    color: ColorResource.hintTextColor)),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: textView15(
                                    context: context,
                                    text: Get.find<InstHistoryDetailViewController>()
                                        .getInstallmentHistoryDetail
                                        .permanentCurrentAddress
                                        .toString(),
                                    height: 1.5,
                                    maxLine: 3),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5),
                          child: textView20(context: context, text: "id_photo".tr),
                        ),
                        SizedBox(
                          height: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: "assets/images/placeholder_img.png",
                                      placeholderFit: BoxFit.contain,
                                      fadeInDuration: const Duration(seconds: 1),
                                      fit: BoxFit.contain,
                                      image: Get.find<InstHistoryDetailViewController>()
                                          .getInstallmentHistoryDetail
                                          .cardImage
                                          .toString(),
                                      imageErrorBuilder: (c, o, s) => Image.asset(
                                        "assets/images/placeholder_img.png",
                                        fit: BoxFit.contain,
                                      ),
                                    )),
                              ),
                              Expanded(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: "assets/images/placeholder_img.png",
                                      placeholderFit: BoxFit.contain,
                                      fadeInDuration: const Duration(seconds: 1),
                                      fit: BoxFit.contain,
                                      image: Get.find<InstHistoryDetailViewController>()
                                          .getInstallmentHistoryDetail
                                          .cardImageBack
                                          .toString(),
                                      imageErrorBuilder: (c, o, s) => Image.asset(
                                        "assets/images/placeholder_img.png",
                                        fit: BoxFit.contain,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5, top: 15),
                          child: textView20(context: context, text: "monthly_schedule".tr),
                        ),
                        Container(
                            padding: const EdgeInsets.all(1.5),
                            width: MediaQuery.of(context).size.width,
                            child: DataTable(
                              horizontalMargin: 2,
                              decoration: customDecoration(
                                  radius: 5, shadowBlur: 2, shadowColor: ColorResource.lightShadowColor50),
                              dataRowMaxHeight: 30,
                              dataRowColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                                return Colors.white;
                              }),
                              showBottomBorder: false,
                              columnSpacing: 1,
                              headingRowHeight: 40,
                              headingTextStyle: const TextStyle(color: Colors.white),
                              headingRowColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                                return ColorResource.lightHintTextColor;
                              }),
                              // border: TableBorder.all(color: ColorResource.lightHintTextColor, width: 0.5),

                              rows: List.generate(
                                  Get.find<InstHistoryDetailViewController>()
                                      .getInstallmentHistoryDetail
                                      .mfpsTable!
                                      .length,
                                  (index) => _getDataRow(Get.find<InstHistoryDetailViewController>()
                                      .getInstallmentHistoryDetail
                                      .mfpsTable![index])),
                              columns: [
                                DataColumn(
                                  label: textView13(text: "num".tr, context: context, fontWeight: FontWeight.w500),
                                ),
                                DataColumn(
                                  label: textView13(
                                      text: "principal".tr, context: context, fontWeight: FontWeight.w500),
                                ),
                                DataColumn(
                                  label: textView13(
                                      text: "interest".tr, context: context, fontWeight: FontWeight.w500),
                                ),
                                DataColumn(
                                    label: textView13(
                                        text: "amount".tr, context: context, fontWeight: FontWeight.w500)),
                                DataColumn(
                                  label: textView13(
                                      text: "balance".tr, context: context, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
            onError: (s) =>
                onErrorReloadButton(context, s.toString(), height: MediaQuery.of(context).size.height, onTap: () {
                  initData();
                }),
            onEmpty: SizedBox(height: 298, child: notFound(context, 'empty_product'.tr))));
  }
}
