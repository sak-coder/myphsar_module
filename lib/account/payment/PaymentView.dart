import 'package:flutter/material.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';

import '../../base_widget/profile_input_text_field_widget.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final _nameKey = GlobalKey<FormState>();
  final _phoneKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();

  var nameFocus = FocusNode();
  var emailFocus = FocusNode();
  var phoneFocus = FocusNode();

  @override
  void initState() {
    _nameController.text = "Expires 01/24";
    _emailController.text = "Email";
    _phoneController.text = "010599343";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: customAppBarView(context: context, titleText: "Payment"),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: textView20(context: context, text: "Default", color: ColorResource.darkTextColor),
              ),
              ProfileInputTextFieldWidget(
                hintText: 'user name',
                title: '**** **** **** 1234',
                controller: _nameController,
                icon: Image.asset(
                  "assets/images/map_ic.png",
                  width: 18,
                ),
                onSave: () {},
                formKey: _nameKey,
                focusNote: nameFocus,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: textView20(context: context, text: "Other Payment", color: ColorResource.darkTextColor),
              ),
              ProfileInputTextFieldWidget(
                hintText: 'user phone',
                title: 'Work',
                controller: _phoneController,
                icon: Image.asset(
                  "assets/images/map_ic.png",
                  width: 18,
                ),
                onSave: () {},
                formKey: _phoneKey,
                focusNote: phoneFocus,
              ),
            ],
          ),
        ),
        topSafeArea: true);
  }
}
