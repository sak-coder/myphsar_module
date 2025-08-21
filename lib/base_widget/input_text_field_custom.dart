import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';

class InputTextFieldCustom extends StatefulWidget {
  final TextEditingController? controller;
  final String hintTxt;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final GlobalKey<FormState>? formKey;
  final bool? isPassword;
  final TextInputType? inputType;
  final int maxLine;
  final double radius;
  final Color borderColor;
  final Decoration? decoration;
  final Color focusColorBorder;
  final int? maxLength;
  final Color fillColor;
  final TextAlign textAlign;

  const InputTextFieldCustom(
      {super.key,
      this.formKey,
      this.controller,
      required this.hintTxt,
      this.focusNode,
      this.nextNode,
      this.textInputAction,
      this.isPassword = false,
      this.maxLine = 1,
      this.inputType,
      this.borderColor = ColorResource.borderItemColor,
      this.radius = 10,
      this.fillColor = ColorResource.whiteColor,
      this.decoration,
      this.maxLength,
      this.focusColorBorder = ColorResource.borderItemColor,
        this.textAlign = TextAlign.start}

      );

  @override
  InputTextFieldCustomState createState() {
    return InputTextFieldCustomState();
  }
}

class InputTextFieldCustomState extends State<InputTextFieldCustom> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Container(
        decoration: widget.decoration,
        child: TextFormField(
          textAlign: widget.textAlign,
          maxLength: widget.maxLength,
          maxLines: widget.maxLine,
          controller: widget.controller,
          keyboardType: widget.inputType,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          obscureText: widget.isPassword == true ? _obscureText : false,
          decoration: InputDecoration(
            hintText: widget.hintTxt,
            hintStyle:
                Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500, fontSize: 14, height: 1.1),
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            isDense: true,
            filled: true,
            suffixIcon: widget.isPassword == true
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: ColorResource.hintTextColor,
                    ),
                    onPressed: _toggle)
                : null,
            fillColor: widget.fillColor,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: ColorResource.greenColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                borderSide: BorderSide(color: widget.focusColorBorder, width: 2.5)),
            errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorResource.primaryColor),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius), borderSide: BorderSide(color: widget.borderColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius), borderSide: BorderSide(color: widget.borderColor)),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'input'.tr + widget.hintTxt;
            }
            return null;
          },
        ),
      ),
    );
  }
}
