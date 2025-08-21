import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as Img;
import 'package:image/image.dart';
import 'package:myphsar/account/address/ParamAddAddressModel.dart';
import 'package:myphsar/helper/share_pref_controller.dart';
import 'package:myphsar/reviews/review_body_model.dart';

import 'account/support/SupportTicketParam.dart';
import 'account/user_profile/UserProfileModel.dart';
import 'app_constants.dart';
import 'auth/AuthModel.dart';
import 'auth/SingUpView/SignUpModel.dart';
import 'auth/facebook/FacebookLoginModelParam.dart';
import 'chat/chat_room/message_param_model.dart';
import 'installment/submit_installment_body.dart';

class BaseProvider extends GetConnect {
  final String configBaseUrl;

  BaseProvider(this.configBaseUrl);

  @override
  void onInit() {
    var token = Get.find<SharePrefController>().getUserToken();
    print("F>> Token= $token");

    httpClient.baseUrl = configBaseUrl;
    httpClient.timeout = const Duration(seconds: 50);

    httpClient.addRequestModifier((Request request) {
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'application/json';
      request.headers['lang'] = Get.find<SharePrefController>().getLocalLanguage().languageCode;
      return request;
    });

    super.onInit();
  }

  Future updateToken(String token) async {
    httpClient.addRequestModifier((Request request) {
      request.headers['Authorization'] = 'Bearer $token';
      return request;
    });
  }

  Future<Response> getSearchRecommendApiProvider(String name){

    return get("/api/v1/products/get-recommended-search?name=$name&limit=10");
  }

  Future<Response> getSearchProductApiProvider(

      String name, int offset, String minPrice, String maxPrice, String? catId) async {

    // httpClient.addRequestModifier((Request request) {
    //   request.headers['lang'] = Get.find<SharePrefController>().getLocalLanguage().languageCode;
    //   return request;
    // });
    catId ??= '';
    return get(
        "/api/v1/products/search?name=$name&limit=30&offset=$offset&min_price=$minPrice&max_price=$maxPrice&category_id=$catId");
  }

  Future<Response> getRelatedProductApiProvider(String productId) async {
    return get(AppConstants.RELATED_PRODUCT_URI + productId);
  }

  Future<Response> getProductCountApiProvider(String productId) async {
    return get(AppConstants.COUNTER_URI + productId);
  }

  Future<Response> getReviewApiProvider(String productId) async {
    return get(AppConstants.PRODUCT_REVIEW_URI + productId);
  }

  Future<Response> getSellerProfileApiProvider(String sellerId) async {
    return get(AppConstants.SELLER_URI + sellerId);
  }

  Future<Response> getAllShopProductApiProvider(String id, String offset) async {
    return get("${AppConstants.SELLER_PRODUCT_URI}$id/products?limit=20&&offset=$offset");
  }

  Future<Response> getShareProductLinkApiProvider(String productId) async {
    return get(AppConstants.SOCIAL_LINK_URI + productId);
  }

  Future<Response> getUserprofileApiProvider() async {
    return get(AppConstants.CUSTOMER_URI);
  }

  Future<http.StreamedResponse> updateProfileApiProvider(ParamUserProfileModel userInfoModel,
      {String? pass, File? file}) async {
    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse('${AppConstants.PRO_BASE_URL}${AppConstants.UPDATE_PROFILE_URI}'));
    request.headers
        .addAll(<String, String>{'Authorization': 'Bearer ${Get.find<SharePrefController>().getUserToken()}'});
    if (file != null) {
      request.files.add(http.MultipartFile('image', file.readAsBytes().asStream(), file.lengthSync(),
          filename: file.path.split('/').last));
    }
    Map<String, String> fields = {};
    if (pass == null) {
      fields.addAll(<String, String>{
        '_method': 'put',
        'f_name': userInfoModel.fName!,
        'l_name': userInfoModel.lName!,
        'email': userInfoModel.email!,
        'phone': userInfoModel.phone!
      });
    } else {
      fields.addAll(<String, String>{
        '_method': 'put',
        'f_name': userInfoModel.fName!,
        'l_name': userInfoModel.lName!,
        'email': userInfoModel.email!,
        'phone': userInfoModel.phone!,
        'password': pass
      });
    }
    request.fields.addAll(fields);

