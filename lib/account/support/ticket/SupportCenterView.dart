import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/account/support/support_ticket_controller.dart';
import 'package:myphsar/account/support/ticket/SubmitTicketView.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_bottom_sheet_dialog.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';

import '../../../base_colors.dart';
import '../../../base_widget/custom_decoration.dart';
import '../../../base_widget/custom_icon_button.dart';
import '../../../base_widget/myphsar_text_view.dart';
import '../../../base_widget/not_found.dart';
import '../../../base_widget/reload_button.dart';
import '../../../home/all_product/shimmer_placeholder_view.dart';
import '../../account_view.dart';
import '../chat/support_chat_view.dart';

class SupportCenterView extends StatefulWidget {
  const SupportCenterView({super.key});

  @override
  State<SupportCenterView> createState() => _SupportCenterViewState();
}

class _SupportCenterViewState extends State<SupportCenterView> {
  ItemSetting website = ItemSetting(name: "website_problem".tr, image: "assets/images/web_ic.png");
  ItemSetting partner = ItemSetting(name: "partner_request".tr, image: "assets/images/partner_ic.png");
  ItemSetting complaint = ItemSetting(name: "complaint".tr, image: "assets/images/note_ic.png");
  ItemSetting info = ItemSetting(
    name: "info_inquiry".tr,
    image: "assets/images/info_inquiry_ic.png",
  );

  @override
  void initState() {
    getAllTicket();
    super.initState();
  }

