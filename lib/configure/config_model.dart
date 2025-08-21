class ConfigModel {
  int? systemDefaultCurrency;
  bool? digitalPayment;
  BaseUrls? baseUrls;

  // StaticUrls? staticUrls;
  String? termsConditions;
  String? privacyPolicy;
  String? aboutUs;
  List<CurrencyList>? currencyList;
  String? currencySymbolPosition;
  bool? maintenanceMode;
  List<Language>? language;

  //pagination_limit
  // List<String>? unit;
  String? shippingMethod;
  bool? emailVerification;
  bool? phoneVerification;
  String? countryCode;
  List<SocialLogin>? socialLogin;
  List<Faq>? faq;
  String? currencyModel;
  String? forgotPasswordVerification;

  ConfigModel(
      {this.systemDefaultCurrency,
      this.digitalPayment,
      this.baseUrls,
      // this.staticUrls,
      this.termsConditions,
      this.privacyPolicy,
      this.aboutUs,
      this.currencyList,
      this.currencySymbolPosition,
      this.maintenanceMode,
      this.language,
      // this.unit,
      this.shippingMethod,
      this.emailVerification,
      this.phoneVerification,
      this.countryCode,
      this.socialLogin,
      this.faq,
      this.currencyModel,
      this.forgotPasswordVerification});

  ConfigModel.fromJson(Map<String, dynamic> json) {
    systemDefaultCurrency = json['system_default_currency'];
    digitalPayment = json['digital_payment'];
    baseUrls = json['base_urls'] != null ? BaseUrls.fromJson(json['base_urls']) : null;
    // staticUrls = json['static_urls'] != null ? StaticUrls.fromJson(json['static_urls']) : null;

    termsConditions = json['terms_&_conditions'];
    privacyPolicy = json['privacy_policy'];
    aboutUs = json['about_us'];
    if (json['currency_list'] != null) {
      currencyList = <CurrencyList>[];
      json['currency_list'].forEach((v) {
        currencyList!.add(CurrencyList.fromJson(v));
      });
    }
    currencySymbolPosition = json['currency_symbol_position'];
    maintenanceMode = json['maintenance_mode'];
    if (json['language'] != null) {
      language = <Language>[];
      json['language'].forEach((v) {
        language!.add(Language.fromJson(v));
      });
    }
    // unit = json['unit'].cast<String>();
    shippingMethod = json['shipping_method'];
    emailVerification = json['email_verification'];
    phoneVerification = json['phone_verification'];
    countryCode = json['country_code'];
    if (json['social_login'] != null) {
      socialLogin = <SocialLogin>[];
      json['social_login'].forEach((v) {
        socialLogin!.add(SocialLogin.fromJson(v));
      });
    }
    if (json['faq'] != null) {
      faq = <Faq>[];
      json['faq'].forEach((v) {
        faq!.add(Faq.fromJson(v));
      });
    }
    currencyModel = json['currency_model'];
    forgotPasswordVerification = json['forgot_password_verification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['system_default_currency'] = systemDefaultCurrency;
    data['digital_payment'] = digitalPayment;
    if (baseUrls != null) {
      data['base_urls'] = baseUrls!.toJson();
    }
    // if (staticUrls != null) {
    //   data['static_urls'] = staticUrls!.toJson();
    // }

    // if (faq != null) {
    // 	data['faq'] = faq!.map((v) => v.toJson()).toList();
    // }
    data['privacy_policy'] = privacyPolicy;
    data['terms_&_conditions'] = termsConditions;
    data['about_us'] = aboutUs;
    if (currencyList != null) {
      data['currency_list'] = currencyList!.map((v) => v.toJson()).toList();
    }
    data['currency_symbol_position'] = currencySymbolPosition;
    data['maintenance_mode'] = maintenanceMode;
    if (language != null) {
      data['language'] = language!.map((v) => v.toJson()).toList();
    }
    // data['unit'] = unit;
    data['shipping_method'] = shippingMethod;
    data['email_verification'] = emailVerification;
    data['phone_verification'] = phoneVerification;
    data['country_code'] = countryCode;
    if (socialLogin != null) {
      data['social_login'] = socialLogin!.map((v) => v.toJson()).toList();
    }
    data['currency_model'] = currencyModel;
    data['forgot_password_verification'] = forgotPasswordVerification;
    return data;
  }
}

class BaseUrls {
  String? baseProductImageUrl;
  String? baseProductThumbnailUrl;
  String? baseBrandImageUrl;
  String? baseCustomerImageUrl;
  String? baseBannerImageUrl;
  String? baseCategoryImageUrl;
  String? baseReviewImageUrl;
  String? baseSellerImageUrl;
  String? baseShopImageUrl;
  String? baseNotificationImageUrl;

  BaseUrls(
      {this.baseProductImageUrl,
      this.baseProductThumbnailUrl,
      this.baseBrandImageUrl,
      this.baseCustomerImageUrl,
      this.baseBannerImageUrl,
      this.baseCategoryImageUrl,
      this.baseReviewImageUrl,
      this.baseSellerImageUrl,
      this.baseShopImageUrl,
      this.baseNotificationImageUrl});

  BaseUrls.fromJson(Map<String, dynamic> json) {
    baseProductImageUrl = json['product_image_url'];
    baseProductThumbnailUrl = json['product_thumbnail_url'];
    baseBrandImageUrl = json['brand_image_url'];
    baseCustomerImageUrl = json['customer_image_url'];
    baseBannerImageUrl = json['banner_image_url'];
    baseCategoryImageUrl = json['category_image_url'];
    baseReviewImageUrl = json['review_image_url'];
    baseSellerImageUrl = json['seller_image_url'];
    baseShopImageUrl = json['shop_image_url'];
    baseNotificationImageUrl = json['notification_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_image_url'] = baseProductImageUrl;
    data['product_thumbnail_url'] = baseProductThumbnailUrl;
    data['brand_image_url'] = baseBrandImageUrl;
    data['customer_image_url'] = baseCustomerImageUrl;
    data['banner_image_url'] = baseBannerImageUrl;
    data['category_image_url'] = baseCategoryImageUrl;
    data['review_image_url'] = baseReviewImageUrl;
    data['seller_image_url'] = baseSellerImageUrl;
    data['shop_image_url'] = baseShopImageUrl;
    data['notification_image_url'] = baseNotificationImageUrl;
    return data;
  }
}

class StaticUrls {
  String? contactUs;
  String? brands;
  String? categories;
  String? customerAccount;

  StaticUrls({this.contactUs, this.brands, this.categories, this.customerAccount});

  StaticUrls.fromJson(Map<String, dynamic> json) {
    contactUs = json['contact_us'];
    brands = json['brands'];
    categories = json['categories'];
    customerAccount = json['customer_account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contact_us'] = contactUs;
    data['brands'] = brands;
    data['categories'] = categories;
    data['customer_account'] = customerAccount;
    return data;
  }
}

class CurrencyList {
  int? id;
  String? name;
  String? symbol;
  String? code;
  int? exchangeRate;
  int? status;

  // String? createdAt;
  String? updatedAt;

  CurrencyList({this.id, this.name, this.symbol, this.code, this.exchangeRate, this.status, this.updatedAt});

  CurrencyList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    code = json['code'];
    exchangeRate = json['exchange_rate'];
    status = json['status'];
    // createdAt =  json['created_at']== null? "": json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['symbol'] = symbol;
    data['code'] = code;
    data['exchange_rate'] = exchangeRate;
    data['status'] = status;
    // data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Language {
  String? code;
  String? name;

  Language({this.code, this.name});

  Language.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}

class SocialLogin {
  String? loginMedium;
  bool? status;

  SocialLogin({this.loginMedium, this.status});

  SocialLogin.fromJson(Map<String, dynamic> json) {
    loginMedium = json['login_medium'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['login_medium'] = loginMedium;
    data['status'] = status;
    return data;
  }
}

class Faq {
  int? id;
  String? question;
  String? answer;
  int? ranking;
  int? status;
  String? createdAt;
  String? updatedAt;

  Faq({this.id, this.question, this.answer, this.ranking, this.status, this.createdAt, this.updatedAt});

  Faq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    ranking = json['ranking'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    data['ranking'] = ranking;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
