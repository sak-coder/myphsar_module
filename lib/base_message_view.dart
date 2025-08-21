import 'package:flutter/material.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/base_widget/custom_icon_button.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';

class FullScreenAlertMessageView extends StatefulWidget {
  final MessageBody messageBody;
  final Function() onTap;
  final Widget icon;

  const FullScreenAlertMessageView({super.key, required this.messageBody, required this.onTap, required this.icon});

  @override
  State<FullScreenAlertMessageView> createState() => _FullScreenAlertMessageViewState();
}

class _FullScreenAlertMessageViewState extends State<FullScreenAlertMessageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResource.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: widget.icon,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: textView15(
                  textAlign: TextAlign.center,
                  context: context,
                  text: widget.messageBody.titleMessage!,
                  color: ColorResource.whiteColor),
            ),
            textView14(
                textAlign: TextAlign.center,
                context: context,
                text: widget.messageBody.message,
                color: ColorResource.lightGrayBgColor,
                maxLine: 5),
            const SizedBox(
              height: 20,
            ),
            customTextButton(
                radius: 10,
                color: ColorResource.primaryColor,
                borderColor: ColorResource.whiteColor,
                onTap: widget.onTap,
                text: textView15(
                    context: context, text: widget.messageBody.buttonLabel, color: ColorResource.whiteColor)),
          ],
        ),
      ),
    );
  }
}

class MessageBody {
  String message;
  String? titleMessage;
  String buttonLabel;

  MessageBody(this.titleMessage, {required this.message, required this.buttonLabel});
}
