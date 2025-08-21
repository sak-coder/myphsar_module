import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myphsar/account/installments_history/InstallmentsHistoryView.dart';
import 'package:myphsar/account/setting/setting_view.dart';
import 'package:myphsar/account/support/ticket/SupportCenterView.dart';
import 'package:myphsar/account/user_profile/UserProfileModel.dart';
import 'package:myphsar/account/user_profile/UserProfileView.dart';
import 'package:myphsar/account/user_profile/user_profile_controller.dart';
import 'package:myphsar/account/wishlist/WishlistView.dart';
import 'package:myphsar/auth/AuthController.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/base_widget/alert_dialog_view.dart';
import 'package:myphsar/base_widget/custom_bottom_sheet_dialog.dart';
import 'package:myphsar/base_widget/custom_decoration.dart';
import 'package:myphsar/base_widget/custom_icon_button.dart';
import 'package:myphsar/base_widget/custom_scaffold_indicator.dart';
import 'package:myphsar/base_widget/snack_bar_message.dart';
import 'package:myphsar/helper/share_pref_controller.dart';


import '../base_theme.dart';
import '../base_widget/input_text_field_custom.dart';
import '../base_widget/loader_view.dart';
import '../base_widget/myphsar_text_view.dart';
import '../base_widget/sing_in_dialog_view.dart';
import '../configure/config_controller.dart';
import 'about/about_us_view.dart';
import 'address/AddressView.dart';
import 'faq/FaqView.dart';
import 'offers/OffersView.dart';

class AccountView extends StatefulWidget {
  final BuildContext globalContext;

  const AccountView({super.key, required this.globalContext});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  // ItemSetting account1 =
  // ItemSetting(name: "FCM Token", image: "assets/images/partner_ic.png", widget: const FCMView());
  ItemSetting account =
      ItemSetting(name: "account".tr, image: "assets/images/account_ic.png", widget: const UserProfileView());
  ItemSetting address =
      ItemSetting(name: "address".tr, image: "assets/images/location_ic.png", widget: const AddressView());

  // ItemSetting payments = ItemSetting(name: "Payments", image: "assets/images/wallet_ic.png", widget: SignInView());
  ItemSetting installment =
      ItemSetting(name: "installments".tr, image: "assets/images/pay_ic.png", widget: const InstallmentsHistoryView());
  ItemSetting setting =
      ItemSetting(name: "setting".tr, image: "assets/images/setting_ic.png", widget: const SettingView());
  ItemSetting faq = ItemSetting(name: "FAQ", image: "assets/images/q_a_ic.png", widget: const FaqView());
  ItemSetting aboutUs =
      ItemSetting(name: "about_us".tr, image: "assets/images/info_ic.png", widget: const AboutUsView());

  var userProfileModel = UserProfileModel();
  late List<ItemSetting> widgetList;
  var file = File('');
  final picker = ImagePicker();

  @override
  void initState() {
    initData();
    widgetList = [account, address, installment, setting, faq, aboutUs];
    super.initState();
  }

  void reloadWidgetList() {
    widgetList.clear();
    // ItemSetting account1 =
    // ItemSetting(name: "account".tr, image: "assets/images/partner_ic.png", widget: const FCMView());
    ItemSetting account =
        ItemSetting(name: "account".tr, image: "assets/images/account_ic.png", widget: const UserProfileView());
    ItemSetting address =
        ItemSetting(name: "address".tr, image: "assets/images/location_ic.png", widget: const AddressView());

    // ItemSetting payments = ItemSetting(name: "Payments", image: "assets/images/wallet_ic.png", widget: SignInView());
    ItemSetting installment = ItemSetting(
        name: "installments".tr, image: "assets/images/pay_ic.png", widget: const InstallmentsHistoryView());
    ItemSetting setting =
        ItemSetting(name: "setting".tr, image: "assets/images/setting_ic.png", widget: const SettingView());
    ItemSetting faq = ItemSetting(name: "FAQ", image: "assets/images/q_a_ic.png", widget: const FaqView());
    ItemSetting aboutUs =
        ItemSetting(name: "about_us".tr, image: "assets/images/info_ic.png", widget: const AboutUsView());

    widgetList = [account, address, installment, setting, faq, aboutUs];
  }

  void initData() async {
    userProfileModel = Get.find<SharePrefController>().getUserProfile();
    if (Get.find<AuthController>().isSignIn()) {
      await Get.find<UserProfileController>().getUserProfile(widget.globalContext, (val) {});
    } else {
      Get.find<UserProfileController>().getGuestUser();
    }
  }