  void getAllTicket() async {
    Get.find<SupportTicketController>().getSupportTicketList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(context: context, titleText: 'support_ticket'.tr),
      body: Get.find<SupportTicketController>().obx(
          (state) => Obx(
                () => ListView.builder(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    itemCount: Get.find<SupportTicketController>().getSupportTicketModel.length,
                    itemBuilder: (BuildContext context, int index) {
                      var icon = '';
                      switch (Get.find<SupportTicketController>().getSupportTicketModel[index].type) {
                        case "Website Problem":
                          icon = website.image!;
                          break;
                        case "Partner Request":
                          icon = partner.image!;
                          break;
                        case "Complaint":
                          icon = complaint.image!;
                          break;
                        case "Info Inquiry":
                          icon = info.image!;
                          break;
                      }

                      return Container(
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        decoration: customDecoration(
                          radius: 10,
                          shadowBlur: 3,
                        ),
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Get.to(SupportChatView(
                                  Get.find<SupportTicketController>().getSupportTicketModel[index], icon));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    customImageButton(
                                        color: ColorResource.lightHintTextColor,
                                        blur: 0,
                                        height: 40,
                                        width: 40,
                                        icon: Image.asset(
                                          icon,
                                          width: 18,
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: textView15(
                                          context: context,
                                          text: Get.find<SupportTicketController>().getSupportTicketModel[index].type!,
                                          maxLine: 1,
                                          color: ColorResource.darkTextColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    customTextButton(
                                        height: 25,
                                        blur: 0,
                                        padding: 5,
                                        color: ColorResource.lightHintTextColor,
                                        radius: 5,
                                        onTap: () {},
                                        text: textView12(
                                            context: context, text: "PENDING", color: ColorResource.secondaryColor)),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: textView15(
                                      context: context,
                                      text: '${'subject'.tr}: ${Get.find<SupportTicketController>()
                                              .getSupportTicketModel[index]
                                              .subject}',
                                      maxLine: 1,
                                      color: ColorResource.lightTextColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: textView15(
                                      context: context,
                                      text: 'date'.tr +
                                          Get.find<SupportTicketController>()
                                              .getSupportTicketModel[index]
                                              .createdAt
                                              .toString(),
                                      maxLine: 1,
                                      fontWeight: FontWeight.w500,
                                      color: ColorResource.lightTextColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
          onLoading: supportTicketShimmerView(context),
          onError: (s) =>
              onErrorReloadButton(context, s.toString(), height: MediaQuery.of(context).size.height, onTap: () {}),
          onEmpty: SizedBox(height: MediaQuery.of(context).size.height, child: notFound(context, 'empty_support'.tr))),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: customTextButton(
              blur: 0,
              height: 50,
              radius: 5,
              color: ColorResource.primaryColor,
              onTap: () {
                customBottomSheetDialog(context: context, child: optionDialog(context), height: 250);
              },
              text: Center(
                child: textView15(
                    context: context,
                    text: "support_ticket".tr,
                    maxLine: 1,
                    color: ColorResource.whiteColor,
                    textAlign: TextAlign.center),
              ))),
    );
  }

  Widget optionDialog(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: customImageButton(
                onTap: () {
                  Navigator.pop(context);
                },
                padding: 5,
                height: 35,
                width: 35,
                icon: const Icon(
                  Icons.clear,
                  size: 20,
                ))),
        Column(
          children: [
            Align(
                alignment: Alignment.center,
                child: textView20(
                    context: context, text: 'select_your_category'.tr, color: ColorResource.darkTextColor)),
            const SizedBox(
              height: 30,
            ),
            // MasonryGridView.count(
            //     itemCount: widgetList.length,
            //     crossAxisCount: 2,
            //     padding: EdgeInsets.only(bottom: 5),
            //     physics: NeverScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     itemBuilder: (BuildContext context, int index) {
            //       return InkWell(
            //         onTap: () {
            //           Get.to(
            //           SubmitTicketView(ticketStatus: widgetList[index].name.toString(), icon:  widgetList[index].image.toString())
            //           );
            //         },
            //         child: Expanded(
            //             child: CustomIconTextButton(
            //               blur: 0,
            //               color: ColorResource.lightHintTextColor,
            //               iconAlign: CustomIconAlign.left,
            //                 height: 50,
            //                 text: TextViewSize_13(context: context, text: widgetList[index].name.toString(), maxLine: 1,color: ColorResource.darkTextColor),
            //                 icon: Image.asset(
            //                   widgetList[index].image.toString(),
            //                   width: 18,
            //                 )),
            //           ),
            //       );
            //     }),
            Row(
              children: [
                Expanded(
                  child: customImageTextButton(
                      leftPadding: 20,
                      onTap: () {
                        Navigator.pop(context);
                        Get.to(SubmitTicketView(ticketType: website.name.toString(), icon: website.image.toString()));
                      },
                      blur: 0,
                      color: ColorResource.lightHintTextColor,
                      iconAlign: CustomIconAlign.left,
                      height: 50,
                      text: textView13(
                          context: context,
                          text: website.name.toString(),
                          maxLine: 1,
                          color: ColorResource.darkTextColor),
                      icon: Image.asset(
                        "assets/images/web_ic.png",
                        width: 18,
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: customImageTextButton(
                      leftPadding: 20,
                      onTap: () {
                        Navigator.pop(context);
                        Get.to(SubmitTicketView(ticketType: partner.name.toString(), icon: partner.image.toString()));
                      },
                      blur: 0,
                      color: ColorResource.lightHintTextColor,
                      iconAlign: CustomIconAlign.left,
                      height: 50,
                      text: textView13(
                          context: context,
                          text: partner.name.toString(),
                          maxLine: 1,
                          color: ColorResource.darkTextColor),
                      icon: Image.asset(
                        partner.image.toString(),
                        width: 18,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: customImageTextButton(
                      leftPadding: 20,
                      onTap: () {
                        Navigator.pop(context);
                        Get.to(
                            SubmitTicketView(ticketType: complaint.name.toString(), icon: complaint.image.toString()));
                      },
                      blur: 0,
                      color: ColorResource.lightHintTextColor,
                      iconAlign: CustomIconAlign.left,
                      height: 50,
                      text: textView13(
                          context: context,
                          text: complaint.name.toString(),
                          maxLine: 1,
                          color: ColorResource.darkTextColor),
                      icon: Image.asset(
                        complaint.image.toString(),
                        width: 18,
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: customImageTextButton(
                      leftPadding: 20,
                      onTap: () {
                        Navigator.pop(context);
                        Get.to(SubmitTicketView(ticketType: info.name.toString(), icon: info.image.toString()));
                      },
                      blur: 0,
                      color: ColorResource.lightHintTextColor,
                      iconAlign: CustomIconAlign.left,
                      height: 50,
                      text: textView13(
                          context: context, text: info.name.toString(), maxLine: 1, color: ColorResource.darkTextColor),
                      icon: Image.asset(
                        info.image.toString(),
                        width: 18,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        )
      ],
    );
  }
}
