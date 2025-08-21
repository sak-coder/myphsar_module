import 'package:myphsar/home/seller/seller_model.dart';

class ShopProfileModel {
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? image;
  int? verified;
  SellerModel? shop;

  ShopProfileModel({this.id, this.fName, this.lName, this.phone, this.image, this.verified, this.shop});

  ShopProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    image = json['image'];
    verified = json['verified'];
    shop = json['shop'] != null ? SellerModel.fromJson(json['shop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;

    if (image != null) {
      data['image'] = image;
    } else {
      data['image'] = '';
    }

    if (shop != null) {
      data['shop'] = shop!.toJson();
    }
    return data;
  }
}
//
// class Shop {
// 	int? id;
// 	int? sellerId;
// 	String? name;
// 	String? address;
// 	String? contact;
// 	String? image;
// 	String? createdAt;
// 	String? updatedAt;
// 	String? banner;
//
// 	Shop(
// 			{this.id,
// 				this.sellerId,
// 				this.name,
// 				this.address,
// 				this.contact,
// 				this.image,
// 				this.createdAt,
// 				this.updatedAt,
// 				this.banner});
//
// 	Shop.fromJson(Map<String, dynamic> json) {
// 		id = json['id'];
// 		sellerId = json['seller_id'];
// 		name = json['name'];
// 		address = json['address'];
// 		contact = json['contact'];
// 		image = json['image']!=null?json['image']:'' ;
// 		createdAt = json['created_at'];
// 		updatedAt = json['updated_at'];
// 		banner = json['banner'];
// 	}
//
// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['id'] = this.id;
// 		data['seller_id'] = this.sellerId;
// 		data['name'] = this.name;
// 		data['address'] = this.address;
// 		data['contact'] = this.contact;
// 		data['image'] = this.image;
// 		data['created_at'] = this.createdAt;
// 		data['updated_at'] = this.updatedAt;
// 		data['banner'] = this.banner;
// 		return data;
// 	}
// }
