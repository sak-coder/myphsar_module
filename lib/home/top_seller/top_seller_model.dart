class TopSellerModel {
  int? id;
  int? sellerId;
  String? name;
  String? address;
  String? contact;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? banner;
  List<String>? productImages;

  TopSellerModel(
      {this.id,
      this.sellerId,
      this.name,
      this.address,
      this.contact,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.banner,
      this.productImages});

  TopSellerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    name = json['name'];
    address = json['address'];
    contact = json['contact'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    banner = json['banner'];
    productImages = json['product_images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['seller_id'] = sellerId;
    data['name'] = name;
    data['address'] = address;
    data['contact'] = contact;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['banner'] = banner;
    data['product_images'] = productImages;
    return data;
  }
}
