import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/base_widget/custom_decoration.dart';
import 'package:myphsar/base_widget/custom_scaffold_indicator.dart';
import 'package:myphsar/utils/date_format.dart';

import '../base_widget/myphsar_text_view.dart';
import '../base_widget/not_found.dart';
import '../base_widget/reload_button.dart';
import '../configure/config_controller.dart';
import '../home/all_product/shimmer_placeholder_view.dart';
import 'chat_controller.dart';
import 'chat_room/chat_room_view.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    await Get.find<ChatController>().getAllChat();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldRefreshIndicator(
      body: Get.find<ChatController>().obx(
          (state) => ListView.builder(
              padding: const EdgeInsets.only(top: 20),
              itemCount: Get.find<ChatController>().getAllChatModel.uniqueShops?.length,
              itemBuilder: (BuildContext context, int index) {
                var chatList = Get.find<ChatController>().getAllChatModel.uniqueShops![index];
                return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    height: 80,
                    child: Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            Get.to(ChatRoomView(
                              shopId: chatList.shopId.toString(),
                              sellerId: chatList.sellerId.toString(),
                              shopName: chatList.shop!.name!,
                            ));
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(100),
                                    ),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: "assets/images/placeholder_img.png",
                                      placeholderFit: BoxFit.cover,
                                      fit: BoxFit.cover,
                                      image:
                                          '${Get.find<ConfigController>().configModel.baseUrls?.baseSellerImageUrl}/${Get.find<ChatController>()
                                                  .getAllChatModel
                                                  .uniqueShops![index]
                                                  .shop!
                                                  .image!}',
                                      width: 100,
                                      height: 100,
                                      imageErrorBuilder: (c, o, s) => Image.asset(
                                        "assets/images/placeholder_img.png",
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    textView15(
                                      context: context,
                                      text: chatList.shop!.name!,
                                      fontWeight: chatList.seenByCustomer == 1 ? FontWeight.w600 : FontWeight.w500,
                                    ),
                                    textView13(
                                        context: context,
                                        text:
                                            '${chatList.sentByCustomer == 1 ? '${'you'.tr}: ' : '${"shop".tr}: '} ${chatList.message!}',
                                        maxLine: 1,
                                        fontWeight: chatList.seenByCustomer == 1 ? FontWeight.w600 : FontWeight.w500),
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children: [
                                        textView10(
                                            context: context,
                                            text: DateFormate.isoStringToLocalDayTime(chatList.createdAt!),
                                            fontWeight: FontWeight.w500,
                                            color: ColorResource.lightShadowColor),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                                          child: chatList.sentByCustomer == 1
                                              ? Image.asset(
                                                  chatList.seenBySeller == 0
                                                      ? "assets/images/done_all_ic.png"
                                                      : "assets/images/done_one_ic.png",
                                                  width: 18,
                                                  color: Colors.green,
                                                )
                                              : const SizedBox.shrink(),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              chatList.seenByCustomer == 1
                                  ? Container(
                                      decoration: customDecoration(
                                        radius: 100,
                                        color: ColorResource.primaryColor,
                                      ),
                                      width: 8,
                                      height: 8)
                                  : const SizedBox.shrink()
                            ],
                          ),
                        )));
              }),
          onLoading: chatShimmerView(context),
          onError: (s) =>
              onErrorReloadButton(context, s.toString(), height: MediaQuery.of(context).size.height, onTap: () {
                initData();
              }),
          onEmpty: SizedBox(height: MediaQuery.of(context).size.height, child: notFound(context, 'empty_chat'.tr))),
      onRefresh: () async {
        initData();
      },
    );
  }
}