    http.StreamedResponse response = await request.send();
    return response;
    //  print("F>> post= "+userProfileModel.toJson().toString());
    // return await put(AppConstants.UPDATE_PROFILE_URI,userProfileModel.toJson(),);
  }

  Future<Response> getAddressListApiProvider() async {
    return get(AppConstants.ADDRESS_LIST_URI);
  }

  Future<Response> getShippingMethodListApiProvider() async {
    return get(AppConstants.SHIPPING_URI_V1);
  }

  Future<Response> addAddressApiProvider(ParamAddAddressModel paramAddAddressModel) async {
    return post(AppConstants.ADD_ADDRESS_URI, paramAddAddressModel.toJson());
  }

  Future<Response> deleteAccountApiProvider() async {
    return delete(AppConstants.REMOVE_ACCOUNT_URI);
  }

  Future<http.StreamedResponse> deleteAddressApiProvider(String id) async {
    http.MultipartRequest request =
        http.MultipartRequest('DELETE', Uri.parse('$configBaseUrl${AppConstants.REMOVE_ADDRESS_URI + id}'));
    request.headers
        .addAll(<String, String>{'Authorization': 'Bearer ${Get.find<SharePrefController>().getUserToken()}'});
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<Response> addWishlistApiProvider(Map productId) async {
    return post(AppConstants.ADD_WISH_LIST_URI, productId);
  }

  Future<Response> removeWishlistApiProvider(String productId) async {
    return delete(AppConstants.REMOVE_WISH_LIST_URI + productId);
  }

  Future<Response> getAllWishlistApiProvider() async {
    return get(AppConstants.WISH_LIST_GET_URI);
  }

  Future<Response> getProductDetailApiProvider(String productId) async {
    return get(AppConstants.PRODUCT_DETAILS_URI + productId);
  }

  Future<Response> getOfferApiProvider() async {
    return get("${AppConstants.FOOTER_BANNER_URI}footer_banner");
  }

  Future<Response> sendSupportTicketApiProvider(SupportTicketParamModel supportTicketParamModel) async {
    return post(AppConstants.SUPPORT_TICKET_URI, supportTicketParamModel.toJson());
  }

  Future<Response> getSupportTicketListApiProvider() async {
    return get(AppConstants.SUPPORT_TICKET_GET_URI);
  }

  Future<Response> getSupportReplyListApiProvider(String ticketID) async {
    return get(AppConstants.SUPPORT_TICKET_CONV_URI + ticketID);
  }

  Future<Response> sendReplyApiProvider(String ticketID, String messageText) async {
    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['message'] = messageText;
      return data;
    }

    return post(AppConstants.SUPPORT_TICKET_REPLY_URI + ticketID, toJson());
  }

  Future<Response> getAllNotificationApiProvider() async {
    return get(AppConstants.NOTIFICATION_URI);
  }

  Future<Response> getAllChatApiProvider() async {
    return get(AppConstants.CHAT_INFO_URI);
  }

  Future<Response> getChatWithShopApiProvider(String id) async {
    return get(AppConstants.MESSAGES_URI + id);
  }

  Future<Response> sendChatMessageApiProvider(MessageParamModel messageParamModel) async {
    return post(AppConstants.SEND_MESSAGE_URI, messageParamModel.toJson());
  }

  Future<Response> getAllSellerApiProvider() {
    return get(AppConstants.ALL_SELLER);
  }

  Future<Response> signIn(AuthModel authModel) async {
    return post(AppConstants.LOGIN_URI, authModel.toJson());
  }

  Future<Response> signUp(SingUpModel singUpModel) {
    return post(AppConstants.REGISTRATION_URI, singUpModel.toJson());
  }

  Future<Response> socialSignUp(SocialLoginModelParam fbModel) {
    return post(AppConstants.SOCIAL_LOGIN_URI, fbModel.toJson());
  }

  // Future<Response> addShippingMethod(Map<String, dynamic> param) async {
  //   return post(AppConstants.CHOOSE_SHIPPING_METHOD, param);
  // }

  Future<Response> addToCartApiProvider(Map<String, dynamic> param) {
    return post(AppConstants.ADD_TO_CART_URI, param);
  }

  Future<Response> getCartListApiProvider() {
    return get(AppConstants.GET_CART_DATA_URI);
  }

  Future<Response> updateCartProductApiProvider(Map<String, dynamic> param) async {
    return put(AppConstants.UPDATE_CART_QUANTITY_URI, param);
  }

  Future deleteCartProductApiProvider(Map<String, dynamic> param) async {
    return delete(AppConstants.REMOVE_FROM_CART_URI, query: param);
  }

  Future deleteAllCartProductApiProvider() async {
    return get(AppConstants.REMOVE_ALL_CART);
  }

  Future placeOrderApiProvider(String addressId, String couponCode) async {
    return get('${AppConstants.ORDER_PLACE_URI}?address_id=$addressId&coupon_code=$couponCode');
  }

  Future<Response> getOrderHistoryApiProvider() async {
    return get(AppConstants.ORDER_URI);
  }

  Future<Response> getOrderHistoryDetailApiProvider(String orderId) async {
    return get(AppConstants.ORDER_DETAILS_URI + orderId);
  }

  Future<Response> getTrackingApiProvider(String orderId) async {
    return get(AppConstants.TRACKING_URI + orderId);
  }

  Future<Response> getCeTrackingApiProvider(String orderId) async {
    return get(AppConstants.CE_TRACKING_URI + orderId);
  }

  Future<Response> reviewsProductApiProvider(ReviewBodyModel reviewBodyModel) async {
    // final formData = FormData({});
    //
    // formData.fields.add(MapEntry("product_id", reviewBodyModel.productId.toString()));
    // formData.fields.add(MapEntry("comment", reviewBodyModel.comment.toString()));
    // formData.fields.add(MapEntry("rating", reviewBodyModel.rating.toString()));

    // if (reviewBodyModel.fileUpload != null) {
    //   reviewBodyModel.fileUpload!.forEach((path) {
    //     formData.fields.add(MapEntry("fileUpload[]", MultipartFile(File(path), filename: "${DateTime.now().millisecondsSinceEpoch}.${path.split('.').last}").toString()));
    //   });
    // }

    //   FormData _formData = FormData({
    //   'product_id': reviewBodyModel.productId,
    //   'comment': reviewBodyModel.comment,
    //   'rating': reviewBodyModel.rating,
    //   // 'fileUpload': MultipartFile(File(reviewBodyModel.fileUpload![0].path), filename: reviewBodyModel.fileUpload![0].path+".jpg",)
    // },
    return post(AppConstants.SUBMIT_REVIEW_URI, reviewBodyModel.toJson());
  }

  Future<Response> getNewArrivalProductApiProvider(String offset) async {
    return get(AppConstants.NEW_ARRIVAL_PRODUCTS_URI + offset);
  }

  Future<Response> getNewArrivalCategoryApiProvider(String offset) async {
    return get(AppConstants.HOME_CATEGORY_PRODUCTS_URI + offset);
  }

  Future<Response> getBestSellingApiProvider(String offset) async {
    return get(AppConstants.BEST_SELLING_PRODUCTS_URI + offset);
  }

  Future<Response> getAbaPayHashParamProvider(
      String shippingAddressData, String addressId, String couponCode, double couponDiscount) async {
    return get(
        '${AppConstants.ABA_PAY_URI}?shipping_address_data=$shippingAddressData&address_id=$addressId&coupon_code=$couponCode&coupon_discount=$couponDiscount');
  }

  Future<Response> getPaymentStatusProvider(String tranId) async {
    Map<String, dynamic> id = {'tran_id': tranId};
    return post(AppConstants.ABA_PAY_STATUS_URI, id);
  }

  Future<Response> getInstallmentPaymentStatusProvider(String uuid) async {
    Map<String, dynamic> id = {'uuid': uuid};
    return post(AppConstants.SUBMIT_CHECKOUT_INSTALLMENT_URI, id);
  }

  Future<Response> getPaymentHashProvider(
      {required String id, required String currency, required String addressId}) async {
    Map<String, String> param = {'currency_code': currency, 'address_id': addressId};
    return get(AppConstants.AVAILABLE_ONLINE_PAY_HASH + id, query: param);
  }

  Future<Response> getCcuPaymentHashProvider({required String id, required String currency}) async {
    Map<String, String> param = {'currency_code': currency};
    return get(AppConstants.AVAILABLE_ONLINE_PAY_HASH + id, query: param);
  }

  Future<Response> getAvailableInstallmentsPaymentProvider(
      {required String installmentsUuid,
      required String lenderId,
      required String paymentId,
      required String currency,
      required String addressId}) async {
    Map<String, String> param = {'currency_code': currency};

    return get("${AppConstants.AVAILABLE_ONLINE_INSTALLMENT_PAY_URI}$installmentsUuid/$lenderId/$paymentId",
        query: param);
  }

  Future<Response> getAvailableOnlinePaymentProvider() async {
    return get(AppConstants.AVAILABLE_ONLINE_PAYMENT);
  }

  Future<Response> getAvailableInstallmentsOnlinePaymentProvider(String lenderId) async {
    return get(AppConstants.AVAILABLE_INSTALLMENT_ONLINE_PAYMENT + lenderId);
  }

  Future<Response> getCityApiProvider() async {
    return get(AppConstants.CITY_URI);
  }

  Future<Response> getJobTypeApiProvider() async {
    return get(AppConstants.JOB_TYPE_URI);
  }

  Future<Response> getInstallmentTermApiProvider() async {
    return get(AppConstants.INSTALLMENTS_DURATION_URI);
  }

  Future<Response> getBannerApiProvider(String bannerType) async {
    return get(AppConstants.MAIN_BANNER_URI + bannerType);
  }

  Future<Response> getInstallmentProductApiProvider(String offset) async {
    return get(AppConstants.INSTALLMENTS_PRODUCT_URI + offset);
  }

  Future<Response> getAvailableLenderApiProvider(String uuid) async {
    return get(AppConstants.AVAILABLE_LENDER_URI + uuid);
  }

  Future<Response> getLenderDetailApiProvider(String id) async {
    return get(AppConstants.LENDER_DETAIL_URI + id);
  }

  Future<Response> getCalculationTableApiProvider(String uuid) async {
    return get(AppConstants.INSTALLMENT_TABLE_URI + uuid);
  }

  Future<Response> submitSelectedLenderApiProvider(String uuid, String lenderId) async {
    Map<String, String> shippingParam = {'uuid': uuid, 'financier_id': lenderId};
    return post(AppConstants.SELECT_FINANCIER_URI, shippingParam);
  }

  Future<Response> getInstallmentCheckOutDetailApiProvider(String uuid) async {
    return get(AppConstants.INSTALLMENT_CHECKOUT_DETAIL_URI + uuid);
  }

  Future<Response> getInstallmentsHistoryApiProvider() async {
    return get(AppConstants.INSTALLMENT_LIST_URI);
  }

  Future<Response> getInstallmentsHistoryDetailApiProvider(String uuid) async {
    return get(AppConstants.INSTALLMENT_HISTORY_DETAIL_URI + uuid);
  }

  Future<http.StreamedResponse> installmentsPlaceOrder(String url) async {
    // const startWord = "v1/";
    // final startIndex = url.indexOf(startWord);
    // final String endUrl = url.substring(startIndex + startWord.length);
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers
        .addAll(<String, String>{'Authorization': 'Bearer ${Get.find<SharePrefController>().getUserToken()}'});
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> submitInstallmentForm(
    SubmitInstallmentBody submitInstallmentBody,
    File frontImage,
    File selfie,
  ) async {
    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse('$configBaseUrl${AppConstants.SUBMIT_INSTALLMENTS_URI}'));
    request.headers
        .addAll(<String, String>{'Authorization': 'Bearer ${Get.find<SharePrefController>().getUserToken()}'});
    Img.Image? frontImageTemp = Img.decodeImage(frontImage.readAsBytesSync());
    Img.Image? selfieImageTemp = Img.decodeImage(selfie.readAsBytesSync());
    final fImage = copyResize(frontImageTemp!, width: 500);
    final bImage = copyResize(selfieImageTemp!, width: 500);

    // Save the thumbnail as a PNG.
    File(frontImage.absolute.path).writeAsBytesSync(encodePng(fImage));
    File(selfie.absolute.path).writeAsBytesSync(encodePng(bImage));

    request.files.add(http.MultipartFile('card_id', frontImage.readAsBytes().asStream(), frontImage.lengthSync(),
        filename: frontImage.path.split('/').last));
    request.files.add(http.MultipartFile('card_id_back', selfie.readAsBytes().asStream(), selfie.lengthSync(),
        filename: selfie.path.split('/').last));

    Map<String, String> fields = {};
    fields.addAll(submitInstallmentBody.toJson());
    request.fields.addAll(fields);

    http.StreamedResponse response = await request.send();
    return response;
  }

  // Future<Response> requestOtpApiProvider(String phoneNumber,String temporaryToken) async {
  //   Map<String, String> param ={"phone": phoneNumber, "temporary_token" :temporaryToken};
  //
  //   return post(AppConstants.VERIFY_OTP_URI, param);
  // }

  Future<Response> verifyOtpApiProvider(String identity, String otp) async {
    Map<String, String> param = {"identity": identity, "otp": otp};

    return post(AppConstants.VERIFY_OTP_URI, param);
  }
  Future<Response> forgetPasswordApiProvider(String identity) async {
    Map<String, String> param = {"identity": identity};

    return post(AppConstants.FORGET_PASSWORD_URI, param);
  }

  Future<Response> updateDeviceToken(String token) async {
    Map<String, String> param = {"cm_firebase_token": token};
    return put(AppConstants.FIREBASE_TOKEN_URI, param);
  }

  Future<Response> resetPasswordApiProvider(
      String identity, String otp, String password, String confirmPassword) async {
    Map<String, String> param = {
      'identity': identity,
      'otp': otp,
      'password': password,
      "confirm_password": confirmPassword
    };

    return put(AppConstants.RESET_PASSWORD_URI, param);
  }


  Future<Response> readChatMessageApiProvider(String shopId) async {
    Map<String, String> param = {"shop_id": shopId};
    return post(AppConstants.READ_CHAT_URI, param);
  }

  Future<Response> checkVtnTransactionApiProvider(String tranId) async {
    Map<String, String> param = {'tran_id': tranId};
    return get(AppConstants.CHECK_TRANSACTION_URI, query: param);
  }

  Future<Response> checkInstallmentsTransactionApiProvider(String tranId) async {
    return get(AppConstants.CHECK_INSTALLMENTS_TRANSACTION_URI + tranId);
  }

  Future<Response> getConfig() async {
    return get(AppConstants.CONFIG_URI);
  }

  Future<Response> getCeCityProvider() async {
    return get(AppConstants.CE_GET_AVAILABLE_CITY_URI);
  }

  Future<Response> checkDeliveryFeeProvider(
      {required String cartId, required String shippingId, required shippingMethodId}) async {
    Map<String, String> param = {
      'cart_group_id': cartId,
      'shipping_address_id': shippingId,
      'shipping_method_id': shippingMethodId
    };
    return get(AppConstants.CE_CHECK_DELIVERY_URI, query: param);
  }

  Future<Response> checkChoosingDeliveryMethodProvider(
      {required String groupCartId,
      required String shippingAddressId,
      required String shippingMethodId,
      required bool isCE}) async {
    if (isCE) {
      Map<String, String> param = {
        'cart_group_id': groupCartId,
        'shipping_address_id': shippingAddressId,
        'shipping_method_id': shippingMethodId
      };

      return get(AppConstants.CE_CHECK_SHIPPING_METHOD_URI, query: param);
    } else {
      Map<String, String> param = {'cart_group_id': groupCartId, 'id': shippingMethodId};
      return post(AppConstants.CHOOSE_SHIPPING_METHOD, param);
    }
  }

  Future<Response> checkStatusDeliveryMethodProvider() async {
    return get(AppConstants.CE_CHECK_CHOSEN_SHIPPING_METHOD_URI);
  }

  Future<Response> getFlashDealApiProvider() async {
    return get(AppConstants.FLASH_DEAL_URI);
  }

  Future<Response> getFlashDealProductListApiProvider(String id) async {
    return get(AppConstants.FLASH_DEAL_PRODUCT_URI + id);
  }

  Future<Response> getRandomLatestProductApiProvider(String offset) async {
    return get(AppConstants.RANDOM_PRODUCTS_URI + offset);
    //	return _getConnect.get("https://myphsar.com/api/v1/products/search?name=20% OFF LOR Hand Wash Shampoo 3.50L KHH");
  }

  Future<Response> getTopSellerApiProvider() async {
    return get(AppConstants.TOP_SELLER);
  }

  Future<Response> getTopSellerProductApiProvider(String id, String offset) async {
    return get("${AppConstants.SELLER_PRODUCT_URI}$id/products?limit=4&&offset=$offset");
  }

  Future<Response> getRecommendApiProvider(String offset) async {
    return get(AppConstants.FEATURED_PRODUCTS_URI + offset);
  }

  Future<Response> getDailyDealApiProvider() async {
    return get(AppConstants.FEATURED_DEAL_URI);
  }

  Future<Response> getAllBrandsApiProvider() async {
    return get(AppConstants.BRANDS_URI);
  }

  Future<Response> getAllCategoryApiProvider() async {
    return get(AppConstants.CATEGORIES_URI);
  }

  Future<Response> getAllCategoryDetailApiProvider(String id, String offset) async {
    return get("${AppConstants.CATEGORY_PRODUCT_URI}$id/?limit=30&&offset=$offset");
  }


}
