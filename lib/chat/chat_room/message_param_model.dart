class MessageParamModel {
  String? sellerId;
  String? shopId;
  String? message;

  MessageParamModel({this.sellerId, this.shopId, this.message});

  MessageParamModel.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
    shopId = json['shop_id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seller_id'] = sellerId;
    data['shop_id'] = shopId;
    data['message'] = message;
    return data;
  }
}
