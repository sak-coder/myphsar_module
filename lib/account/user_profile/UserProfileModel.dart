class UserProfileModel {
  int? id;
  String? name;
  String? fName;
  String? lName;
  String? phone;
  String? image;
  String? email;

//	String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  // Null? streetAddress;
  // Null? country;
  // Null? city;
  // Null? zip;
  // Null? houseNo;
  // Null? apartmentNo;
  // Null? cmFirebaseToken;
  int? isActive;

//	Null? paymentCardLastFour;
//	Null? paymentCardBrand;
//	Null? paymentCardFawryToken;
//	Null? loginMedium;
//	Null? socialId;
  int? isPhoneVerified;
  String? temporaryToken;
  int? isEmailVerified;
  String? deletedAt;

  UserProfileModel(
      {this.id,
      this.name,
      this.fName,
      this.lName,
      this.phone,
      this.image,
      this.email,
      //	this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      //	this.streetAddress,
      //	this.country,
      //	this.city,
      //	this.zip,
      //	this.houseNo,
      //	this.apartmentNo,
      //	this.cmFirebaseToken,
      //	this.isActive,
      //	this.paymentCardLastFour,
      //	this.paymentCardBrand,
      //this.paymentCardFawryToken,
      //this.loginMedium,
      //this.socialId,
      this.isPhoneVerified,
      this.temporaryToken,
      this.isEmailVerified,
      this.deletedAt});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    image = json['image'];
    email = json['email'];
    //	emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    //	streetAddress = json['street_address'];
    //	country = json['country'];
    //	city = json['city'];
    //	zip = json['zip'];
    //	houseNo = json['house_no'];
    //	apartmentNo = json['apartment_no'];
    //	cmFirebaseToken = json['cm_firebase_token'];
    isActive = json['is_active'];
    //	paymentCardLastFour = json['payment_card_last_four'];
    //	paymentCardBrand = json['payment_card_brand'];
    //	paymentCardFawryToken = json['payment_card_fawry_token'];
    //	loginMedium = json['login_medium'];
    //socialId = json['social_id'];
    isPhoneVerified = json['is_phone_verified'];
    temporaryToken = json['temporary_token'];
    isEmailVerified = json['is_email_verified'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['image'] = image;
    data['email'] = email;
    //	data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    //	data['street_address'] = this.streetAddress;
    //	data['country'] = this.country;
    //	data['city'] = this.city;
    //	data['zip'] = this.zip;
    //	data['house_no'] = this.houseNo;
    //	data['apartment_no'] = this.apartmentNo;
    //	data['cm_firebase_token'] = this.cmFirebaseToken;
    data['is_active'] = isActive;
    //	data['payment_card_last_four'] = this.paymentCardLastFour;
    //	data['payment_card_brand'] = this.paymentCardBrand;
    //	data['payment_card_fawry_token'] = this.paymentCardFawryToken;
    //	data['login_medium'] = this.loginMedium;
    //data['social_id'] = this.socialId;
    data['is_phone_verified'] = isPhoneVerified;
    data['temporary_token'] = temporaryToken;
    data['is_email_verified'] = isEmailVerified;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class ParamUserProfileModel {
  int? id;
  String? name;
  String? method;
  String? fName;
  String? lName;
  String? phone;
  String? image;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  ParamUserProfileModel(
      {this.id,
      this.name,
      this.method,
      this.fName,
      this.lName,
      this.phone,
      this.image,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  ParamUserProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    method = json['_method'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    image = json['image'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['_method'] = method;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['image'] = image;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
