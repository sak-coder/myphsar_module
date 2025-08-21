import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/chat/chat_controller.dart';

import '../../../base_colors.dart';
import '../../../base_widget/custom_decoration.dart';
import '../../../base_widget/custom_icon_button.dart';
import '../../../base_widget/input_text_field_custom.dart';
import '../../../base_widget/myphsar_text_view.dart';
import '../../../utils/date_format.dart';

class ChatRoomView extends StatefulWidget {
  final String shopId;
  final String sellerId;
  final String shopName;

  const ChatRoomView({super.key, required this.shopId, required this.sellerId, required this.shopName});

  @override
  State<ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<ChatRoomView> {
  var formKey = GlobalKey<FormState>();
  var messageController = TextEditingController();
  ScrollController listController = ScrollController();
  int countTimer = 0;
  late Timer timer;

  bool isFailed = false;

  @override
  void initState() {
    getAllChatWithShop();
    super.initState();
  }

  //:TODO Note* implement socket
  void timerIntervalGetChat() {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      countTimer++;
      if (countTimer == 15) {
        timer.cancel();
      }

      getAllChatWithShop();
    });
  }

  // @override
  // void dispose() {
  //   timer.cancel();
  //   super.dispose();
  // }

  // @override
  // void deactivate() {
  //   timer.cancel();
  //   super.deactivate();
  // }

  void getAllChatWithShop() async {
    Get.find<ChatController>().getChatWithShop(widget.shopId, () {
      Get.find<ChatController>().readChatMessage(widget.shopId);
      listController.animateTo(listController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: customAppBarView(context: context, titleText: widget.shopName),
        body: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.builder(
                  controller: listController,
                  itemCount: Get.find<ChatController>().getAllChatWithShopModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    var chat = Get.find<ChatController>().getAllChatWithShopModel[index];
                    return Column(
                      crossAxisAlignment: chat.sentByCustomer == 1 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        index == 0
                            ? Center(
                                child: textView15(
                                    context: context,
                                    text: 'welcome_to'.tr + widget.shopName + 'chat_with_shop'.tr,
                                    maxLine: 2,
                                    textAlign: TextAlign.center))
                            : const SizedBox.shrink(),
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: EdgeInsets.fromLTRB(
                              chat.sentBySeller == 0 ? 50 : 20, 20, chat.sentByCustomer == 0 ? 50 : 20, 5),
                          decoration: customDecoration(
                            radius: 10,
                            shadowBlur: 1.5,
                          ),
                          child: textView15(context: context, text: chat.message!, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          mainAxisAlignment: chat.sentByCustomer == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 5,
                                left: 20,
                              ),
                              child: textView10(
                                  context: context,
                                  text: DateFormate.isoStringToLocalDayTime(chat.createdAt!),
                                  color: ColorResource.lightTextColor,
                                  fontWeight: FontWeight.w400),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: chat.sentByCustomer == 1
                                  ? Image.asset(
                                      chat.seenBySeller == 0
                                          ? "assets/images/done_all_ic.png"
                                          : "assets/images/done_one_ic.png",
                                      width: 18,
                                      color: Colors.green,
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                        // isFailed
                        //     ? Padding(
                        //         padding: const EdgeInsets.only(right: 20),
                        //         child: CustomIconTextButton(
                        //             onTap: () {
                        //               SendMessage();
                        //             },
                        //             radius: 10,
                        //             color: ColorResource.lightHintTextColor,
                        //             padding: 0,
                        //             text: Text(
                        //               "Failed",
                        //               style: TextStyle(fontSize: 12),
                        //             ),
                        //             blur: 0.5,
                        //             height: 30,
                        //             width: 85,
                        //             icon: Icon(
                        //               Icons.refresh_rounded,
                        //               size: 20,
                        //             )),
                        //       )
                        //     : SizedBox.shrink(),
                      ],
                    );
                  })),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              decoration:
                  customDecoration(shadowBlur: 1, shadowColor: ColorResource.lightHintTextColor, offset: const Offset(0, -2)),
              padding: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: InputTextFieldCustom(
                      radius: 100,
                      focusColorBorder: Colors.transparent,
                      formKey: formKey,
                      hintTxt: 'messing_hint'.tr,
                      controller: messageController,
                      borderColor: Colors.transparent,
                      decoration: customDecoration(shadowBlur: 1.5, radius: 10),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  customImageButton(
                    onTap: () {
                      sendMessage();
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

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      Get.find<ChatController>().sendText(
          widget.shopId,
          widget.sellerId,
          messageController.text,
          (response) => {
                if (response)
                  {
                    messageController.text = '',
                    listController.jumpTo(listController.position.maxScrollExtent + 100),
                    getAllChatWithShop()
                  }
                else
                  {
                    // setState(() {
                    //   isFailed = true;
                    // })
                  }
              });
    }
  }
}
