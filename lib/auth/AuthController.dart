import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myphsar/auth/AuthModel.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/base_provider.dart';
import 'package:myphsar/base_widget/snack_bar_message.dart';
import 'package:myphsar/helper/share_pref_controller.dart';
import '../account/address/ParamAddAddressModel.dart';
import '../account/user_profile/UserProfileModel.dart';
import '../account/user_profile/user_profile_controller.dart';
import '../base_widget/custom_bottom_sheet_dialog.dart';
import 'SignUpErrorModel.dart';
import 'SingUpView/SignUpModel.dart';
import 'facebook/FacebookLoginModel.dart';
import 'facebook/FacebookLoginModelParam.dart';

class AuthController extends BaseController {
  var isLoading = false.obs;
  final BaseProvider _baseProvider;
  static const List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: scopes,
  // );
  final _facebookLoginModel = FacebookLoginModel().obs;

  FacebookLoginModel get getFacebookLoginModel => _facebookLoginModel.value;

  AuthController(this._baseProvider);

  late Map userData;

  //late LoginResult result;

  void resetLoader() {
    isLoading.value = false;
  }

  // Future<void> googleSignIn(BuildContext context) async {
  //   _googleSignIn.signIn();
  //   _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) async {
  //     // In mobile, being authenticated means being authorized...
  //     bool isAuthorized = account != null;
  //     // // However, on web...
  //     if (kIsWeb && account != null) {
  //       isAuthorized = await _googleSignIn.canAccessScopes(scopes);
  //     }
  //
  //     if (isAuthorized) {
  //       var token = await _googleSignIn.currentUser!.authentication;
  //       await socialSignUp(
  //           context,
  //           SocialLoginModelParam(
  //               medium: "google",
  //               token: token.accessToken.toString(),
  //               email: account!.email.toString(),
  //               uniqueId: account.id.toString(),
  //               name: account.displayName.toString()));
  //     }
  //   });
  // }

  Future appleSingIn() async {}

  //
  // Future fbLogin(BuildContext context) async {
  //   LoginResult result = await FacebookAuth.i.login(permissions: ['email', 'public_profile']);
  //
  //   if (result.status == LoginStatus.success) {
  //     final userData = await FacebookAuth.i.getUserData(
  //       fields: "name,email",
  //     );
  //
  //     //   var profileImage = userData['picture']['data']['url'];
  //
  //     var token = result.accessToken;
  //     var userId = result.accessToken;
  //     //
  //     _facebookLoginModel.value = FacebookLoginModel.fromJson(userData);
  //
  //     isLoading.value = true;
  //
  //     await socialSignUp(
  //         context,
  //         SocialLoginModelParam(
  //             medium: "facebook",
  //             token: token.toString(),
  //             email: _facebookLoginModel.value.email,
  //             uniqueId: userId.toString(),
  //             name: _facebookLoginModel.value.name))
  //         .then((value) => {
  //               if (value.statusCode == 200)
  //                 {
  //                   isLoading.value = false,
  //                   Get.find<SharePrefController>().saveToken(value.body['token'], () {
  //                     _baseProvider.updateToken(value.body['token']);
  //                     updateToken();
  //                     Get.find<UserProfileController>().getUserProfile(
  //                         context,
  //                         (isGetUser) => {
  //                               if (isGetUser)
  //                                 {Navigator.of(context).pop()}
  //                               else
  //                                 {
  //                                   Get.find<UserProfileController>().saveTemporaryProfile(UserProfileModel(
  //                                       fName: _facebookLoginModel.value.name,
  //                                       lName: "",
  //                                       email: _facebookLoginModel.value.email)),
  //                                   Navigator.of(context).pop()
  //                                 }
  //                             });
  //                   }),
  //                 }
  //               else
  //                 {
  //                   isLoading.value = false,
  //                   customErrorBottomDialog(
  //                       context, ("Error Code=" + value.statusCode.toString() + " \n" + value.statusText.toString())),
  //                 }
  //             });
  //   }
  // }

  Future socialSignUp(BuildContext context, SocialLoginModelParam param) async {
    await _baseProvider.socialSignUp(param).then((value) => {
          if (value.statusCode == 200)
            {
              isLoading.value = false,
              Get.find<SharePrefController>().saveToken(value.body['token'], () {
                _baseProvider.updateToken(value.body['token']);
              //  updateToken();
                Get.find<UserProfileController>().getUserProfile(
                    context,
                    (isGetUser) => {
                          if (isGetUser)
                            {Navigator.of(context).pop()}
                          else
                            {
                              Get.find<UserProfileController>().saveTemporaryProfile(UserProfileModel(
                                  fName: _facebookLoginModel.value.name,
                                  lName: "",
                                  email: _facebookLoginModel.value.email)),
                              Navigator.of(context).pop()
                            }
                        });
              }),
            }
          else
            {
              isLoading.value = false,
              customErrorBottomDialog(context, ("Error Code=${value.statusCode} \n${value.statusText}")),
            }
        });
  }

