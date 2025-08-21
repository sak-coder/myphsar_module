class OrderDetailModel {
  int? id;
  int? orderId;
  int? productId;
  int? sellerId;
  ProductDetails? productDetails;
  int? qty;
  double? price;
  int? tax;
  double? discount;
  String? deliveryStatus;
  String? paymentStatus;
  String? createdAt;
  String? updatedAt;
  String? shippingMethodId;
  String? variant;

  // List<Variation>? variation;
  String? discountType;
  int? isStockDecreased;

  OrderDetailModel(
      {this.id,
      this.orderId,
      this.productId,
      this.sellerId,
      this.productDetails,
      this.qty,
      this.price,
      this.tax,
      this.discount,
      this.deliveryStatus,
      this.paymentStatus,
      this.createdAt,
      this.updatedAt,
      this.shippingMethodId,
      this.variant,
      // this.variation,
      this.discountType,
      this.isStockDecreased});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    sellerId = json['seller_id'];
    productDetails = json['product_details'] != null ? ProductDetails.fromJson(json['product_details']) : null;
    qty = json['qty'];
    price = double.tryParse(json['price'].toString());
    tax = json['tax'];
    discount = double.tryParse(json['discount'].toString());
    deliveryStatus = json['delivery_status'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    shippingMethodId = json['shipping_method_id'];
    variant = json['variant'];

    // if (json['variation'] != null) {
    // 	variation = <Variation>[] ;
    // 	json['variation'].forEach((v) {
    // 		variation!.add(new Variation.fromJson(v));
    // 	});
    // }

    discountType = json['discount_type'];
    isStockDecreased = json['is_stock_decreased'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['seller_id'] = sellerId;
    if (productDetails != null) {
      data['product_details'] = productDetails!.toJson();
    }
    data['qty'] = qty;
    data['price'] = price;
    data['tax'] = tax;
    data['discount'] = discount;
    data['delivery_status'] = deliveryStatus;
    data['payment_status'] = paymentStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['shipping_method_id'] = shippingMethodId;
    data['variant'] = variant;

    data['discount_type'] = discountType;
    data['is_stock_decreased'] = isStockDecreased;
    return data;
  }
}

class ProductDetails {
  int? id;
  String? addedBy;
  int? userId;
  String? name;
  String? slug;

  // List<CategoryIds>? categoryIds;
  // int? brandId;
  // String? unit;
  // int? minQty;
  // int? refundable;
  // List<String>? images;
  String? thumbnail;

  // String? featured;
  // String? featuredAt;
  // String? flashDeal;
  // String? videoProvider;
  // String? videoUrl;
//	List<Null>? colors;
//	int? variantProduct;
//	List<int>? attributes;
//	List<ChoiceOptions>? choiceOptions;
//	List<Variation>? variation;
//	int? published;
  double? unitPrice;

//	double? purchasePrice;
  // int? tax;
  // String? taxType;
  // int? discount;
  // String? discountType;
  // int? currentStock;
  String? details;

   double? freeShipping;
  // String? attachment;
  // String? createdAt;
  // String? updatedAt;
  // int? status;
  // int? featuredStatus;
  String? metaTitle;
  String? metaDescription;
  String? metaImage;
  int? requestStatus;
  String? deniedNote;
  int? viewer;
  int? interestRateStatus;
  int? reviewsCount;

  // List<Null>? translations;
  // List<Null>? reviews;

  ProductDetails({
    this.id,
    this.addedBy,
    this.userId,
    this.name,
    this.slug,
    // this.categoryIds,
    // this.brandId,
    // this.unit,
    // this.minQty,
    // this.refundable,
    // this.images,
    this.thumbnail,
    // this.featured,
    // this.featuredAt,
    // this.flashDeal,
    // this.videoProvider,
    // this.videoUrl,
    // this.colors,
    // this.variantProduct,
    // this.attributes,
    // this.choiceOptions,
    // this.variation,
    //this.published,
    this.unitPrice,
    //	this.purchasePrice,
    // this.tax,
    // this.taxType,
    // this.discount,
    // this.discountType,
    // this.currentStock,
    this.details,
    this.freeShipping,
    // this.attachment,
    // this.createdAt,
    // this.updatedAt,
    // this.status,
    // this.featuredStatus,
    // this.metaTitle,
    // this.metaDescription,
    // this.metaImage,
    // this.requestStatus,
    // this.deniedNote,
    // this.viewer,
    // this.interestRateStatus,
    // this.reviewsCount,
    // this.translations,
    // this.reviews
  });

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addedBy = json['added_by'];
    userId = json['user_id'];
    name = json['name'];
    // slug = json['slug'];
    // if (json['category_ids'] != null) {
    // 	categoryIds = <CategoryIds>[];
    // 	json['category_ids'].forEach((v) {
    // 		categoryIds!.add(new CategoryIds.fromJson(v));
    // 	});
    // }
    // brandId = json['brand_id'];
    // unit = json['unit'];
    // minQty = json['min_qty'];
    // refundable = json['refundable'];
    // images = json['images'].cast<String>();
    thumbnail = json['thumbnail'];
    // featured = json['featured'];
    // featuredAt = json['featured_at'];
    // flashDeal = json['flash_deal'];
    // videoProvider = json['video_provider'];
    // videoUrl = json['video_url'];
    // if (json['colors'] != null) {
    // 	colors = <Null>[];
    // 	json['colors'].forEach((v) {
    // 		colors!.add(new Null.fromJson(v));
    // 	});
    // }
    // variantProduct = json['variant_product'];
    // attributes = json['attributes'].cast<int>();
    // if (json['choice_options'] != null) {
    // 	choiceOptions = <ChoiceOptions>[];
    // 	json['choice_options'].forEach((v) {
    // 		choiceOptions!.add(new ChoiceOptions.fromJson(v));
    // 	});
    // }
    // if (json['variation'] != null) {
    // 	variation = <Variation>[];
    // 	json['variation'].forEach((v) {
    // 		variation!.add(new Variation.fromJson(v));
    // 	});
    // }
    //	published = json['published'];
    unitPrice = double.tryParse(json['unit_price'].toString());
    //	purchasePrice = json['purchase_price'];
    // tax = json['tax'];
    // taxType = json['tax_type'];
    // discount = json['discount'];
    // discountType = json['discount_type'];
    // currentStock = json['current_stock'];
    details = json['details'];
    freeShipping = double.tryParse(json['free_shipping'].toString());
    // attachment = json['attachment'];
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
    // status = json['status'];
    // featuredStatus = json['featured_status'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaImage = json['meta_image'];
    requestStatus = json['request_status'];
    deniedNote = json['denied_note'];
    viewer = json['viewer'];
    interestRateStatus = json['interest_rate_status'];
    reviewsCount = json['reviews_count'];
    // if (json['translations'] != null) {
    // 	translations = <Null>[];
    // 	json['translations'].forEach((v) {
    // 		translations!.add(new Null.fromJson(v));
    // 	});
    // }

    // if (json['reviews'] != null) {
    // 	reviews = <Null>[];
    // 	json['reviews'].forEach((v) {
    // 		reviews!.add(new Null.fromJson(v));
    // 	});
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['added_by'] = addedBy;
    data['user_id'] = userId;
    data['name'] = name;
    data['slug'] = slug;
    // if (this.categoryIds != null) {
    // 	data['category_ids'] = this.categoryIds!.map((v) => v.toJson()).toList();
    // }
    // data['brand_id'] = this.brandId;
    // data['unit'] = this.unit;
    // data['min_qty'] = this.minQty;
    // data['refundable'] = this.refundable;
    // data['images'] = this.images;
    data['thumbnail'] = thumbnail;
    // data['featured'] = this.featured;
    // data['featured_at'] = this.featuredAt;
    // data['flash_deal'] = this.flashDeal;
    // data['video_provider'] = this.videoProvider;
    // data['video_url'] = this.videoUrl;
    // if (this.colors != null) {
    // 	data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    // }
    // data['variant_product'] = this.variantProduct;
    // data['attributes'] = this.attributes;
    // if (this.choiceOptions != null) {
    // 	data['choice_options'] =
    // 			this.choiceOptions!.map((v) => v.toJson()).toList();
    // }
    // if (this.variation != null) {
    // 	data['variation'] = this.variation!.map((v) => v.toJson()).toList();
    // }
    //	data['published'] = this.published;
    data['unit_price'] = unitPrice;
    //	data['purchase_price'] = this.purchasePrice;
    // data['tax'] = this.tax;
    // data['tax_type'] = this.taxType;
    // data['discount'] = this.discount;
    // data['discount_type'] = this.discountType;
    // data['current_stock'] = this.currentStock;
    data['details'] = details;
    data['free_shipping'] = freeShipping;
    // data['attachment'] = this.attachment;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    // data['status'] = this.status;
    // data['featured_status'] = this.featuredStatus;
    data['meta_title'] = metaTitle;
    data['meta_description'] = metaDescription;
    data['meta_image'] = metaImage;
    data['request_status'] = requestStatus;
    data['denied_note'] = deniedNote;
    data['viewer'] = viewer;
    data['interest_rate_status'] = interestRateStatus;
    data['reviews_count'] = reviewsCount;
    // if (this.translations != null) {
    // 	data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    // }
    // if (this.reviews != null) {
    // 	data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

// class CategoryIds {
// 	int? id;
// 	int? position;
//
// 	CategoryIds({this.id, this.position});
//
// 	CategoryIds.fromJson(Map<String, dynamic> json) {
// 		id = json['id'];
// 		position = json['position'];
// 	}
//
// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['id'] = this.id;
// 		data['position'] = this.position;
// 		return data;
// 	}
// }

class ChoiceOptions {
  String? name;
  String? title;
  List<String>? options;

  ChoiceOptions({this.name, this.title, this.options});

  ChoiceOptions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['title'] = title;
    data['options'] = options;
    return data;
  }
}

class Variation {
  String? type;
  double? price;
  String? sku;
  int? qty;

  Variation({this.type, this.price, this.sku, this.qty});

  Variation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    price = double.tryParse(json['price'].toString());
    sku = json['sku'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['price'] = price;
    data['sku'] = sku;
    data['qty'] = qty;
    return data;
  }
}

class VariationSize {
  String? size;

  VariationSize({this.size});

  VariationSize.fromJson(Map<String, dynamic> json) {
    size = json['Size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Size'] = size;
    return data;
  }
}
