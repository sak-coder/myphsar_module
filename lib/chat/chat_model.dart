class ChatModel {
	LastChat? lastChat;
	List<ChatMessageList>? chatList;
	List<UniqueShops>? uniqueShops;

	ChatModel({this.lastChat, this.chatList, this.uniqueShops});

	ChatModel.fromJson(Map<String, dynamic> json) {
		lastChat = json['last_chat'] != null
				? LastChat.fromJson(json['last_chat'])
				: null;
		if (json['chat_list'] != null) {
			chatList = <ChatMessageList>[];
			json['chat_list'].forEach((v) {
				chatList!.add(ChatMessageList.fromJson(v));
			});
		}
		if (json['unique_shops'] != null) {
			uniqueShops = <UniqueShops>[];
			json['unique_shops'].forEach((v) {
				uniqueShops!.add(UniqueShops.fromJson(v));
			});
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		if (lastChat != null) {
			data['last_chat'] = lastChat!.toJson();
		}
		if (chatList != null) {
			data['chat_list'] = chatList!.map((v) => v.toJson()).toList();
		}
		if (uniqueShops != null) {
			data['unique_shops'] = uniqueShops!.map((v) => v.toJson()).toList();
		}
		return data;
	}
}

class LastChat {
	int? id;
	int? userId;
	int? sellerId;
	String? message;
	int? sentByCustomer;
	int? sentBySeller;
	int? seenByCustomer;
	int? seenBySeller;
	int? status;
	String? createdAt;
	String? updatedAt;
	int? shopId;
	SellerInfo? sellerInfo;
	Customer? customer;
	Shop? shop;

	LastChat(
			{this.id,
				this.userId,
				this.sellerId,
				this.message,
				this.sentByCustomer,
				this.sentBySeller,
				this.seenByCustomer,
				this.seenBySeller,
				this.status,
				this.createdAt,
				this.updatedAt,
				this.shopId,
				this.sellerInfo,
				this.customer,
				this.shop});

	LastChat.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		userId = json['user_id'];
		sellerId = json['seller_id'];
		message = json['message'];
		sentByCustomer = json['sent_by_customer'];
		sentBySeller = json['sent_by_seller'];
		seenByCustomer = json['seen_by_customer'];
		seenBySeller = json['seen_by_seller'];
		status = json['status'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
		shopId = json['shop_id'];
		sellerInfo = json['seller_info'] != null
				? SellerInfo.fromJson(json['seller_info'])
				: null;
		customer = json['customer'] != null
				? Customer.fromJson(json['customer'])
				: null;
		shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['user_id'] = userId;
		data['seller_id'] = sellerId;
		data['message'] = message;
		data['sent_by_customer'] = sentByCustomer;
		data['sent_by_seller'] = sentBySeller;
		data['seen_by_customer'] = seenByCustomer;
		data['seen_by_seller'] = seenBySeller;
		data['status'] = status;
		data['created_at'] = createdAt;
		data['updated_at'] = updatedAt;
		data['shop_id'] = shopId;
		if (sellerInfo != null) {
			data['seller_info'] = sellerInfo!.toJson();
		}
		if (customer != null) {
			data['customer'] = customer!.toJson();
		}
		if (shop != null) {
			data['shop'] = shop!.toJson();
		}
		return data;
	}
}

class SellerInfo {
	int? id;
	String? fName;
	String? lName;
	String? phone;
	String? image;
	String? email;
	String? password;
	String? status;
	String? rememberToken;
	String? createdAt;
	String? updatedAt;
	// Null? bankName;
	// Null? branch;
	// Null? accountNo;
	// Null? holderName;
	// Null? authToken;
	// Null? salesCommissionPercentage;
	// Null? telGroupId;
	// Null? gst;

	SellerInfo(
			{this.id,
				this.fName,
				this.lName,
				this.phone,
				this.image,
				this.email,
				this.password,
				this.status,
				this.rememberToken,
				this.createdAt,
				this.updatedAt,
				// this.bankName,
				// this.branch,
				// this.accountNo,
				// this.holderName,
				// this.authToken,
				// this.salesCommissionPercentage,
				// this.telGroupId,
				// this.gst
			});

	SellerInfo.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		fName = json['f_name'];
		lName = json['l_name'];
		phone = json['phone'];
		image = json['image'];
		email = json['email'];
		password = json['password'];
		status = json['status'];
		rememberToken = json['remember_token'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
		// bankName = json['bank_name'];
		// branch = json['branch'];
		// accountNo = json['account_no'];
		// holderName = json['holder_name'];
		// authToken = json['auth_token'];
		// salesCommissionPercentage = json['sales_commission_percentage'];
		// telGroupId = json['tel_group_id'];
		// gst = json['gst'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['f_name'] = fName;
		data['l_name'] = lName;
		data['phone'] = phone;
		data['image'] = image;
		data['email'] = email;
		data['password'] = password;
		data['status'] = status;
		data['remember_token'] = rememberToken;
		data['created_at'] = createdAt;
		data['updated_at'] = updatedAt;
		// data['bank_name'] = this.bankName;
		// data['branch'] = this.branch;
		// data['account_no'] = this.accountNo;
		// data['holder_name'] = this.holderName;
		// data['auth_token'] = this.authToken;
		// data['sales_commission_percentage'] = this.salesCommissionPercentage;
		// data['tel_group_id'] = this.telGroupId;
		// data['gst'] = this.gst;
		return data;
	}
}

class Customer {
	int? id;
	String? name;
	String? fName;
	String? lName;
	String? phone;
	String? image;
	String? email;
	String? emailVerifiedAt;
	String? createdAt;
	String? updatedAt;
	String? streetAddress;
	String? country;
	String? city;
	String? zip;
	String? houseNo;
	String? apartmentNo;
	String? cmFirebaseToken;
	int? isActive;
	String? paymentCardLastFour;
	String? paymentCardBrand;
	String? paymentCardFawryToken;
	String? loginMedium;
	String? socialId;
	int? isPhoneVerified;
	String? temporaryToken;
	int? isEmailVerified;
	String? deletedAt;

	Customer(
			{this.id,
				this.name,
				this.fName,
				this.lName,
				this.phone,
				this.image,
				this.email,
				this.emailVerifiedAt,
				this.createdAt,
				this.updatedAt,
				this.streetAddress,
				this.country,
				this.city,
				this.zip,
				this.houseNo,
				this.apartmentNo,
				this.cmFirebaseToken,
				this.isActive,
				this.paymentCardLastFour,
				this.paymentCardBrand,
				this.paymentCardFawryToken,
				this.loginMedium,
				this.socialId,
				this.isPhoneVerified,
				this.temporaryToken,
				this.isEmailVerified,
				this.deletedAt});

	Customer.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		fName = json['f_name'];
		lName = json['l_name'];
		phone = json['phone'];
		image = json['image'];
		email = json['email'];
		emailVerifiedAt = json['email_verified_at'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
		streetAddress = json['street_address'];
		country = json['country'];
		city = json['city'];
		zip = json['zip'];
		houseNo = json['house_no'];
		apartmentNo = json['apartment_no'];
		cmFirebaseToken = json['cm_firebase_token'];
		isActive = json['is_active'];
		paymentCardLastFour = json['payment_card_last_four'];
		paymentCardBrand = json['payment_card_brand'];
		paymentCardFawryToken = json['payment_card_fawry_token'];
		loginMedium = json['login_medium'];
		socialId = json['social_id'];
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
		data['email_verified_at'] = emailVerifiedAt;
		data['created_at'] = createdAt;
		data['updated_at'] = updatedAt;
		data['street_address'] = streetAddress;
		data['country'] = country;
		data['city'] = city;
		data['zip'] = zip;
		data['house_no'] = houseNo;
		data['apartment_no'] = apartmentNo;
		data['cm_firebase_token'] = cmFirebaseToken;
		data['is_active'] = isActive;
		data['payment_card_last_four'] = paymentCardLastFour;
		data['payment_card_brand'] = paymentCardBrand;
		data['payment_card_fawry_token'] = paymentCardFawryToken;
		data['login_medium'] = loginMedium;
		data['social_id'] = socialId;
		data['is_phone_verified'] = isPhoneVerified;
		data['temporary_token'] = temporaryToken;
		data['is_email_verified'] = isEmailVerified;
		data['deleted_at'] = deletedAt;
		return data;
	}
}

class Shop {
	int? id;
	int? sellerId;
	String? name;
	String? address;
	String? contact;
	String? image;
	String? createdAt;
	String? updatedAt;
	String? banner;

	Shop(
			{this.id,
				this.sellerId,
				this.name,
				this.address,
				this.contact,
				this.image,
				this.createdAt,
				this.updatedAt,
				this.banner});

	Shop.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		sellerId = json['seller_id'];
		name = json['name'];
		address = json['address'];
		contact = json['contact'];
		image = json['image'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
		banner = json['banner'];
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
		return data;
	}
}

class ChatMessageList {
	int? id;
	int? userId;
	int? sellerId;
	String? message;
	int? sentByCustomer;
	int? sentBySeller;
	int? seenByCustomer;
	int? seenBySeller;
	int? status;
	String? createdAt;
	String? updatedAt;
	int? shopId;
	String? name;
	String? image;
	SellerInfo? sellerInfo;
//	Customer? customer;
	Shop? shop;

	ChatMessageList(
			{this.id,
				this.userId,
				this.sellerId,
				this.message,
				this.sentByCustomer,
				this.sentBySeller,
				this.seenByCustomer,
				this.seenBySeller,
				this.status,
				this.createdAt,
				this.updatedAt,
				this.shopId,
				this.name,
				this.image,
				this.sellerInfo,
			//	this.customer,
				this.shop});

	ChatMessageList.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		userId = json['user_id'];
		sellerId = json['seller_id'];
		message = json['message'];
		sentByCustomer = json['sent_by_customer'];
		sentBySeller = json['sent_by_seller'];
		seenByCustomer = json['seen_by_customer'];
		seenBySeller = json['seen_by_seller'];
		status = json['status'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
		shopId = json['shop_id'];
		name = json['name'];
		image = json['image'];
		sellerInfo = json['seller_info'] != null
				? SellerInfo.fromJson(json['seller_info'])
				: null;
		// customer = json['customer'] != null
		// 		? new Customer.fromJson(json['customer'])
		// 		: null;
		shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['user_id'] = userId;
		data['seller_id'] = sellerId;
		data['message'] = message;
		data['sent_by_customer'] = sentByCustomer;
		data['sent_by_seller'] = sentBySeller;
		data['seen_by_customer'] = seenByCustomer;
		data['seen_by_seller'] = seenBySeller;
		data['status'] = status;
		data['created_at'] = createdAt;
		data['updated_at'] = updatedAt;
		data['shop_id'] = shopId;
		data['name'] = name;
		data['image'] = image;
		if (sellerInfo != null) {
			data['seller_info'] = sellerInfo!.toJson();
		}
		// if (this.customer != null) {
		// 	data['customer'] = this.customer!.toJson();
		// }
		if (shop != null) {
			data['shop'] = shop!.toJson();
		}
		return data;
	}
}

class UniqueShops {
	int? id;
	int? userId;
	int? sellerId;
	String? message;
	int? sentByCustomer;
	int? sentBySeller;
	int? seenByCustomer;
	int? seenBySeller;
	int? status;
	String? createdAt;
	String? updatedAt;
	int? shopId;
	SellerInfo? sellerInfo;
	Shop? shop;

	UniqueShops(
			{this.id,
				this.userId,
				this.sellerId,
				this.message,
				this.sentByCustomer,
				this.sentBySeller,
				this.seenByCustomer,
				this.seenBySeller,
				this.status,
				this.createdAt,
				this.updatedAt,
				this.shopId,
				this.sellerInfo,
				this.shop});

	UniqueShops.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		userId = json['user_id'];
		sellerId = json['seller_id'];
		message = json['message'];
		sentByCustomer = json['sent_by_customer'];
		sentBySeller = json['sent_by_seller'];
		seenByCustomer = json['seen_by_customer'];
		seenBySeller = json['seen_by_seller'];
		status = json['status'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
		shopId = json['shop_id'];
		sellerInfo = json['seller_info'] != null
				? SellerInfo.fromJson(json['seller_info'])
				: null;
		shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['user_id'] = userId;
		data['seller_id'] = sellerId;
		data['message'] = message;
		data['sent_by_customer'] = sentByCustomer;
		data['sent_by_seller'] = sentBySeller;
		data['seen_by_customer'] = seenByCustomer;
		data['seen_by_seller'] = seenBySeller;
		data['status'] = status;
		data['created_at'] = createdAt;
		data['updated_at'] = updatedAt;
		data['shop_id'] = shopId;
		if (sellerInfo != null) {
			data['seller_info'] = sellerInfo!.toJson();
		}
		if (shop != null) {
			data['shop'] = shop!.toJson();
		}
		return data;
	}
}