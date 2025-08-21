class CartModel {
  int? id;
  int? customerId;
  String? cartGroupId;
  int? productId;
  String? color;
  Choices? choices;
  Variations? variations;
  String? variant;
  int? quantity;
  double? price;

  // int? tax;
  double? discount;
  String? slug;
  String? name;
  String? thumbnail;
  int? sellerId;
  String? sellerIs;
  String? createdAt;
  String? updatedAt;
  String? shopInfo;
  bool? isDisplaySeller = false;

  CartModel(
      {this.id,
      this.customerId,
      this.cartGroupId,
      this.productId,
      this.color,
      this.choices,
      this.variations,
      this.variant,
      this.quantity,
      this.price,
      // this.tax,
      this.discount,
      this.slug,
      this.name,
      this.thumbnail,
      this.sellerId,
      this.sellerIs,
      this.createdAt,
      this.updatedAt,
      this.shopInfo,
      this.isDisplaySeller});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    cartGroupId = json['cart_group_id'];
    productId = json['product_id'];
    color = json['color'];
    // choices = json['choices'] != null ? new Choices.fromJson(json['choices']) : null;
    // variations = json['variations'] != null
    // 		? new Variations.fromJson(json['variations'])
    // 		: null;
    variant = json['variant'];
    quantity = json['quantity'];
    price = double.tryParse(json['price'].toString());
    // tax = json['tax'];
    discount = double.tryParse(json['discount'].toString());
    slug = json['slug'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    sellerId = json['seller_id'];
    sellerIs = json['seller_is'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    shopInfo = json['shop_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['cart_group_id'] = cartGroupId;
    data['product_id'] = productId;
    data['color'] = color;
    if (choices != null) {
      data['choices'] = choices!.toJson();
    }
    if (variations != null) {
      data['variations'] = variations!.toJson();
    }
    data['variant'] = variant;
    data['quantity'] = quantity;
    data['price'] = price;
    // data['tax'] = this.tax;
    data['discount'] = discount;
    data['slug'] = slug;
    data['name'] = name;
    data['thumbnail'] = thumbnail;
    data['seller_id'] = sellerId;
    data['seller_is'] = sellerIs;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['shop_info'] = shopInfo;
    return data;
  }
}

class Choices {
  String? choice3;
  String? choice1;

  Choices({this.choice3, this.choice1});

  Choices.fromJson(Map<String, dynamic> json) {
    choice3 = json['choice_3'];
    choice1 = json['choice_1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['choice_3'] = choice3;
    data['choice_1'] = choice1;
    return data;
  }
}

class Variations {
  String? color;
  String? height;
  String? size;

  Variations({this.color, this.height, this.size});

  Variations.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    height = json['Height'];
    size = json['Size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = color;
    data['Height'] = height;
    data['Size'] = size;
    return data;
  }
}
