import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:myphsar/base_widget/custom_bottom_sheet_dialog.dart';


import '../base_colors.dart';
import '../account/address/address_view_controller.dart';


import 'custom_decoration.dart';

import 'custom_icon_button.dart';
import 'custom_input_text_field_border_less.dart';
import 'myphsar_text_view.dart';

class AddressTextFieldWidget extends StatefulWidget {
  final String title;

  final TextEditingController controller;
  final Widget icon;
  final Function() onSave;

  final int index;
  final int id;
  final GlobalKey<FormState> formKey;
  final bool saveBtn;
  final FocusNode? focusNote;
  final String address;
  final String contactPerson;
  final String contactNumber;
  final String city;

  const AddressTextFieldWidget(
      {super.key,
      required this.index,
      required this.id,
      required this.address,
      required this.contactPerson,
      required this.contactNumber,
      required this.controller,
      required this.icon,
      required this.onSave,
      required this.formKey,
      required this.focusNote,
      required this.title,
      required this.city,
      this.saveBtn = true});

  @override
  State<AddressTextFieldWidget> createState() => _FlatTextFieldWidgetState();
}

class _FlatTextFieldWidgetState extends State<AddressTextFieldWidget> with TickerProviderStateMixin {
  final addressForm = GlobalKey<FormState>();
  final cityForm = GlobalKey<FormState>();
  final contactForm = GlobalKey<FormState>();
  final numberForm = GlobalKey<FormState>();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var contactController = TextEditingController();
  var numberController = TextEditingController();

  bool _enableSaveBtn = true;

  var formState = FormState();

  late AnimationController aniController;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    addressController.text = widget.address;
    contactController.text = widget.contactPerson;
    numberController.text = widget.contactNumber;
    cityController.text = widget.city;
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
                    textView15(
                        context: context,
                        text: widget.title,
                        color: ColorResource.lightTextColor,
                        fontWeight: FontWeight.w700)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 49),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomInputTextFieldNoBorder(
                      //		focusNode: widget.focusNote,
                      textInputAction: TextInputAction.next,
                      controller: addressController,
                      hintTxt: widget.address,
                      formKey: addressForm,
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
                margin: const EdgeInsets.only(bottom: 3, right: 2.5, left: 2.5),
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 49, bottom: 10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CustomInputTextFieldNoBorder(
                          //	  focusNode: widget.focusNote,
                          textInputAction: TextInputAction.next,
                          hintTxt: widget.city,
                          controller: cityController,
                          formKey: cityForm,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 49, bottom: 10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CustomInputTextFieldNoBorder(
                          //	  focusNode: widget.focusNote,
                          textInputAction: TextInputAction.next,
                          hintTxt: widget.contactPerson,
                          controller: contactController,
                          formKey: contactForm,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 49, bottom: 10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CustomInputTextFieldNoBorder(
                          // focusNode: widget.focusNote,
                          textInputAction: TextInputAction.next,
                          hintTxt: widget.contactNumber,
                          controller: numberController,
                          formKey: numberForm,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: customTextButton(
                            radius: 10,
                            alignmentDirectional: AlignmentDirectional.center,
                            padding: 5,
                            height: 35,
                            blur: 1,
                            onTap: () {
                              customBottomSheetDialog(
                                  context: context,
                                  child: Column(
                                    children: [
                                      textView18(
                                          context: context,
                                          text: "delete_confirm_msg".tr,
                                          fontWeight: FontWeight.w800,
                                          color: ColorResource.darkTextColor),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          customTextButton(
                                            padding: 1,
                                            blur: 0,
                                            height: 50,
                                            width: 95,
                                            onTap: () async {
                                              Navigator.pop(context);
                                              await Get.find<AddressViewController>().deleteAddress(
                                                context,
                                                widget.id.toString(),
                                                widget.index,
                                              );
                                            },
                                            text: Center(
                                              child: textView20(
                                                  context: context,
                                                  text: "yes".tr,
                                                  fontWeight: FontWeight.w700,
                                                  color: ColorResource.darkTextColor),
                                            ),
                                          ),
                                          customTextButton(
                                            padding: 1,
                                            blur: 0,
                                            height: 50,
                                            width: 95,
                                            onTap: () {
                                              Navigator.pop(context);
                                              //		Get.find<AddressViewController>().deleteAddress(context,widget.id.toString(),widget.index);
                                            },
                                            text: Center(
                                              child: textView20(
                                                  context: context,
                                                  text: "no".tr,
                                                  fontWeight: FontWeight.w700,
                                                  color: ColorResource.primaryColor),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  height: 150);
                            },
                            text: textView14(
                              fontWeight: FontWeight.w700,
                              color: ColorResource.secondaryColor,
                              context: context,
                              text: 'delete'.tr,
                              maxLine: 1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        widget.saveBtn
                            ? customTextButton(
                                alignmentDirectional: AlignmentDirectional.center,
                                padding: 5,
                                blur: 2,
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
                                text: textView14(
                                    fontWeight: FontWeight.w700,
                                    color: ColorResource.secondaryColor,
                                    context: context,
                                    text: 'save'.tr,
                                    maxLine: 1,
                                    textAlign: TextAlign.center,
                                    height: 1.1))
                            : customTextButton(
                                radius: 10,
                                height: 35,
                                blur: 1,
                                alignmentDirectional: AlignmentDirectional.center,
                                padding: 5,
                                text: textView14(
                                    fontWeight: FontWeight.w700,
                                    color: ColorResource.secondaryColor,
                                    context: context,
                                    text: 'back'.tr,
                                    maxLine: 1,
                                    textAlign: TextAlign.center,
                                    height: 1.1),
                                onTap: () {
                                  setState(() {
                                    _controller.animateBack(0, duration: const Duration(milliseconds: 200));
                                    _enableSaveBtn = true;
                                    widget.formKey.currentState?.validate();
                                  });
                                }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
