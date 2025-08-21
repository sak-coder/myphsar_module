class SellerModel {
  int? id;
  int? sellerId;
  String? name;
  String? address;
  String? contact;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? banner;
  String? email;
  Seller? seller;

  SellerModel(
      {this.id,
      this.sellerId,
      this.name,
      this.address,
      this.contact,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.seller,
      this.banner,
      this.email});

  SellerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    name = json['name'];
    address = json['address'];
    contact = json['contact'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    banner = json['banner'];
    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    email = json['email'];
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
    data['email'] = email;
    if (seller != null) {
      data['seller'] = seller!.toJson();
    }
    return data;
  }
}

class Seller {
  int? id;
  int? verified;

  Seller({this.id, this.verified});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['verified'] = verified;
    return data;
  }
}
