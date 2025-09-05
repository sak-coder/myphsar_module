import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/account/address/address_view_controller.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_bottom_sheet_dialog.dart';
import 'package:myphsar/base_widget/custom_icon_button.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';
import 'package:myphsar/base_widget/not_found.dart';
import 'package:myphsar/base_widget/reload_button.dart';
import 'package:myphsar/check_out/check_out_controller.dart';
import 'package:myphsar/check_out/ce_express/ce_city_list_model.dart';
import 'package:myphsar/map/pick_map_view.dart';

import '../../base_widget/address_text_field_widget.dart';
import '../../base_widget/alert_dialog_view.dart';
import '../../base_widget/custom_decoration.dart';
import '../../base_widget/input_text_field_icon.dart';
import 'ParamAddAddressModel.dart';

class AddressView extends StatefulWidget {
  const AddressView({super.key});

  @override
  State<AddressView> createState() => _AddressViewState();

  static pickCityDialog(List<Cities> list, BuildContext context, Function pick) {
    alertDialogWidgetView(
      context: context,
      widget: Wrap(children: [
        Container(
          constraints: const BoxConstraints(
            maxHeight: 500,
          ),
          child: list.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.only(top: 2, right: 2, left: 2),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        decoration: customDecoration(radius: 10, shadowBlur: 2),
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        padding: const EdgeInsets.only(left: 10),
                        child: Material(
                            color: ColorResource.whiteColor,
                            child: InkWell(
                              onTap: () async {
                                pick(list[index]);
                                Navigator.pop(context);
                                // Get.to(PaymentTableView());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                                          child: textView15(
                                              context: context, text: list[index].cityName.toString(), maxLine: 2))),
                                ],
                              ),
                            )));
                  })
              : onErrorReloadButton(context, "", height: 200, onTap: () {
                  Navigator.pop(context);
                }),
        )
      ]),
    );
  }
}

class _AddressViewState extends State<AddressView> {
  String cityId = "";
  final city = GlobalKey<FormState>();
  final addressForm = GlobalKey<FormState>();
  final contactForm = GlobalKey<FormState>();
  final numberForm = GlobalKey<FormState>();
  var cityController = TextEditingController();
  var addressController = TextEditingController();
  var contactController = TextEditingController();
  var numberController = TextEditingController();
  var cityProvinceController = TextEditingController();
  var nameFocus = FocusNode();
  bool addressPick = false;
  var _mapModel = MapModel();

