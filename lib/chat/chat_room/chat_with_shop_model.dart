class ChatWithShopModel {
  int? id;
  int? userId;
  int? sellerId;
  String? message;
  int? sentByCustomer;
  int? sentBySeller;
  int? seenByCustomer;
  int? seenBySeller;

//	int? status;
  String? createdAt;
  bool? isSendFailed;

  // String? updatedAt;
  // int? shopId;
//	SellerInfo? sellerInfo;
//	Customer? customer;
//	Shop? shop;

  ChatWithShopModel(
      {this.id,
      this.userId,
      this.sellerId,
      this.message,
      this.sentByCustomer,
      this.sentBySeller,
      this.seenByCustomer,
      this.seenBySeller,
      //	this.status,
      this.createdAt,
      this.isSendFailed = false
      /*	this.updatedAt,
				this.shopId,
				this.sellerInfo,
				this.customer,
				this.shop*/
      });

  ChatWithShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sellerId = json['seller_id'];
    message = json['message'];
    sentByCustomer = json['sent_by_customer'];
    sentBySeller = json['sent_by_seller'];
    seenByCustomer = json['seen_by_customer'];
    seenBySeller = json['seen_by_seller'];
    //	status = json['status'];
    createdAt = json['created_at'];

    /*	updatedAt = json['updated_at'];
		shopId = json['shop_id'];
		sellerInfo = json['seller_info'] != null
				? new SellerInfo.fromJson(json['seller_info'])
				: null;
		customer = json['customer'] != null
				? new Customer.fromJson(json['customer'])
				: null;
		shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;*/
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
    //	data['status'] = this.status;
    data['created_at'] = createdAt;
    /*	data['updated_at'] = this.updatedAt;
		data['shop_id'] = this.shopId;
		if (this.sellerInfo != null) {
			data['seller_info'] = this.sellerInfo!.toJson();
		}
		if (this.customer != null) {
			data['customer'] = this.customer!.toJson();
		}
		if (this.shop != null) {
			data['shop'] = this.shop!.toJson();
		}*/
    return data;
  }
}

