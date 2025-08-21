import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';

import 'chat_model.dart';
import 'chat_room/chat_with_shop_model.dart';
import 'chat_room/message_param_model.dart';

class ChatController extends BaseController {
  final BaseProvider _baseProvider;

  ChatController(this._baseProvider);

  final _chatModel = ChatModel().obs;
  final _chatWithShopModel = <ChatWithShopModel>[].obs;
  var unRedChatCount = 0.obs;

  int get getUnRedChatCount => unRedChatCount.value;

  ChatModel get getAllChatModel => _chatModel.value;

  List<ChatWithShopModel> get getAllChatWithShopModel => _chatWithShopModel;

  void sendText(String shopId, String sellerId, String text, Function(bool status) callback) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day, now.hour, now.minute);
    _chatWithShopModel.obs.value.add(ChatWithShopModel(
        message: text,
        seenByCustomer: 1,
        seenBySeller: 1,
        sentBySeller: 0,
        sentByCustomer: 1,
        createdAt: date.toString()));
    sendChatMessage(
      MessageParamModel(sellerId: sellerId, shopId: shopId, message: text),
      callback,
    );
  }

  Future getAllChat() async {
    // unRedChatCount.value = 0;
    change(true, status: RxStatus.loading());
    await _baseProvider.getAllChatApiProvider().then((value) => {
          if (value.statusCode == 200)
            {
              unRedChatCount.value = 0,
              _chatModel.value = ChatModel.fromJson(value.body),
              if (ChatModel.fromJson(value.body).chatList != null)
                {
                  ChatModel.fromJson(value.body).uniqueShops!.forEach((element) {
                    if (element.seenByCustomer == 1) {
                      unRedChatCount++;
                    }
                  })
                },
              if (_chatModel.value.uniqueShops == null)
                {notifySuccessResponse(0)}
              else
                {notifySuccessResponse(_chatModel.value.uniqueShops!.length)}
            }
          else
            {notifyErrorResponse("${value.statusCode} \n${value.statusText}")}
        });
  }

  Future getChatWithShop(String id, Function() callback) async {
    _chatWithShopModel.obs.value.clear();
    await _baseProvider.getChatWithShopApiProvider(id).then((value) => {
          if (value.statusCode == 200)
            {
              value.body.forEach((val) {
                _chatWithShopModel.obs.value.add(ChatWithShopModel.fromJson(val));
              }),
              callback(),
            }
          else
            {
              // notifyErrorResponse("Error Code=" + value.statusCode.toString() + " \n" + value.statusText.toString())
            }
        });
  }

  Future readChatMessage(String id) async {
    await _baseProvider.readChatMessageApiProvider(id).then((value) => {
          if (value.statusCode == 200) {unRedChatCount.value--} else {}
        });
  }

  Future sendChatMessage(MessageParamModel messageParamModel, Function(bool sendStatus) callback) async {
    await _baseProvider.sendChatMessageApiProvider(messageParamModel).then((value) => {
          if (value.statusCode == 200) {callback(true)} else {callback(false)}
        });
  }
}
