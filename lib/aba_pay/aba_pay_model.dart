class AbaPayModel {
  Aba? aba;

  AbaPayModel({this.aba});

  AbaPayModel.fromJson(Map<String, dynamic> json) {
    aba = json['aba'] != null ? Aba.fromJson(json['aba']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (aba != null) {
      data['aba'] = aba!.toJson();
    }
    return data;
  }
}

class Aba {
  AbaCardData? data;

  Aba({this.data});

  Aba.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? AbaCardData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class AbaCardData {
  AbaCard? card;
  DeepLink? deepLink;

  AbaCardData({this.card, this.deepLink});

  AbaCardData.fromJson(Map<String, dynamic> json) {
    card = json['card'] != null ? AbaCard.fromJson(json['card']) : null;
    deepLink = json['deep_link'] != null ? DeepLink.fromJson(json['deep_link']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (card != null) {
      data['card'] = card!.toJson();
    }
    if (deepLink != null) {
      data['deep_link'] = deepLink!.toJson();
    }
    return data;
  }
}

class AbaCard {
  String? reqTime;
  String? merchantId;
  String? tranId;
  String? amount;
  String? items;
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  String? paymentOption;
  String? returnUrl;
  String? continueSuccessUrl;
  bool? status;
  String? embed;
  String? logo;

  AbaCard(
      {this.reqTime,
      this.merchantId,
      this.tranId,
      this.amount,
      this.items,
      this.firstname,
      this.lastname,
      this.email,
      this.phone,
      this.paymentOption,
      this.returnUrl,
      this.continueSuccessUrl,
      this.status,
      this.embed,
      this.logo});

  AbaCard.fromJson(Map<String, dynamic> json) {
    reqTime = json['req_time'];
    merchantId = json['merchant_id'];
    tranId = json['tran_id'];
    amount = json['amount'];
    items = json['items'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phone = json['phone'];
    paymentOption = json['payment_option'];
    returnUrl = json['return_url'];
    continueSuccessUrl = json['continue_success_url'];
    status = json['status'];
    embed = json['embed'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['req_time'] = reqTime;
    data['merchant_id'] = merchantId;
    data['tran_id'] = tranId;
    data['amount'] = amount;
    data['items'] = items;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['phone'] = phone;
    data['payment_option'] = paymentOption;
    data['return_url'] = returnUrl;
    data['continue_success_url'] = continueSuccessUrl;
    data['status'] = status;
    data['embed'] = embed;
    data['logo'] = logo;
    return data;
  }
}

class DeepLink {
  String? reqTime;
  String? merchantId;
  String? tranId;
  String? amount;
  String? items;
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  String? paymentOption;
  String? returnUrl;
  String? continueSuccessUrl;
  String? hash;
  String? qrString;
  String? abapayDeeplink;
  String? appStore;
  String? playStore;
  bool? status;

  DeepLink(
      {this.reqTime,
      this.merchantId,
      this.tranId,
      this.amount,
      this.items,
      this.firstname,
      this.lastname,
      this.email,
      this.phone,
      this.paymentOption,
      this.returnUrl,
      this.continueSuccessUrl,
      this.hash,
      this.qrString,
      this.abapayDeeplink,
      this.appStore,
      this.playStore,
      this.status});

  DeepLink.fromJson(Map<String, dynamic> json) {
    reqTime = json['req_time'];
    merchantId = json['merchant_id'];
    tranId = json['tran_id'];
    amount = json['amount'];
    items = json['items'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phone = json['phone'];
    paymentOption = json['payment_option'];
    returnUrl = json['return_url'];
    continueSuccessUrl = json['continue_success_url'];
    hash = json['hash'];
    qrString = json['qrString'];
    abapayDeeplink = json['abapay_deeplink'];
    appStore = json['app_store'];
    playStore = json['play_store'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['req_time'] = reqTime;
    data['merchant_id'] = merchantId;
    data['tran_id'] = tranId;
    data['amount'] = amount;
    data['items'] = items;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['phone'] = phone;
    data['payment_option'] = paymentOption;
    data['return_url'] = returnUrl;
    data['continue_success_url'] = continueSuccessUrl;
    data['hash'] = hash;
    data['qrString'] = qrString;
    data['abapay_deeplink'] = abapayDeeplink;
    data['app_store'] = appStore;
    data['play_store'] = playStore;
    data['status'] = status;
    return data;
  }
}

class AbaPaymentStatusModel {
  int? status;
  String? message;

  AbaPaymentStatusModel({this.status, this.message}) {
    status = status;
    message = message;
  }

  AbaPaymentStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class ABASuccessResponse {
  int? status;
  String? message;

  ABASuccessResponse({this.status, this.message});

  ABASuccessResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
