import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_decoration.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/base_widget/loader_view.dart';
import 'package:myphsar/installment/checkout/installments_check_out_view.dart';

import '../../base_widget/custom_icon_button.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../../utils/price_converter.dart';
import '../installment_view_controller.dart';
import 'payment_table_model.dart';

class PaymentTableView extends StatefulWidget {
  final String uuid;
  final String lenderId;

  const PaymentTableView(this.uuid, this.lenderId, {super.key});

  @override
  State<PaymentTableView> createState() => _PaymentTableViewState();
}

class _PaymentTableViewState extends State<PaymentTableView> {
  var paymentTable = PaymentTable();

  DataRow _getDataRow(MfpsTable model) {
    return DataRow(
      cells: <DataCell>[
        DataCell(textView13(text: model.period.toString(), context: context)),
        DataCell(textView13(text: model.principal.toString(), context: context)),
        DataCell(textView13(text: model.interestRate.toString(), context: context)),
        DataCell(textView13(text: model.amountToBePaid.toString(), context: context)),
        DataCell(textView13(text: model.balance.toString(), context: context)),
      ],
    );
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    await Get.find<InstallmentViewController>().submitSelectedLender(widget.uuid, widget.lenderId);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(context: context, titleText: "pay_table".tr),
      body: Obx(
        () => Get.find<InstallmentViewController>().getPaymentTableModel.data != null
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textView15(
                          height: 1.5,
                          context: context,
                          text: PriceConverter.currencySignAlignment(double.parse(Get.find<InstallmentViewController>()
                              .getPaymentTableModel
                              .data!
                              .paymentTable!
                              .totalInstallment
                              .toString())),
                          color: ColorResource.primaryColor,
                          fontWeight: FontWeight.w600),
                      textView15(
                          height: 1.5, context: context, text: "total_installment".tr, fontWeight: FontWeight.w600),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textView15(
                          height: 1.5,
                          context: context,
                          text: Get.find<InstallmentViewController>()
                              .getPaymentTableModel
                              .data!
                              .paymentTable!
                              .totalInstallmentDuration
                              .toString(),
                          color: ColorResource.primaryColor,
                          fontWeight: FontWeight.w600),
                      textView15(
                          height: 1.5,
                          context: context,
                          text: "total_installment_duration".tr,
                          fontWeight: FontWeight.w600),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textView15(
                          height: 1.5,
                          context: context,
                          text:
                              "${(Get.find<InstallmentViewController>().getPaymentTableModel.data!.paymentTable!.sTotalInstallmentInterest!)} %",
                          color: ColorResource.primaryColor,
                          fontWeight: FontWeight.w600),
                      textView15(
                          height: 1.5, context: context, text: "total_interest_rate".tr, fontWeight: FontWeight.w600),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textView15(
                          height: 1.5,
                          context: context,
                          text: Get.find<InstallmentViewController>()
                              .getPaymentTableModel
                              .data!
                              .paymentTable!
                              .sTotalInstallmentFee
                              .toString(),
                          color: ColorResource.primaryColor,
                          fontWeight: FontWeight.w600),
                      textView15(
                          height: 1.5,
                          context: context,
                          text: "installments".tr + "fee".tr,
                          fontWeight: FontWeight.w600),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textView15(
                          height: 1.5,
                          context: context,
                          text:
                              '${Get.find<InstallmentViewController>().getPaymentTableModel.data!.paymentTable!.sTotalInstallmentDownPayment.toString()} %',
                          color: ColorResource.primaryColor,
                          fontWeight: FontWeight.w600),
                      textView15(height: 1.5, context: context, text: "down_payment".tr, fontWeight: FontWeight.w600),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textView15(
                          height: 1.5,
                          context: context,
                          text: PriceConverter.currencySignAlignment(double.parse(Get.find<InstallmentViewController>()
                              .getPaymentTableModel
                              .data!
                              .paymentTable!
                              .totalInstallmentMinusTotalInstallmentDownPayment
                              .toString())),
                          color: ColorResource.primaryColor,
                          fontWeight: FontWeight.w600),
                      textView15(
                          height: 1.5, context: context, text: "outstanding_balance".tr, fontWeight: FontWeight.w600),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: textView20(context: context, text: "monthly_schedule".tr, fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                              padding: const EdgeInsets.all(3),
                              width: MediaQuery.of(context).size.width,
                              child: DataTable(
                                horizontalMargin: 5,
                                decoration: customDecoration(
                                    radius: 5, shadowBlur: 2, shadowColor: ColorResource.lightShadowColor50),

                                dataRowColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                                  return Colors.white24;
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
                                    Get.find<InstallmentViewController>().getPaymentTableModel.data!.mfpsTable!.length,
                                    (index) => _getDataRow(Get.find<InstallmentViewController>()
                                        .getPaymentTableModel
                                        .data!
                                        .mfpsTable![index])),
                                columns: [
                                  DataColumn(
                                    label: textView14(text: "no".tr, context: context, fontWeight: FontWeight.w500),
                                  ),
                                  DataColumn(
                                    label:
                                        textView14(text: "principal".tr, context: context, fontWeight: FontWeight.w500),
                                  ),
                                  DataColumn(
                                    label:
                                        textView14(text: "interest".tr, context: context, fontWeight: FontWeight.w500),
                                  ),
                                  DataColumn(
                                      label:
                                          textView14(text: "amount".tr, context: context, fontWeight: FontWeight.w500)),
                                  DataColumn(
                                    label:
                                        textView14(text: "balance".tr, context: context, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )))),
                ]))
            : loaderFullScreenView(context, true),

        // onLoading: ProductShimmerView(context),
        // onEmpty: Container(height: 298, child: NotFound(context, ' Product Empty')),
        // onError: (s) =>
        //     OnErrorReloadButton(context, s.toString(), height: MediaQuery.of(context).size.height, onTap: () {
        //   initData();
        // }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: customTextButton(
          blur: 0,
          height: 50,
          radius: 5,
          color: ColorResource.primaryColor,
          onTap: () async {
            Get.to(InstallmentsCheckOutView(widget.uuid, widget.lenderId));
          },
          text: Center(
            child: textView15(
                height: 1.5,
                context: context,
                text: "next".tr,
                color: ColorResource.whiteColor,
                textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
