class OrderHistoryModel {
  int? id;
  int? customerId;
  String? customerType;
  String? paymentStatus;
  String? orderStatus;
  String? paymentMethod;
  String? transactionRef;
  double? orderAmount;
  int? shippingAddress;
  String? createdAt;
  String? updatedAt;
  double? discountAmount;
  String? discountType;
  String? couponCode;
  int? shippingMethodId;
  double? shippingCost;
  String? orderGroupId;
  String? verificationCode;
  int? sellerId;
  String? sellerIs;
  bool? trackingOrder;
  ShippingAddressData? shippingAddressData;

  // "tracking_order" -> false
  OrderHistoryModel(
      {this.id,
      this.customerId,
      this.customerType,
      this.paymentStatus,
      this.orderStatus,
      this.paymentMethod,
      this.transactionRef,
      this.orderAmount,
      this.shippingAddress,
      this.createdAt,
      this.updatedAt,
      this.discountAmount,
      this.discountType,
      this.couponCode,
      this.shippingMethodId,
      this.shippingCost,
      this.orderGroupId,
      this.verificationCode,
      this.sellerId,
      this.sellerIs,
      this.trackingOrder,
      this.shippingAddressData});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    customerType = json['customer_type'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    paymentMethod = json['payment_method'];
    transactionRef = json['transaction_ref'];
    orderAmount = double.tryParse(json['order_amount'].toString());
    shippingAddress = json['shipping_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    discountAmount = double.tryParse(json['discount_amount'].toString());
    discountType = json['discount_type'];
    couponCode = json['coupon_code'];
    shippingMethodId = json['shipping_method_id'];
    shippingCost = double.tryParse(json['shipping_cost'].toString());
    orderGroupId = json['order_group_id'];
    verificationCode = json['verification_code'];
    sellerId = json['seller_id'];
    sellerIs = json['seller_is'];
    trackingOrder = json['tracking_order'];
    shippingAddressData = json['shipping_address_data'] != null
        ? new ShippingAddressData.fromJson(json['shipping_address_data'])
        : null;
  }
}

class ShippingAddressData {
  int? id;
  int? customerId;
  String? contactPersonName;
  String? addressType;
  String? address;
  String? city;
  String? zip;
  String? phone;
  String? createdAt;
  String? updatedAt;
  String? state;
  String? country;

  ShippingAddressData(
      {this.id,
      this.customerId,
      this.contactPersonName,
      this.addressType,
      this.address,
      this.city,
      this.zip,
      this.phone,
      this.createdAt,
      this.updatedAt,
      this.state,
      this.country});

  ShippingAddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    contactPersonName = json['contact_person_name'];
    addressType = json['address_type'];
    address = json['address'];
    city = json['city'];
    zip = json['zip'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['contact_person_name'] = contactPersonName;
    data['address_type'] = addressType;
    data['address'] = address;
    data['city'] = city;
    data['zip'] = zip;
    data['phone'] = phone;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['state'] = state;
    data['country'] = country;
    return data;
  }
}
