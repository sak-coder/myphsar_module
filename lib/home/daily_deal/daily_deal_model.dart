import '../../product/product_model.dart';

class DailyDealModel {
  int? id;
  int? flashDealId;
  int? productId;
  int? discount;
  String? discountType;
  String? createdAt;
  String? updatedAt;
  Products? product;

  DailyDealModel(
      {this.id,
      this.flashDealId,
      this.productId,
      this.discount,
      this.discountType,
      this.createdAt,
      this.updatedAt,
      this.product});

  DailyDealModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    flashDealId = json['flash_deal_id'];
    productId = json['product_id'];
    discount = json['discount'];
    discountType = json['discount_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = json['product'] != null ? Products.fromJson(json['product']) : Products();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['flash_deal_id'] = flashDealId;
    data['product_id'] = productId;
    data['discount'] = discount;
    data['discount_type'] = discountType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}
