import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/account/support/support_ticket_controller.dart';
import 'package:myphsar/account/support/ticket/SupportTicketModel.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';

import '../../../base_colors.dart';
import '../../../base_widget/custom_decoration.dart';
import '../../../base_widget/custom_icon_button.dart';
import '../../../base_widget/input_text_field_custom.dart';
import '../../../base_widget/myphsar_text_view.dart';
import '../../../utils/date_format.dart';

class SupportChatView extends StatefulWidget {
  final SupportTicketModel supportTicketModel;
  final String icon;

  const SupportChatView(this.supportTicketModel, this.icon, {super.key});

  @override
  State<SupportChatView> createState() => _SupportChatViewState();
}

class _SupportChatViewState extends State<SupportChatView> {
  var formKey = GlobalKey<FormState>();
  var messageController = TextEditingController();
  var listController = ScrollController();
  int countTimer = 0;
  late Timer timer;

  @override
  void initState() {
    timerIntervalGetChat();
    getAllChatSupport();
    super.initState();
  }

  //:TODO Note* implement socket
  void timerIntervalGetChat() {
    timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      countTimer++;
      if (countTimer == 5) {
        timer.cancel();
      }
      getAllChatSupport();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void deactivate() {
    timer.cancel();
    super.deactivate();
  }

  void getAllChatSupport() async {
    Get.find<SupportTicketController>().getSupportReplyList(widget.supportTicketModel.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: customAppBarView(context: context, titleText: "chat_support".tr),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: customDecoration(
                radius: 10,
                shadowBlur: 3,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                            widget.icon,
                            width: 18,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: textView15(
                            context: context,
                            text: widget.supportTicketModel.type!,
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
                              context: context,
                              text: widget.supportTicketModel.status == 0 ? "Pending" : 'Done',
                              color: ColorResource.secondaryColor)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Wrap(direction: Axis.horizontal, children: [
                      textView15(
                          context: context,
                          text: '${'subject'.tr}:',
                          maxLine: 1,
                          fontWeight: FontWeight.w600,
                          color: ColorResource.lightTextColor),
                      textView15(
                          context: context,
                          text: widget.supportTicketModel.subject!,
                          maxLine: 1,
                          color: ColorResource.lightTextColor),
                    ]),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      textView15(
                          context: context,
                          text: 'message'.tr,
                          maxLine: 1,
                          fontWeight: FontWeight.w600,
                          color: ColorResource.lightTextColor),
                      Expanded(
                        flex: 1,
                        child: textView15(
                            context: context,
                            text: widget.supportTicketModel.description!,
                            maxLine: 10,
                            color: ColorResource.lightTextColor),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Wrap(direction: Axis.horizontal, children: [
                      textView15(
                          context: context,
                          text: 'date'.tr,
                          maxLine: 1,
                          fontWeight: FontWeight.w600,
                          color: ColorResource.lightTextColor),
                      textView15(
                          context: context,
                          text: '${widget.supportTicketModel.createdAt} |${'delivery'.tr}',
                          maxLine: 1,
                          color: ColorResource.lightTextColor),
                    ]),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                  controller: listController,
                  itemCount: Get.find<SupportTicketController>().getSupportReplyChatList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var supportReply = Get.find<SupportTicketController>().getSupportReplyChatList[index];
                    return Column(
                      crossAxisAlignment:
                          supportReply.adminMessage == null ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: textView13(
                              context: context,
                              text: DateFormate.isoStringToLocalDayTime(supportReply.createdAt!),
                              maxLine: 1,
                              color: ColorResource.lightTextColor,
                              fontWeight: FontWeight.w400),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: EdgeInsets.fromLTRB(supportReply.adminMessage == null ? 50 : 20, 2,
                              supportReply.adminMessage != null ? 50 : 20, 20),
                          decoration: customDecoration(
                            radius: 10,
                            shadowBlur: 1.5,
                          ),
                          child: textView16(
                              context: context,
                              text: supportReply.adminMessage != null
                                  ? supportReply.adminMessage!
                                  : supportReply.customerMessage!,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    );
                  })),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              decoration:
                  customDecoration(shadowBlur: 2, shadowColor: ColorResource.lightHintTextColor, offset: const Offset(0, -2)),
              padding: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: InputTextFieldCustom(
                      radius: 10,
                      focusColorBorder: Colors.transparent,
                      formKey: formKey,
                      hintTxt: 'messing_hint'.tr,
                      controller: messageController,
                      borderColor: Colors.transparent,
                      decoration: customDecoration(shadowBlur: 2, radius: 10),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  customImageButton(
                    onTap: () {
                      if (messageController.text.isNotEmpty) {
                        Get.find<SupportTicketController>()
                            .sendText(widget.supportTicketModel.id.toString(), messageController.text, () {
                          messageController.text = '';
                          listController.jumpTo(listController.position.maxScrollExtent + 100);
                        });
                      }
                    },
                    blur: 0,
                    height: 50,
                    width: 50,
                    icon: Image.asset(
                      "assets/images/send_ic.png",
                      width: 24,
                      height: 24,
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
