class TrackingModel {
  int? id;
  int? customerId;

  // String? customerType;
  String? paymentStatus;
  String? orderStatus;
  String? paymentMethod;

  // String? transactionRef;
  double? orderAmount;

  // int? shippingAddress;
  String? createdAt;
  String? updatedAt;

  // int? discountAmount;
  // String? discountType;
  // String? couponCode;
  // int? shippingMethodId;
  //  int? shippingCost;
  // String? orderGroupId;
  // String? verificationCode;
  // int? sellerId;
  // String? sellerIs;
  String? shippingAddressData;

  TrackingModel(
      {this.id,
      this.customerId,
      //		this.customerType,
      this.paymentStatus,
      this.orderStatus,
      this.paymentMethod,
      //		this.transactionRef,
      this.orderAmount,
      //	this.shippingAddress,
      this.createdAt,
      this.updatedAt,
      // this.discountAmount,
      // this.discountType,
      // this.couponCode,
      // this.shippingMethodId,
      // this.shippingCost,
      // this.orderGroupId,
      // this.verificationCode,
      // this.sellerId,
      // this.sellerIs,
      this.shippingAddressData});

  TrackingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    //	customerType = json['customer_type'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    paymentMethod = json['payment_method'];
    //	transactionRef = json['transaction_ref'];
    // orderAmount = json['order_amount'];
    //	shippingAddress = json['shipping_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // discountAmount = json['discount_amount'];
    // discountType = json['discount_type'];
    // couponCode = json['coupon_code'];
    // shippingMethodId = json['shipping_method_id'];
    //	shippingCost = json['shipping_cost'];
    // orderGroupId = json['order_group_id'];
    // verificationCode = json['verification_code'];
    // sellerId = json['seller_id'];
    // sellerIs = json['seller_is'];
    shippingAddressData = json['shipping_address_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    //	data['customer_type'] = this.customerType;
    data['payment_status'] = paymentStatus;
    data['order_status'] = orderStatus;
    data['payment_method'] = paymentMethod;
    //	data['transaction_ref'] = this.transactionRef;
    data['order_amount'] = orderAmount;
    //	data['shipping_address'] = this.shippingAddress;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    //	data['discount_amount'] = this.discountAmount;
    // 	data['discount_type'] = this.discountType;
    // 	data['coupon_code'] = this.couponCode;
    // 	data['shipping_method_id'] = this.shippingMethodId;
    // 	data['shipping_cost'] = this.shippingCost;
    // 	data['order_group_id'] = this.orderGroupId;
    // 	data['verification_code'] = this.verificationCode;
    // 	data['seller_id'] = this.sellerId;
    // 	data['seller_is'] = this.sellerIs;
    data['shipping_address_data'] = shippingAddressData;
    return data;
  }
}
