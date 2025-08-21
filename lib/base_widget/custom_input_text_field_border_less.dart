import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';

class CustomInputTextFieldNoBorder extends StatefulWidget {
  final TextEditingController? controller;
  final String hintTxt;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final GlobalKey<FormState> formKey;
  final bool? isPassword;
  final TextInputType? inputType;

  const CustomInputTextFieldNoBorder(
      {super.key,
      required this.formKey,
      this.controller,
      required this.hintTxt,
      this.focusNode,
      this.nextNode,
      this.textInputAction,
      this.isPassword = false,
      this.inputType});

  @override
  CustomInputTextFieldNoBorderState createState() => CustomInputTextFieldNoBorderState();
}

class CustomInputTextFieldNoBorderState extends State<CustomInputTextFieldNoBorder> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, letterSpacing: 0.1),
        maxLines: 5,
        minLines: 1,
        controller: widget.controller,
        focusNode: widget.focusNode,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: widget.hintTxt,
          hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 15, fontWeight: FontWeight.w500, color: ColorResource.hintTextColor, letterSpacing: 0.1),
          contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
          isDense: true,
          filled: true,
          fillColor: Theme.of(context).highlightColor,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorResource.lightGrayColor),
          ),

          errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: ColorResource.primaryColor),
          // errorBorder: OutlineInputBorder(
          // 		borderRadius: BorderRadius.circular(5),
          // 		borderSide: const BorderSide(color: ColorResource.primaryColor05)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.transparent)),
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