  @override
  void initState() {
    Get.find<AddressViewController>().getAllAddress();
    Get.find<AddressViewController>().mapPickListener.stream.listen((mapModel) {
      mapModel as MapModel;
      _mapModel = mapModel;
      setState(() {
        addressController.text = mapModel.address.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(context: context, titleText: "address".tr),
      body: Get.find<AddressViewController>().obx(
        (state) => Obx(() => ListView.builder(
            padding: const EdgeInsets.only(bottom: 20),
            itemCount: Get.find<AddressViewController>().getAddressModelList.length,
            itemBuilder: (BuildContext context, int index) {
              var addressModel = Get.find<AddressViewController>().getAddressModelList;
              var name = TextEditingController();
              var nameKey = GlobalKey<FormState>();
              var nameFocus = FocusNode();

              name.text = addressModel[index].address!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  index < 2
                      ? Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: textView15(
                              fontWeight: FontWeight.w600,
                              context: context,
                              text: index == 0 ? "Default" : "Other",
                              color: ColorResource.darkTextColor),
                        )
                      : Container(),
                  AddressTextFieldWidget(
                    index: index,
                    id: addressModel[index].id!,
                    title: addressModel[index].addressType!,
                    controller: name,
                    icon: Image.asset(
                      "assets/images/map_ic.png",
                      width: 18,
                    ),
                    saveBtn: false,
                    onSave: () {},
                    formKey: nameKey,
                    focusNote: nameFocus,
                    address: addressModel[index].address!,
                    city: addressModel[index].city.toString(),
                    contactPerson: addressModel[index].contactPersonName!,
                    contactNumber: addressModel[index].phone!,
                  ),
                ],
              );
            })),
        onEmpty: notFound(context, "empty_address".tr),
        onError: (s) =>
            onErrorReloadButton(context, s.toString(), height: MediaQuery.of(context).size.height, onTap: () {
          Get.find<AddressViewController>().getAllAddress();
        }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: customTextButton(
          blur: 0,
          height: 50,
          radius: 5,
          color: ColorResource.primaryColor,
          onTap: () async {
            // Get.to(MapPicker());
            addressController.text = '';
            contactController.text = '';
            numberController.text = '';
            cityController.text = '';
            addressPick = false;
            // Get.find<AddressViewController>().addressType.value = "choose_address_type".tr;
            Get.find<AddressViewController>().addingAddress.value = false;
            customBottomSheetDialog(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              context: context,
              child: Wrap(
                children: [
                  Center(
                    child: textView16(
                        context: context,
                        text: "shipping_address".tr,
                        maxLine: 1,
                        color: ColorResource.darkTextColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: textView16(
                                context: context,
                                text: "choose_address_type".tr,
                                maxLine: 1,
                                color: ColorResource.lightTextColor,
                                fontWeight: FontWeight.w500),
                          ),
                          Obx(
                            () => SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  children: [
                                    customImageTextButton(
                                        text: textView12(
                                            context: context,
                                            text: "home_address".tr,
                                            maxLine: 1,
                                            color:
                                                Get.find<AddressViewController>().addressType.value == "home_address".tr
                                                    ? ColorResource.whiteColor
                                                    : ColorResource.darkTextColor,
                                            fontWeight: FontWeight.w500),
                                        blur: 0,
                                        height: 40,
                                        width: 95,
                                        icon: Image.asset("assets/images/home_ic.png",
                                            color:
                                                Get.find<AddressViewController>().addressType.value == "home_address".tr
                                                    ? ColorResource.whiteColor
                                                    : ColorResource.darkTextColor),
                                        color: Get.find<AddressViewController>().addressType.value == "home_address".tr
                                            ? ColorResource.orange
                                            : ColorResource.whiteColor,
                                        onTap: () {
                                          Get.find<AddressViewController>().addressType.value = "home_address".tr;
                                        }),
                                    customImageTextButton(
                                        text: textView12(
                                            context: context,
                                            text: "office".tr,
                                            maxLine: 1,
                                            color: Get.find<AddressViewController>().addressType.value == "office".tr
                                                ? ColorResource.whiteColor
                                                : ColorResource.darkTextColor,
                                            fontWeight: FontWeight.w500),
                                        blur: 0,
                                        height: 40,
                                        width: 115,
                                        icon: Image.asset("assets/images/office_ic.png",
                                            color: Get.find<AddressViewController>().addressType.value == "office".tr
                                                ? ColorResource.whiteColor
                                                : ColorResource.darkTextColor),
                                        color: Get.find<AddressViewController>().addressType.value == "office".tr
                                            ? ColorResource.orange
                                            : ColorResource.whiteColor,
                                        onTap: () {
                                          Get.find<AddressViewController>().addressType.value = "office".tr;
                                        }),
                                    customImageTextButton(
                                        text: textView12(
                                            context: context,
                                            text: "other".tr,
                                            maxLine: 1,
                                            color: Get.find<AddressViewController>().addressType.value == "other".tr
                                                ? ColorResource.whiteColor
                                                : ColorResource.darkTextColor,
                                            fontWeight: FontWeight.w500),
                                        blur: 0,
                                        height: 40,
                                        width: 110,
                                        icon: Image.asset("assets/images/location_ic.png",
                                            color: Get.find<AddressViewController>().addressType.value == "other".tr
                                                ? ColorResource.whiteColor
                                                : ColorResource.darkTextColor),
                                        color: Get.find<AddressViewController>().addressType.value == "other".tr
                                            ? ColorResource.orange
                                            : ColorResource.whiteColor,
                                        onTap: () {
                                          Get.find<AddressViewController>().addressType.value = "other".tr;
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(5),
                          //   child: DropdownButton<String>(
                          //     icon: Icon(
                          //       Icons.arrow_drop_down_rounded,
                          //       size: 40,
                          //     ),
                          //     hint: Obx(
                          //       () => TextViewSize_15(
                          //           context: context,
                          //           text: Get.find<AddressViewController>().addressType.value,
                          //           maxLine: 1,
                          //           color: ColorResource.darkTextColor,
                          //           fontWeight: FontWeight.w500),
                          //     ),
                          //     underline: Container(),
                          //     items: <String>['home_address'.tr, 'office'.tr, 'other'.tr].map((String value) {
                          //       return DropdownMenuItem<String>(
                          //         value: value,
                          //         child: TextViewSize_15(
                          //           context: context,
                          //           text: value,
                          //         ),
                          //       );
                          //     }).toList(),
                          //     onChanged: (text) {
                          //       addressPick = true;
                          //       Get.find<AddressViewController>().addressType.value = text!;
                          //     },
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),

                          const SizedBox(
                            height: 10,
                          ),
                          InputTextFieldWithIcon(
                            readonly: true,
                            onTap: () async {
                              await Get.find<CheckOutController>().getCEAvailableCityModel().then((value) => {
                                    // this.pickCityDialog(Get.find<CheckOutController>().getCeCityModel.cities!)
                                    AddressView.pickCityDialog(
                                        Get.find<CheckOutController>().getCeCityModel.cities!, context, (city) {
                                      cityController.text = city.cityName.toString();
                                      cityId = city.id.toString();
                                    })
                                  });
                            },
                            imageIcon: Image.asset(
                              'assets/images/city_ic.png',
                              width: 20,
                              height: 20,
                              color: ColorResource.primaryColor,
                            ),
                            textInputAction: TextInputAction.next,
                            hintTxt: 'province_city1'.tr,
                            controller: cityController,
                            formKey: city,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InputTextFieldWithIcon(
                            rightImageIcon: SizedBox(
                              width: 78,
                              child: Row(
                                children: [
                                  Container(
                                    color: ColorResource.lightShadowColor50,
                                    width: 1,
                                    height: 48,
                                  ),
                                  // customImageTextButton(
                                  //   text: textView11(context: context, text: "Map", fontWeight: FontWeight.w500),
                                  //   blur: 0,
                                  //   radius: 1,
                                  //   onTap: () {
                                  //     Get.to(() => const PickMapView());
                                  //   },
                                  //   padding: 0,
                                  //   height: 45,
                                  //   width: 70,
                                  //   icon: Image.asset(
                                  //     "assets/images/pick_ic.png",
                                  //     width: 18,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            imageIcon: Image.asset(
                              'assets/images/map_ic.png',
                              width: 20,
                              height: 20,
                            ),
                            textInputAction: TextInputAction.next,
                            hintTxt: 'address'.tr,
                            controller: addressController,
                            formKey: addressForm,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InputTextFieldWithIcon(
                            imageIcon: Image.asset(
                              'assets/images/acc_ic.png',
                              width: 20,
                              height: 20,
                            ),
                            // focusNode: widget.focusNote,
                            textInputAction: TextInputAction.next,
                            hintTxt: "contact_name".tr,
                            controller: contactController,
                            formKey: contactForm,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InputTextFieldWithIcon(
                            imageIcon: Image.asset(
                              'assets/images/phone_off_ic.png',
                              width: 20,
                              height: 20,
                            ),
                            // focusNode: widget.focusNote,
                            textInputAction: TextInputAction.done,
                            hintTxt: "contact_number".tr,
                            inputType: TextInputType.phone,
                            controller: numberController,
                            formKey: numberForm,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          customTextButton(
                            blur: 0,
                            height: 50,
                            radius: 5,
                            color: ColorResource.primaryColor,
                            width: MediaQuery.of(context).size.width,
                            onTap: () {
                              if (contactController.text.isNotEmpty &&
                                  addressController.text.isNotEmpty &&
                                  numberController.text.isNotEmpty &&
                                  cityId.isNotEmpty) {
                                Get.find<AddressViewController>().addAddress(
                                    ParamAddAddressModel(
                                        contactPersonName: contactController.text.trim(),
                                        addressType: Get.find<AddressViewController>().addressType.value,
                                        address: addressController.text.trim(),
                                        cityId: cityId,
                                        zip: 'empty',
                                        phone: numberController.text.trim(),
                                        city: '${_mapModel.lat} ${_mapModel.lang}'),
                                    context);
                              } else {
                                customErrorBottomDialog(context, "address_alert_message".tr);
                              }
                            },
                            text: textView15(
                                context: context,
                                text: "add_address".tr,
                                maxLine: 1,
                                height: 1.7,
                                color: ColorResource.whiteColor,
                                textAlign: TextAlign.center),
                          )
                        ],
                      ),
                      Obx(() => Get.find<AddressViewController>().addingAddress.value == true
                          ? const CircularProgressIndicator()
                          : Container()),
                    ],
                  ),
                ],
              ),
              height: 472,
            );
          },
          text: Center(
            child: textView15(
                context: context,
                text: "add_other_address".tr,
                color: ColorResource.whiteColor,
                textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }

// void pickDialog(List<dynamic> list) {
//   alertDialogWidgetView(
//     context: context,
//     widget: Wrap(children: [
//       Container(
//         constraints: BoxConstraints(
//           maxHeight: 500,
//         ),
//         child: list.length > 0
//             ? ListView.builder(
//                 padding: EdgeInsets.only(top: 2, right: 2, left: 2),
//                 shrinkWrap: true,
//                 itemCount: list.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                       decoration: CustomDecoration(radius: 10, shadowBlur: 2),
//                       margin: EdgeInsets.only(top: 5, bottom: 5),
//                       padding: EdgeInsets.only(left: 10),
//                       child: Material(
//                           color: ColorResource.whiteColor,
//                           child: InkWell(
//                             onTap: () async {
//                             c
//
//                               cityController.text = list[index].cityName.toString();
//                               cityId = list[index].id.toString();
//                               // Get.to(PaymentTableView());
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                     child: Padding(
//                                         padding: const EdgeInsets.only(top: 10, bottom: 10),
//                                         child: TextViewSize_15(
//                                             context: context, text: list[index].cityName.toString(), maxLine: 2))),
//                               ],
//                             ),
//                           )));
//                 })
//             : OnErrorReloadButton(context, "", height: 200, onTap: () {
//                 Navigator.pop(context);
//               }),
//       )
//     ]),
//   );
// }
}
