import '../../aba_pay/aba_pay_model.dart';

class InstallmentCheckoutDetailModel {
  Data? data;

  InstallmentCheckoutDetailModel({this.data});

  InstallmentCheckoutDetailModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? productName;
  String? financeOrg;
  int? interestRate;
  int? downPayment;
  int? installmentFee;
  int? installmentDuration;
  String? totalProductPricing;
  String? totalInterestRate;
  String? totalDownPaymentWithServiceFee;
  String? totalOutStandingBalance;
  bool? allowZeroPayment;
  InstallmentsPaymentMethods? paymentMethods;

  Data(
      {this.productName,
      this.financeOrg,
      this.interestRate,
      this.downPayment,
      this.installmentFee,
      this.installmentDuration,
      this.totalProductPricing,
      this.totalInterestRate,
      this.totalDownPaymentWithServiceFee,
      this.totalOutStandingBalance,
      this.allowZeroPayment,
      this.paymentMethods});

  Data.fromJson(Map<String?, dynamic> json) {
    productName = json['product_name'];
    financeOrg = json['finance_org'];
    interestRate = json['interest_rate'];
    downPayment = json['down_payment'];
    installmentFee = json['installment_fee'];
    installmentDuration = json['installment_duration'];
    totalProductPricing = json['total_product_pricing'];
    totalInterestRate = json['total_interest_rate'];
    totalDownPaymentWithServiceFee = json['total_down_payment_with_service_fee'];
    totalOutStandingBalance = json['total_out_standing_balance'];
    allowZeroPayment = json['allow_zero_payment'];
    paymentMethods =
        json['payment_methods'] != null ? InstallmentsPaymentMethods.fromJson(json['payment_methods']) : null;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['product_name'] = productName;
    data['finance_org'] = financeOrg;
    data['interest_rate'] = interestRate;
    data['down_payment'] = downPayment;
    data['installment_fee'] = installmentFee;
    data['installment_duration'] = installmentDuration;
    data['total_product_pricing'] = totalProductPricing;
    data['total_interest_rate'] = totalInterestRate;
    data['total_down_payment_with_service_fee'] = totalDownPaymentWithServiceFee;
    data['total_out_standing_balance'] = totalOutStandingBalance;
    data['allow_zero_payment'] = allowZeroPayment;
    if (paymentMethods != null) {
      data['payment_methods'] = paymentMethods?.toJson();
    }
    return data;
  }
}

class InstallmentsPaymentMethods {
  String? zeroPayment;
  Aba? aba;

  InstallmentsPaymentMethods({this.zeroPayment, this.aba});

  InstallmentsPaymentMethods.fromJson(Map<String?, dynamic> json) {
    zeroPayment = json['zero_payment'];
    aba = json['aba'] != null ? Aba.fromJson(json['aba']) : null;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    data['zero_payment'] = zeroPayment;
    if (aba != null) {
      data['aba'] = aba!.toJson();
    }
    return data;
  }
}

class Aba {
  AbaCard? card;
  DeepLink? deepLink;

  Aba({this.card, this.deepLink});

  Aba.fromJson(Map<String?, dynamic> json) {
    card = json['card'] != null ? AbaCard.fromJson(json['card']) : null;
    deepLink = json['deep_link'] != null ? DeepLink.fromJson(json['deep_link']) : null;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = <String?, dynamic>{};
    if (card != null) {
      data['card'] = card!.toJson();
    }
    if (deepLink != null) {
      data['deep_link'] = deepLink!.toJson();
    }
    return data;
  }
}
