import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/account/address/shipping/shipping_method_model.dart';
import 'package:myphsar/helper/share_pref_provider.dart';

import '../account/user_profile/UserProfileModel.dart';

class SharePrefController extends GetxController {
  final SharePrefProvider _sharePrefProvider;

  SharePrefController(this._sharePrefProvider);

  Future setFirstTimeOpen(bool status) async {
    await _sharePrefProvider.setFirstTimeOpenProvider(status);
  }

  bool? getFirstTimeOpen() {
    return _sharePrefProvider.getFirstTimeOpenProvider();
  }

  Future saveLocalLanguage({required String lCode, required String cCOde}) async {
    await _sharePrefProvider.saveLocalLanguageProvider(lCode: lCode, cCode: cCOde);
  }

  Locale getLocalLanguage() {
    return _sharePrefProvider.getSaveLanguageProvider();
  }

  Future saveToken(String token,Function() callback) async {
    await _sharePrefProvider.saveUserTokenProvider(token).then((value) => {
      callback()
    });
  }

  String getUserToken() {
    if (_sharePrefProvider.getUserTokenProvider() == null) {
      return "";
    } else {
      return _sharePrefProvider.getUserTokenProvider()!;
    }
  }

  Future saveUserProfile(UserProfileModel userProfileModel) async {
    await _sharePrefProvider.saveUserProfileProvider(userProfileModel: userProfileModel);
  }

  Future removeSearchKeyWord(String keyword) async {
    List<String> newListKey = getSaveSearchHistory();
    for (int i = 0; i < newListKey.length; i++) {
      if (keyword.contains(newListKey[i])) {
        newListKey.removeAt(i);
        _sharePrefProvider.removeSearchKey();
        _sharePrefProvider.saveSearchKeyList(newListKey);
      }
    }
  }

  Future saveSearchHistory(String searchKeyWord) async {

    await _sharePrefProvider.saveSearchHistoryProvider(searchKey: searchKeyWord);
  }

  List<String> getSaveSearchHistory() {
    List<String> list = _sharePrefProvider.getSearchHistoryProvider()!.reversed.toList();
    // list.sort((a, b){
    //   return a.compareTo(b);});
    return list;
  }

  Future saveShippingMethodProfile(String shippingMethodModel) async {
    await _sharePrefProvider.saveShippingMethodProvider(shippingMethodModel: shippingMethodModel);
  }

  Future<List<ShippingMethodModel>> getShippingMethod() async {
    return _sharePrefProvider.getShippingMethodProvider();
  }

  UserProfileModel getUserProfile() {
    return _sharePrefProvider.getUserProfileProvider();
  }

  logOut() {
    return _sharePrefProvider.signOut();
  }
}
