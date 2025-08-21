class WishlistModel {
  String? id;
  String? name;
  double? unitPrice;
  String? thumbnail;
  double? discount;
  String? discountType;

  WishlistModel({
    this.id,
    this.name,
    this.unitPrice,
    this.thumbnail,
    this.discount,
    this.discountType,
  });

  WishlistModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    unitPrice = double.tryParse(json['unit_price'].toString());
    thumbnail = json['thumbnail'] ?? "";
    discount = double.tryParse(json['discount'].toString());
    discountType = json['discount_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['unit_price'] = unitPrice;
    data['thumbnail'] = thumbnail;
    data['discount'] = discount;
    data['discount_type'] = discountType;
    return data;
  }
}
