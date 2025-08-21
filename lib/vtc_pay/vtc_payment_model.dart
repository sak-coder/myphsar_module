class VtcPaymentModel {
  int? id;
  String? reqTime;
  String? merchantId;
  String? tranId;
  double? amount;
  String? hash;

  VtcPaymentModel({
    this.id,
    this.reqTime,
    this.merchantId,
    this.tranId,
    this.amount,
    this.hash,
  });

  VtcPaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reqTime = json['req_time'];
    merchantId = json['merchant_id'];
    tranId = json['tran_id'];
    amount = double.parse(json['amount'].toString());
    hash = json['hash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['req_time'] = reqTime;
    data['merchant_id'] = merchantId;
    data['tran_id'] = tranId;
    data['amount'] = amount;
    data['hash'] = hash;
    return data;
  }
}
