import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';

class InputTextFieldWithIcon extends StatefulWidget {
  final TextEditingController? controller;
  final String hintTxt;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final GlobalKey<FormState> formKey;
  final bool? isPassword;
  final TextInputType? inputType;
  final Widget? imageIcon;
  final bool hasBorderColor;
  final Color fillColor;
  final bool enable;
  final Widget? rightImageIcon;
  final Function(String)? onSubmit;
  final Function()? onTap;
  final Function(String)? onTextChange;
  final double maxIconWidth;
  final double minIconWidth;
  final bool applyMinWidth;
  final bool readonly;

  const InputTextFieldWithIcon(
      {super.key,
      required this.formKey,
      this.controller,
      required this.hintTxt,
      this.focusNode,
      this.nextNode,
      this.textInputAction,
      this.isPassword = false,
      this.inputType,
      this.enable = true,
      this.imageIcon,
      this.rightImageIcon,
      this.hasBorderColor = true,
      this.onSubmit,
      this.onTap,
        this.onTextChange,
      this.maxIconWidth = 120,
      this.minIconWidth = 50,
      this.applyMinWidth = false,
      this.readonly = false,
      this.fillColor = ColorResource.whiteColor});

  @override
  InputTextFieldCustomState createState() => InputTextFieldCustomState();
}

class InputTextFieldCustomState extends State<InputTextFieldWithIcon> {
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
      child: TextFormField(
        readOnly: widget.readonly,
        onChanged: widget.onTextChange,

        keyboardType: widget.inputType,
        controller: widget.controller,
        enabled: widget.enable,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        onFieldSubmitted: widget.onSubmit,
        onTap: widget.onTap,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        focusNode: widget.focusNode,
        obscureText: widget.isPassword == true ? _obscureText : false,
        decoration: InputDecoration(
          hintText: widget.hintTxt,
          hintStyle:
          Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500, fontSize: 14, height: 1.1),
        //  hintStyle: const TextStyle(fontSize: 15, height: 1, fontWeight: FontWeight.w500),
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
              : widget.rightImageIcon ?? const SizedBox.shrink(),
          prefixIconConstraints: BoxConstraints(maxWidth: widget.maxIconWidth, minWidth: widget.minIconWidth),
          prefixIcon: widget.imageIcon != null
              ? Align(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: widget.imageIcon,
                )
              : const SizedBox.shrink(),
          suffixIconConstraints: BoxConstraints(maxWidth: widget.maxIconWidth, minWidth: 15),
          fillColor: widget.fillColor,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: Colors.transparent)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: widget.hasBorderColor ? ColorResource.borderItemColor : Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorResource.borderItemColor, width: 2.5)),
          errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorResource.primaryColor),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorResource.primaryColor05)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: widget.hasBorderColor ? ColorResource.borderItemColor : Colors.transparent)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'please_enter'.tr + widget.hintTxt;
          }
          return null;
        },
      ),
    );
  }
}