  void _choose() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500, maxWidth: 500);

    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
        //Noted* check with back-end for update only need param
        Get.find<UserProfileController>().updateUserInfo(
          context: widget.globalContext,
          updateUserModel: ParamUserProfileModel(
            fName: userProfileModel.fName,
            lName: userProfileModel.lName,
            email: userProfileModel.email,
            phone: userProfileModel.phone,
          ),
          imageFile: file,
        );
      } else {
        snackBarMessage(widget.globalContext, 'no_image_select'.tr);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    context = widget.globalContext;
    return CustomScaffoldRefreshIndicator(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        reverse: false,
        child: Stack(
          children: [
            Column(children: [
              Stack(
                children: [
                  Container(
                    height: 400,
                    decoration: const BoxDecoration(
                        color: ColorResource.primaryColor05,
                        gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                              Color.fromRGBO(255, 0, 0, 0.615686274509804),
                              Colors.white,
                            ],
                            stops: [
                              0.5,
                              1
                            ])),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 20),
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              textView25(context: context, text: "profile".tr, color: ColorResource.secondaryColor),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: textView13(
                                        context: context,
                                        text: Get.find<SharePrefController>().getLocalLanguage().languageCode == 'en'
                                            ? "english".tr
                                            : "khmer".tr),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      alertDialogWidgetView(
                                        context: context,
                                        widget: Column(
                                          children: [
                                            textView15(
                                                height: 2,
                                                context: context,
                                                text: "selectLanguage".tr,
                                                fontWeight: FontWeight.w600),
                                            customTextButton(
                                                onTap: () {
                                                  Get.find<SharePrefController>()
                                                      .saveLocalLanguage(lCode: 'kh', cCOde: 'KH')
                                                      .then((value) => {
                                                            Get.updateLocale(const Locale('kh', 'KH')),
                                                            Get.changeTheme(khBaseTheme),
                                                            reloadWidgetList(),
                                                            if (context.mounted) {Navigator.pop(context)}
                                                          });
                                                },
                                                blur: 0,
                                                radius: 0,
                                                width: MediaQuery.of(context).size.width,
                                                text: textView15(
                                                    context: context, text: "khmer".tr, fontWeight: FontWeight.w600)),
                                            customTextButton(
                                                onTap: () {
                                                  Get.find<SharePrefController>()
                                                      .saveLocalLanguage(lCode: 'en', cCOde: 'US')
                                                      .then((value) => {
                                                            Get.updateLocale(const Locale('en', 'US')),
                                                            Get.changeTheme(enBaseTheme),
                                                            reloadWidgetList(),
                                                            if (context.mounted) {Navigator.pop(context)}
                                                          });
                                                },
                                                blur: 0,
                                                radius: 0,
                                                width: MediaQuery.of(context).size.width,
                                                text: textView15(
                                                    context: context, text: "english".tr, fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                      );
                                      // Get.find<SharePrefController>()
                                      //     .saveLocalLanguage(lCode: 'en', cCOde: 'US')
                                      //     .then((value) => {Get.updateLocale(const Locale('en', 'US'))});
                                    },
                                    child: Image.asset(
                                      "assets/images/language_ic.png",
                                      color: ColorResource.secondaryColor,
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: Stack(alignment: Alignment.center, children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            child: file.path == ''
                                ? Obx(
                                    () => ExtendedImage.network(
                                      '${Get.find<ConfigController>().configModel.baseUrls!.baseCustomerImageUrl}/${Get.find<UserProfileController>().getUserprofileModel.image}',
                                      fit: BoxFit.cover,
                                      width: 120,
                                      height: 120,
                                      loadStateChanged: (ExtendedImageState state) {
                                        switch (state.extendedImageLoadState) {
                                          case LoadState.failed:
                                            return GestureDetector(
                                              child: Stack(
                                                fit: StackFit.expand,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/images/placeholder_img.png",
                                                    fit: BoxFit.fill,
                                                  ),
                                                ],
                                              ),
                                            );
                                          case LoadState.loading:
                                            // TODO: Handle this case.
                                            break;
                                          case LoadState.completed:
                                            // TODO: Handle this case.
                                            break;
                                        }
                                        return null;
                                      },
                                    ),
                                  )
                                : Image.file(file, width: 120, height: 120, fit: BoxFit.cover),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: customImageButton(
                              height: 35,
                              width: 35,
                              radius: 10,
                              blur: 0,
                              shadowColor: Colors.transparent,
                              color: Colors.black12,
                              onTap: () async {
                                if (Get.find<AuthController>().isSignIn()) {
                                  if (userProfileModel.phone == null) {
                                    GlobalKey<FormState> key = GlobalKey();
                                    var phoneController = TextEditingController();
                                    customBottomSheetDialogWrap(
                                        context: context,
                                        child: Wrap(
                                          children: [
                                            textView15(context: context, text: "Please Add Phone Number "),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10, bottom: 10),
                                              child: InputTextFieldCustom(
                                                  formKey: key, controller: phoneController, hintTxt: "Phone Number"),
                                            ),
                                            customTextButton(
                                                color: ColorResource.primaryColor,
                                                blur: 1,
                                                radius: 10,
                                                width: MediaQuery.of(context).size.width,
                                                text: textView15(
                                                    color: Colors.white,
                                                    context: context,
                                                    text: "Add",
                                                    textAlign: TextAlign.center),
                                                onTap: () {
                                                  userProfileModel.phone = phoneController.text.toString();
                                                  _choose();
                                                  Navigator.pop(context);
                                                })
                                          ],
                                        ));
                                  } else {
                                    _choose();
                                  }
                                } else {
                                  signInDialogView(context);
                                }
                              },
                              icon: Image.asset(
                                "assets/images/pen_ic.png",
                                color: Colors.white,
                                width: 20,
                                height: 20,
                              ),
                            ),
                          )
                        ]),
                      ),
                      Obx(() => textView25(
                          context: context,
                          text: Get.find<UserProfileController>().getUserprofileModel.fName != ''
                              ? '${Get.find<UserProfileController>().getUserprofileModel.fName} ${Get.find<UserProfileController>().getUserprofileModel.lName}'
                              : 'Guest User',
                          color: ColorResource.darkTextColor)),
                      Obx(
                        () => textView15(
                            context: context,
                            text: Get.find<UserProfileController>().getUserprofileModel.phone.toString(),
                            maxLine: 1,
                            color: ColorResource.darkTextColor),
                      ),
                      Container(
                        height: 123,
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(30),
                        decoration: customDecoration(radius: 20, shadowBlur: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                if (Get.find<AuthController>().isSignIn()) {
                                  Get.to(() => const WishlistView());
                                } else {
                                  signInDialogView(context);
                                }
                              },
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                direction: Axis.vertical,
                                children: [
                                  Image.asset(
                                    "assets/images/love_ic.png",
                                    width: 37,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: textView15(
                                        context: context,
                                        text: 'wishlist'.tr,
                                        maxLine: 1,
                                        color: ColorResource.darkTextColor,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            const VerticalDivider(
                              color: ColorResource.hintTextColor,
                              thickness: 0.5,
                            ),
                            InkWell(
                              onTap: () {
                                if (Get.find<AuthController>().isSignIn()) {
                                  Get.to(() => const OffersView());
                                } else {
                                  signInDialogView(context);
                                }
                              },
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                direction: Axis.vertical,
                                children: [
                                  Image.asset(
                                    "assets/images/offer_ic.png",
                                    width: 37,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: textView15(
                                        context: context,
                                        text: 'offers'.tr,
                                        maxLine: 1,
                                        color: ColorResource.darkTextColor,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            const VerticalDivider(
                              color: ColorResource.hintTextColor,
                              thickness: 0.5,
                            ),
                            InkWell(
                              onTap: () {
                                if (Get.find<AuthController>().isSignIn()) {
                                  Get.to(() => const SupportCenterView());
                                } else {
                                  signInDialogView(context);
                                }
                              },
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                direction: Axis.vertical,
                                children: [
                                  Image.asset(
                                    "assets/images/profile_ic.png",
                                    width: 37,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: textView15(
                                        context: context,
                                        text: 'support'.tr,
                                        maxLine: 1,
                                        color: ColorResource.darkTextColor,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              MasonryGridView.count(
                  itemCount: widgetList.length,
                  crossAxisCount: 1,
                  padding: const EdgeInsets.only(bottom: 5, left: 15, right: 15),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        if (index == 6 || index == 5) {
                          Get.to(() => widgetList[index].widget!);
                        } else {
                          if (Get.find<AuthController>().isSignIn()) {
                            Get.to(() => widgetList[index].widget!);
                            // Navigator.of(context).push(PageRouteBuilder(
                            //   opaque: false,
                            //   barrierDismissible: true,
                            //   transitionDuration: Duration(milliseconds: 2000),
                            //   pageBuilder: (context, anim1, anim2) => widgetList[index].widget!,
                            // ));
                          } else {
                            signInDialogView(widget.globalContext);
                          }
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        margin: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              widgetList[index].image.toString(),
                              width: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child:
                                    textView15(context: context, text: widgetList[index].name.toString(), maxLine: 1))
                          ],
                        ),
                      ),
                    );
                  }),
            ]),
            Obx(() => loaderFullScreenView(context, Get.find<UserProfileController>().loader.value))
          ],
        ),
      ),
      topSafeArea: false,
      onRefresh: () async {
        initData();
      },
    );
  }
}

class ItemSetting {
  String? name;
  String? image;
  Widget? widget;

  ItemSetting({this.name, this.image, this.widget});
}
