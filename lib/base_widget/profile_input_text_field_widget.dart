import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base_colors.dart';
import 'custom_decoration.dart';
import 'custom_icon_button.dart';
import 'custom_input_text_field_border_less.dart';
import 'myphsar_text_view.dart';

class ProfileInputTextFieldWidget extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final Widget icon;
  final Function() onSave;
  final GlobalKey<FormState> formKey;

  final FocusNode? focusNote;

  const ProfileInputTextFieldWidget(
      {super.key,
      required this.title,
      this.hintText = '',
      required this.controller,
      required this.icon,
      required this.onSave,
      required this.formKey,
      required this.focusNote});

  @override
  State<ProfileInputTextFieldWidget> createState() => ProfileInputTextFieldWidgetState();
}

class ProfileInputTextFieldWidgetState extends State<ProfileInputTextFieldWidget> with TickerProviderStateMixin {
  bool _enableSaveBtn = true;

  var formState = FormState();

  late AnimationController aniController;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(microseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: customDecoration(color: Colors.white, radius: 10, shadowBlur: 2),
      child: Column(
        children: [
          Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    customImageButton(
                        height: 40, width: 40, color: ColorResource.lightHintTextColor, blur: 0, icon: widget.icon),
                    const SizedBox(
                      width: 8,
                    ),
                    textView16(
                        context: context,
                        text: widget.title,
                        color: ColorResource.hintTextColor,
                        fontWeight: FontWeight.w600)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 49),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomInputTextFieldNoBorder(
                      focusNode: widget.focusNote,
                      textInputAction: TextInputAction.next,
                      hintTxt: widget.hintText,
                      controller: widget.controller,
                      formKey: widget.formKey,
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: _enableSaveBtn,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: customImageButton(
                      height: 40,
                      width: 40,
                      color: ColorResource.lightHintTextColor,
                      blur: 0,
                      onTap: () {
                        setState(() {
                          if (_animation.status != AnimationStatus.completed) {
                            _controller.forward();
                          }
                          _enableSaveBtn = false;

                          widget.focusNote?.requestFocus();
                        });
                      },
                      icon: Image.asset("assets/images/pen_ic.png"))),
            ),
          ]),
          SizeTransition(
            sizeFactor: _animation,
            axis: Axis.vertical,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(bottom: 3, right: 2.5),
                padding: const EdgeInsets.only(top: 10),
                child: customImageButton(
                    padding: 1,
                    blur: 3,
                    height: 35,
                    width: 95,
                    onTap: () {
                      widget.onSave();
                      setState(() {
                        _controller.animateBack(0, duration: const Duration(milliseconds: 200));
                        _enableSaveBtn = true;
                        widget.formKey.currentState?.validate();
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 20,
                      color: ColorResource.primaryColor,
                    ),
                    text: textView15(
                        fontWeight: FontWeight.w700,
                        context: context,
                        text: 'save'.tr,
                        maxLine: 1,
                        textAlign: TextAlign.center,
                        height: 1.1)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
