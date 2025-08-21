import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myphsar/app_constants.dart';
import 'package:myphsar/account/address/shipping/shipping_method_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../account/user_profile/UserProfileModel.dart';

class SharePrefProvider {
  final SharedPreferences sharedPreferences;

  SharePrefProvider(this.sharedPreferences);

  final String _firstTimeOpenKey = "first_open_key";
  final String _lCodeKey = "languageCode";
  final String _cCodeKey = "countryCode";

  final String _userProfileKey = "user_profile_key";

  Future setFirstTimeOpenProvider(bool status) async {
    await sharedPreferences.setBool(_firstTimeOpenKey, status);
  }

  bool? getFirstTimeOpenProvider() {
    return sharedPreferences.getBool(_firstTimeOpenKey);
  }

  Future saveLocalLanguageProvider({required String lCode, required String cCode}) async {
    await sharedPreferences.setString(_lCodeKey, lCode);
    await sharedPreferences.setString(_cCodeKey, cCode);
  }

  Locale getSaveLanguageProvider() {
    return sharedPreferences.getString(_lCodeKey) != null
        ? Locale(sharedPreferences.getString(_lCodeKey)!, sharedPreferences.getString(_cCodeKey))
        : const Locale("en", 'US');

  }

  Future saveUserTokenProvider(String token) async {
    await sharedPreferences.remove(AppConstants.TOKEN);
    await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  String? getUserTokenProvider() {
    return sharedPreferences.getString(AppConstants.TOKEN);
  }

  Future signOut() async {
    removeUserProfileProvider();
    await sharedPreferences.remove(AppConstants.TOKEN);
  }

  Future saveUserProfileProvider({required UserProfileModel userProfileModel}) async {
    await sharedPreferences.setString(_userProfileKey, jsonEncode(userProfileModel));
  }

  Future saveSearchKeyList(List<String> list) async {
    await sharedPreferences.setStringList(AppConstants.SEARCH_KEY, list);
  }

  Future saveSearchHistoryProvider({required String searchKey}) async {
    List<String>? searchKeyword = getSearchHistoryProvider();
    if (searchKeyword != null) {
      if (!searchKeyword.contains(searchKey)) {
        searchKeyword.add(searchKey);
      }
      saveSearchKeyList(searchKeyword);
    }
  }

  Future removeSearchKey() async {
    await sharedPreferences.remove(AppConstants.SEARCH_KEY);
  }

  List<String>? getSearchHistoryProvider() {
    if (sharedPreferences.getStringList(AppConstants.SEARCH_KEY) == null) {
      return [];
    } else {
      return sharedPreferences.getStringList(AppConstants.SEARCH_KEY);
    }
  }

  Future saveShippingMethodProvider({required String shippingMethodModel}) async {
    await sharedPreferences.setString(AppConstants.SHIPPING_METHOD, jsonEncode(shippingMethodModel));
  }

  Future removeShippingMethodProvider() async {
    await sharedPreferences.remove(AppConstants.SHIPPING_METHOD);
  }

  Future removeUserProfileProvider() async {
    await sharedPreferences.remove(_userProfileKey);
  }

  Future<List<ShippingMethodModel>> getShippingMethodProvider() async {
    var shippingMethodModel = <ShippingMethodModel>[];

    jsonDecode(sharedPreferences.getString(AppConstants.SHIPPING_METHOD)!).forEach(
      (ShippingMethodModel value) => {
        shippingMethodModel.add(value),
      },
    );
    return shippingMethodModel;
    // return ShippingMethodModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.SHIPPING_METHOD)!));
  }

  UserProfileModel getUserProfileProvider() {
    if (sharedPreferences.getString(_userProfileKey) == null) {
      return UserProfileModel(fName: '', lName: '', email: '', phone: '', image: '');
    } else {
      // print("F>> Get user"+ UserProfileModel.fromJson(jsonDecode(sharedPreferences.getString(_userProfileKey)!)).toJson().toString());
      return UserProfileModel.fromJson(jsonDecode(sharedPreferences.getString(_userProfileKey)!));
    }
  }
}
