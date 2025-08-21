import 'package:flutter/material.dart';
import 'package:myphsar/account/address/AddressModel.dart';

import '../../base_colors.dart';
import '../../base_widget/custom_icon_button.dart';
import '../../base_widget/myphsar_text_view.dart';

Widget addressItemView(BuildContext context, AddressModel addressModel) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Stack(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              customImageButton(
                  height: 40,
                  width: 40,
                  color: ColorResource.lightHintTextColor,
                  blur: 0,
                  icon: Image.asset("assets/images/map_ic.png")),
              const SizedBox(
                width: 8,
              ),
              textView15(
                  context: context,
                  text: addressModel.addressType.toString(),
                  color: ColorResource.hintTextColor,
                  fontWeight: FontWeight.w600)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 49),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: textView15(context: context, text: addressModel.address.toString())),
          ),
        ],
      ),
    ]),
  );
}
