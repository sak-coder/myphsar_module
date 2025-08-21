class FlashDealModel {
  int? id;
  String? title;
  String? startDate;
  String? endDate;
  int? status;
  int? featured;
  String? backgroundColor;
  String? textColor;
  String? banner;
  String? slug;
  String? createdAt;
  String? updatedAt;
  String? productId;
  String? dealType;

  FlashDealModel(
      {this.id,
      this.title,
      this.startDate,
      this.endDate,
      this.status,
      this.featured,
      this.backgroundColor,
      this.textColor,
      this.banner,
      this.slug,
      this.createdAt,
      this.updatedAt,
      this.productId,
      this.dealType});

  FlashDealModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    featured = json['featured'];
    backgroundColor = json['background_color'];
    textColor = json['text_color'];
    banner = json['banner'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productId = json['product_id'];
    dealType = json['deal_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status;
    data['featured'] = featured;
    data['background_color'] = backgroundColor;
    data['text_color'] = textColor;
    data['banner'] = banner;
    data['slug'] = slug;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['product_id'] = productId;
    data['deal_type'] = dealType;
    return data;
  }
}
