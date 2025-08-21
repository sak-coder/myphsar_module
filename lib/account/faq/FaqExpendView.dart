import 'package:flutter/material.dart';
import 'package:myphsar/configure/config_model.dart';

import '../../base_colors.dart';
import '../../base_widget/custom_icon_button.dart';
import '../../base_widget/myphsar_text_view.dart';

class FaqExpendView extends StatefulWidget {
  final Faq _faq;

  const FaqExpendView(this._faq, {super.key});

  @override
  State<FaqExpendView> createState() => _FaqExpendViewState();
}

class _FaqExpendViewState extends State<FaqExpendView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool toggleButton = false;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(microseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInToLinear,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: customImageTextButton(
              iconAlign: CustomIconAlign.right,
              onTap: () {
                setState(() {
                  if (toggleButton) {
                    toggleButton = false;
                    _controller.animateBack(0, duration: const Duration(milliseconds: 300));
                  } else {
                    toggleButton = true;
                    if (_animation.status != AnimationStatus.completed) {
                      _controller.forward();
                    }
                  }
                });
              },
              blur: 0,
              radius: 5,
              padding: 5,
              color: ColorResource.whiteColor,
              height: 60,
              icon: Icon(
                toggleButton ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down_outlined,
                size: 25,
                color: Colors.grey,
              ),
              text: textView15(
                  color: ColorResource.secondaryColor,
                  context: context,
                  text: widget._faq.question!,
                  maxLine: 3,
                  fontWeight: FontWeight.w500)),
        ),
        SizeTransition(
          sizeFactor: _animation,
          axis: Axis.vertical,
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
                color: ColorResource.lightGrayBgColor,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: textView15(
                    color: ColorResource.lightTextColor,
                    textAlign: TextAlign.start,
                    context: context,
                    text: widget._faq.answer!,
                    maxLine: 10)),
          ),
        ),
      ],
    );
  }
}
