class AvailableOnlinePaymentModel {
  List<PaymentMethods>? paymentMethods;

  AvailableOnlinePaymentModel({this.paymentMethods});

  AvailableOnlinePaymentModel.fromJson(Map<String, dynamic> json) {
    if (json['payment_methods'] != null) {
      paymentMethods = <PaymentMethods>[];
      json['payment_methods'].forEach((v) {
        paymentMethods!.add(PaymentMethods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymentMethods != null) {
      data['payment_methods'] = paymentMethods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentMethods {
  int? id;
  String? lLogo;
  String? title;
  String? description;
  String? subLogo;
  String? paymentOption;

  PaymentMethods({this.id, this.lLogo, this.title, this.description, this.subLogo, this.paymentOption});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lLogo = json['l_logo'];
    title = json['title'];
    description = json['description'];
    subLogo = json['sub_logo'].toString();
    paymentOption = json['payment_option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['l_logo'] = lLogo;
    data['title'] = title;
    data['description'] = description;
    data['sub_logo'] = subLogo;
    data['payment_option'] = paymentOption;
    return data;
  }
}
