import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/helper/share_pref_controller.dart';

import '../../base_provider.dart';
import '../../base_widget/snack_bar_message.dart';
import 'UserProfileModel.dart';

class UserProfileController extends BaseController {
  final BaseProvider baseProvider;
  var loader = false.obs;

  UserProfileController(this.baseProvider);

  var userProfileModel = UserProfileModel().obs;

  UserProfileModel get getUserprofileModel => userProfileModel.value;

  void removeAccount() {
    userProfileModel.value = Get.find<SharePrefController>().getUserProfile();
  }

  void getGuestUser() {
    userProfileModel.value = Get.find<SharePrefController>().getUserProfile();
  }

  void saveTemporaryProfile(UserProfileModel model) {
    userProfileModel.value = model;
  }

  Future getUserProfile(BuildContext context, Function(bool) callback) async {
    loader.value = true;
    userProfileModel.value = Get.find<SharePrefController>().getUserProfile();
    await baseProvider.getUserprofileApiProvider().then((value) async => {
          if (value.statusCode == 200)
            {
              userProfileModel.value = UserProfileModel.fromJson(value.body),
              await Get.find<SharePrefController>().saveUserProfile(userProfileModel.value),
              loader.value = false,
              callback(true),
            }
          else
            {
              loader.value = false,
              if (context.mounted)
                {
                  snackBarMessage(context, (value.statusText.toString())),
                },
              callback(false),
            }
        });
  }

  Future updateUserInfo(
      {required ParamUserProfileModel updateUserModel,
      String? pass,
      File? imageFile,
      required BuildContext context}) async {
    var updateUser = UserProfileModel(
      lName: updateUserModel.lName,
      fName: updateUserModel.fName,
      email: updateUserModel.email,
      phone: updateUserModel.phone,
    );

    http.StreamedResponse response =
        await baseProvider.updateProfileApiProvider(updateUserModel, pass: pass, file: imageFile);
    if (response.statusCode == 200) {
      Get.find<SharePrefController>().saveUserProfile(updateUser);
      userProfileModel.value = updateUser;

      if (context.mounted) {
        snackBarMessage(context, "update_success".tr, bgColor: Colors.green);
      }
    } else {
      if (context.mounted) {
        snackBarMessage(context, "update_failed".tr);
      }
    }
  }
}
