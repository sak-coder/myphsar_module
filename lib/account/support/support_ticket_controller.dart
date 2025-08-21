import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/account/support/SupportTicketParam.dart';
import 'package:myphsar/account/support/ticket/SupportTicketModel.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';

import 'chat/SupportReplyModel.dart';

class SupportTicketController extends BaseController {
  final BaseProvider _baseProvider;

  SupportTicketController(this._baseProvider);

  final _supportTicketModel = <SupportTicketModel>[].obs;
  final _supportReplayModel = <SupportReplyModel>[].obs;

  List<SupportTicketModel> get getSupportTicketModel => _supportTicketModel;

  List<SupportReplyModel> get getSupportReplyChatList => _supportReplayModel;

  void sendText(String id, String text, Function() callback) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day, now.hour, now.minute);
    _supportReplayModel.obs.value.add(SupportReplyModel(customerMessage: text, createdAt: date.toString()));
    sendReply(id, text);
    callback();
  }

  Future sendSupportTicket(SupportTicketParamModel supportTicketParam, BuildContext context) async {
    await _baseProvider.sendSupportTicketApiProvider(supportTicketParam).then((value) => {
          if (value.statusCode == 200)
            {
              getSupportTicketList(),
              if (context.mounted) {Navigator.pop(context)}
            }
          else
            {}

        });
  }

  Future getSupportTicketList() async {
    change(true, status: RxStatus.loading());
    await _baseProvider.getSupportTicketListApiProvider().then((value) => {
          if (value.statusCode == 200)
            {
              _supportTicketModel.obs.value.clear(),
              value.body.forEach((val) {
                _supportTicketModel.obs.value.add(SupportTicketModel.fromJson(val));
              }),
              notifySuccessResponse(_supportTicketModel.length),
            }
          else
            { notifyErrorResponse(value.statusText.toString())}
        });
  }

  Future getSupportReplyList(String ticketId) async {
    await _baseProvider.getSupportReplyListApiProvider(ticketId).then((value) => {
          if (value.statusCode == 200)
            {
              _supportReplayModel.obs.value.clear(),
              value.body.forEach((val) {
                _supportReplayModel.obs.value.add(SupportReplyModel.fromJson(val));
              })
            }
          else
            {}
        });
  }

  Future sendReply(String ticketId, String textMessage) async {
    await _baseProvider
        .sendReplyApiProvider(ticketId, textMessage)
        .then((value) => {if (value.statusCode == 200) {} else {}});
  }
}
