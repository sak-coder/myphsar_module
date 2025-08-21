class ReviewModel {
  int? id;
  int? productId;
  int? customerId;
  String? comment;
 // List<Null>? attachment;
  int? rating;
  int? status;
  String? createdAt;
  String? updatedAt;
  Customer? customer;

  ReviewModel(
      {this.id,
      this.productId,
      this.customerId,
      this.comment,
    //  this.attachment,
      this.rating,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.customer});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    customerId = json['customer_id'];
    comment = json['comment'];
    // if (json['attachment'] != null) {
    // 	attachment = <Null>[];
    // 	json['attachment'].forEach((v) {
    // 		attachment!.add(new Null.fromJson(v));
    // 	});
    // }
    rating = json['rating'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null ? new Customer.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['product_id'] = productId;
    data['customer_id'] = customerId;
    data['comment'] = comment;
    // if (this.attachment != null) {
    //   data['attachment'] = this.attachment!.map((v) => v.toJson()).toList();
    // }
    data['rating'] = rating;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}

class Customer {
  int? id;
  // Null? name;
  String? fName;
  String? lName;

 //String? phone;
  String? image;

  //String? email;
  // Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  // Null? streetAddress;
  // Null? country;
  // Null? city;
  // Null? zip;
  // Null? houseNo;
  // Null? apartmentNo;
  // String? cmFirebaseToken;
  // int? isActive;
  // Null? paymentCardLastFour;
  // Null? paymentCardBrand;
  // Null? paymentCardFawryToken;
  // String? loginMedium;
  // String? socialId;
  // int? isPhoneVerified;
  // String? temporaryToken;
  // int? isEmailVerified;
  // Null? deletedAt;

  Customer({
    this.id,
    //		this.name,
    this.fName,
    this.lName,
    // this.phone,
    this.image,
    //	this.email,
    //	this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    // this.streetAddress,
    // this.country,
    // this.city,
    // this.zip,
    // this.houseNo,
    // this.apartmentNo,
    // this.cmFirebaseToken,
    // this.isActive,
    // this.paymentCardLastFour,
    // this.paymentCardBrand,
    // this.paymentCardFawryToken,
    // this.loginMedium,
    // this.socialId,
    // this.isPhoneVerified,
    // this.temporaryToken,
    // this.isEmailVerified,
    // this.deletedAt
  });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    //	name = json['name'];
    fName = json['f_name'];
    lName = json['l_name'];
    //	phone = json['phone'];
    image = json['image'];
    // email = json['email'];
    // emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    //	streetAddress = json['street_address'];
    // 	country = json['country'];
    // 	city = json['city'];
    // 	zip = json['zip'];
    // 	houseNo = json['house_no'];
    // 	apartmentNo = json['apartment_no'];
    // 	cmFirebaseToken = json['cm_firebase_token'];
    // 	isActive = json['is_active'];
    // 	paymentCardLastFour = json['payment_card_last_four'];
    // 	paymentCardBrand = json['payment_card_brand'];
    // 	paymentCardFawryToken = json['payment_card_fawry_token'];
    // 	loginMedium = json['login_medium'];
    // 	socialId = json['social_id'];
    // 	isPhoneVerified = json['is_phone_verified'];
    // 	temporaryToken = json['temporary_token'];
    // 	isEmailVerified = json['is_email_verified'];
    // 	deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    //	data['name'] = this.name;
    data['f_name'] = fName;
    data['l_name'] = lName;
    // data['phone'] = this.phone;
    data['image'] = image;
    // data['email'] = this.email;
    // data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    // data['street_address'] = this.streetAddress;
    // data['country'] = this.country;
    // data['city'] = this.city;
    // data['zip'] = this.zip;
    // data['house_no'] = this.houseNo;
    // data['apartment_no'] = this.apartmentNo;
    // data['cm_firebase_token'] = this.cmFirebaseToken;
    // data['is_active'] = this.isActive;
    // data['payment_card_last_four'] = this.paymentCardLastFour;
    // data['payment_card_brand'] = this.paymentCardBrand;
    // data['payment_card_fawry_token'] = this.paymentCardFawryToken;
    // data['login_medium'] = this.loginMedium;
    // data['social_id'] = this.socialId;
    // data['is_phone_verified'] = this.isPhoneVerified;
    // data['temporary_token'] = this.temporaryToken;
    // data['is_email_verified'] = this.isEmailVerified;
    // data['deleted_at'] = this.deletedAt;
    return data;
  }
}