  // Future<void> fbLogOut() async {
  //   await FacebookAuth.instance.logOut();
  // }

  Future singUp(SingUpModel singUpModel, BuildContext context, Function(bool) callback) async {
    isLoading.value = true;

    await _baseProvider.signUp(singUpModel).then((value) => {
          if (value.statusCode == 200)
            {
              isLoading.value = false,
              Get.find<SharePrefController>().saveToken(value.body['token'], () {
                _baseProvider.updateToken(value.body['token']);
              //  updateToken();
                callback(true);
              }),
            }
          else
            {
              isLoading.value = false,
              if (context.mounted)
                {
                  snackBarMessage(context,
                      "${SignUpErrorModel.fromJson(value.body).errors!.first.message}\n${SignUpErrorModel.fromJson(value.body).errors!.last.message}")
                },
              callback(false)
            }
        });
  }

  Future signIn(AuthModel authModel, BuildContext context) async {
    isLoading.value = true;
    await _baseProvider.signIn(authModel).then((value) => {
          if (value.statusCode == 200)
            {
              isLoading.value = false,
              Get.find<SharePrefController>().saveToken(value.body['token'], () async {
                _baseProvider.updateToken(value.body['token']);
               // updateToken();
                await Get.find<UserProfileController>().getUserProfile(context, (val) {});
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }),
            }
          else
            {
              isLoading.value = false,
              if (value.statusCode == 401)
                {
                  snackBarMessage(context, 'login_error_msg'.tr),
                }
              else
                {
                  snackBarMessage(context, ("Error Code=${value.statusCode} \n${value.statusText}")),
                }
            }
        });
  }

  Future addAddress(ParamAddAddressModel authModel, BuildContext context) async {
    isLoading.value = true;
    await _baseProvider.addAddressApiProvider(authModel).then((value) => {
          if (value.statusCode == 200)
            {}
          else
            {
              isLoading.value = false,
              snackBarMessage(context, ("Error Code=${value.statusCode} \n${value.statusText}")),
            }
        });
  }

  Future deleteAccount(BuildContext context) async {
    await _baseProvider.deleteAccountApiProvider().then((value) => {
          if (value.statusCode == 200)
            {Get.find<AuthController>().logOut(context)}
          else
            {snackBarMessage(context, "Error Code: ${value.statusCode}\nMessage: ${value.statusCode}")}
        });
  }

  Future updateToken() async {
    //  var firebaseMessaging = FirebaseMessaging.instance;
       // _baseProvider.updateDeviceToken(firebaseMessaging.getToken().toString()).then((value) => {});
  }
  void logOut(BuildContext context) async {
    Get.find<SharePrefController>().logOut();
    Get.find<UserProfileController>().removeAccount();

    // if (await _googleSignIn.isSignedIn()) {
    //   await _googleSignIn.signOut();
    // } else {
    //    await FacebookAuth.instance.logOut();
    // }

    Navigator.pop(context);
  }

  bool isSignIn() {
    return Get.find<SharePrefController>().getUserToken().isNotEmpty;
  }

  Future resetPassword(
      {required BuildContext context,
      required String identity,
      required String otp,
      required String password,
      required String confirmPwd}) async {
    isLoading.value = true;
    await _baseProvider.resetPasswordApiProvider(identity, otp, password, confirmPwd).then((value) => {
          if (password != confirmPwd) {snackBarMessage(context, "${value.statusText}")},
          if (value.statusCode == 200)
            {isLoading.value = false, Navigator.pop(context)}
          else
            {isLoading.value = false, snackBarMessage(context, "${value.statusText}")}
        });
  }

  Future verifyOtp(
      {required BuildContext context,
      required String identity,
      required String otp,
      required Function callback}) async {
    isLoading.value = true;
    return await _baseProvider.verifyOtpApiProvider(identity, otp).then((value) => {

          if (value.statusCode == 200)
            {isLoading.value = false, callback()}
          else
            {isLoading.value = false, snackBarMessage(context, "${value.statusText}")}
        });
  }

  Future forgetPassword(BuildContext context, String identity, Function() callback) async {
    isLoading.value = true;

    return await _baseProvider.forgetPasswordApiProvider(identity).then((value) => {

          if (value.statusCode == 200)
            {isLoading.value = false, callback()}
          else
            {isLoading.value = false, snackBarMessage(context, '${value.body['message']}')}
        });
  }
}
