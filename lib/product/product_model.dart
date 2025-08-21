class ProductModel {
  int? totalSize;
  int? limit;
  int? offset;
  List<Products>? products;

  ProductModel({this.totalSize, this.limit, this.offset, this.products});

  ProductModel.fromJsonList(List<dynamic> json) {
    products = <Products>[];
    for (var value in json) {
      products!.add(Products.fromJson(value));
    }
  }

  ProductModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? addedBy;
  int? userId;
  String? name;
  String? slug;
  List<CategoryIds>? categoryIds;
  int? brandId;
  String? unit;
  int? minQty;
  int? refundable;
  List<String>? images;
  String? thumbnail;
  int? featured;
  String? featuredAt;
  String? flashDeal;
  String? videoProvider;
  String? videoUrl;
  List<ProductColors>? colors;
  int? variantProduct;
  List<int>? attributes;
  List<ChoiceOptions>? choiceOptions;
  List<Variation>? variation;
  int? published;
  double? unitPrice;
  double? purchasePrice;
  int? tax;
  String? taxType;
  double? discount;
  String? discountType;
  int? currentStock;
  String? details;
  int? freeShipping;
//	Null? attachment;
  String? createdAt;
  String? updatedAt;
  int? status;
  int? featuredStatus;
  String? metaTitle;
  String? metaDescription;
  String? metaImage;
  int? requestStatus;
//	Null? deniedNote;
  int? viewer;
  int? interestRateStatus;
  int? reviewsCount;
  List<Rating>? rating;
  List<Null>? translations;
  Seller? seller;

  Products({
    this.id,
    this.addedBy,
    this.userId,
    this.name,
    this.slug,
    this.categoryIds,
    this.brandId,
    this.unit,
    this.minQty,
    this.refundable,
    this.images,
    this.thumbnail,
    this.featured,
    this.featuredAt,
    this.flashDeal,
    this.videoProvider,
    this.videoUrl,
    this.colors,
    this.variantProduct,
    this.attributes,
    this.choiceOptions,
    this.variation,
    this.published,
    this.unitPrice,
    this.purchasePrice,
    this.tax,
    this.taxType,
    this.discount,
    this.discountType,
    this.currentStock,
    this.details,
    this.freeShipping,
    //	this.attachment,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.featuredStatus,
    this.metaTitle,
    this.metaDescription,
    this.metaImage,
    this.requestStatus,
    this.seller,
    //	this.deniedNote,
    this.viewer,
    this.interestRateStatus,
    this.reviewsCount,
    this.rating,
    this.translations,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    addedBy = json['added_by'];
    userId = json['user_id'];
    name = json['name'] ?? "";
    slug = json['slug'];
    if (json['category_ids'] != null) {
      categoryIds = <CategoryIds>[];
      json['category_ids'].forEach((v) {
        categoryIds!.add(CategoryIds.fromJson(v));
      });
    }
    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    brandId = json['brand_id'];
    unit = json['unit'];
    minQty = json['min_qty'];
    refundable = json['refundable'];
    images = json['images'].cast<String>();
    thumbnail = json['thumbnail'];
    featured = json['featured'];
    featuredAt = json['featured_at'];
    flashDeal = json['flash_deal'];
    videoProvider = json['video_provider'];
    videoUrl = json['video_url'];
    if (json['colors'] != null) {
      colors = <ProductColors>[];
      json['colors'].forEach((v) {
        colors!.add(ProductColors.fromJson(v));
      });
    }
    variantProduct = json['variant_product'];
    attributes = json['attributes'].cast<int>();
    if (json['choice_options'] != null) {
      choiceOptions = <ChoiceOptions>[];
      json['choice_options'].forEach((v) {
        choiceOptions!.add(ChoiceOptions.fromJson(v));
      });
    }
    if (json['variation'] != null) {
      variation = <Variation>[];
      json['variation'].forEach((v) {
        variation!.add(Variation.fromJson(v));
      });
    }
    published = json['published'];
    unitPrice = double.tryParse(json['unit_price'].toString());
    purchasePrice = double.tryParse(json['purchase_price'].toString());
    tax = json['tax'];
    taxType = json['tax_type'];
    discount = double.tryParse(json['discount'].toString());
    discountType = json['discount_type'];
    currentStock = json['current_stock'];
    details = json['details'];
    freeShipping = json['free_shipping'];
    //	attachment = json['attachment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    featuredStatus = json['featured_status'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaImage = json['meta_image'];
    requestStatus = json['request_status'];
    //	deniedNote = json['denied_note'];
    viewer = json['viewer'];
    interestRateStatus = json['interest_rate_status'];
    reviewsCount = json['reviews_count'];

    if (json['rating'] != null) {
      rating = [];
      json['rating'].forEach((v) {
        rating!.add(Rating.fromJson(v));
      });
    }
    // if (json['translations'] != null) {
    // 	translations = <Null>[];
    // 	json['translations'].forEach((v) {
    // 		translations!.add(new Null.fromJson(v));
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
    if (categoryIds != null) {
      data['category_ids'] = categoryIds!.map((v) => v.toJson()).toList();
    }
    if (seller != null) {
      data['seller'] = seller!.toJson();
    }
    data['brand_id'] = brandId;
    data['unit'] = unit;
    data['min_qty'] = minQty;
    data['refundable'] = refundable;
    data['images'] = images;
    data['thumbnail'] = thumbnail;
    data['featured'] = featured;
    data['featured_at'] = featuredAt;
    data['flash_deal'] = flashDeal;
    data['video_provider'] = videoProvider;
    data['video_url'] = videoUrl;

    if (colors != null) {
      data['colors'] = colors!.map((v) => v.toJson()).toList();
    }

    data['variant_product'] = variantProduct;
    data['attributes'] = attributes;
    if (choiceOptions != null) {
      data['choice_options'] = choiceOptions!.map((v) => v.toJson()).toList();
    }
    if (variation != null) {
      data['variation'] = variation!.map((v) => v.toJson()).toList();
    }
    data['published'] = published;
    data['unit_price'] = unitPrice;
    data['purchase_price'] = purchasePrice;
    data['tax'] = tax;
    data['tax_type'] = taxType;
    data['discount'] = discount;
    data['discount_type'] = discountType;
    data['current_stock'] = currentStock;
    data['details'] = details;
    data['free_shipping'] = freeShipping;
    //	data['attachment'] = this.attachment;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    data['featured_status'] = featuredStatus;
    data['meta_title'] = metaTitle;
    data['meta_description'] = metaDescription;
    data['meta_image'] = metaImage;
    data['request_status'] = requestStatus;
    //	data['denied_note'] = this.deniedNote;
    data['viewer'] = viewer;
    data['interest_rate_status'] = interestRateStatus;
    data['reviews_count'] = reviewsCount;

    if (rating != null) {
      data['rating'] = rating!.map((v) => v.toJson()).toList();
    }

    // if (this.translations != null) {
    // 	data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    // }

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

class CategoryIds {
  String? id;
  String? name;
  int? position;

  CategoryIds({this.id, this.name, this.position});

  CategoryIds.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['position'] = position;
    return data;
  }
}

class ProductColors {
  String? name;
  String? code;

  ProductColors({this.name, this.code});

  ProductColors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}

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

class Rating {
  double? average;
  int? productId;

  Rating({required double this.average, required int this.productId});

  Rating.fromJson(Map<String, dynamic> json) {
    average = double.parse(json['average']);
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['average'] = average;
    data['product_id'] = productId;
    return data;
  }
}
// class Reviews {
// 	int? id;
// 	int? productId;
// 	int? customerId;
// 	String? comment;
// 	String? attachment;
// 	double? rating;
// 	int? status;
// 	String? createdAt;
// 	String? updatedAt;
//
// 	Reviews(
// 			{this.id,
// 				this.productId,
// 				this.customerId,
// 				this.comment,
// 				this.attachment,
// 				this.rating,
// 				this.status,
// 				this.createdAt,
// 				this.updatedAt});
//
// 	Reviews.fromJson(Map<String, dynamic> json) {
// 		id = json['id'];
// 		productId = json['product_id'];
// 		customerId = json['customer_id'];
// 		comment = json['comment'];
// 		attachment = json['attachment'];
// 		rating = 4.0;
// 	//	rating = double.tryParse(json['rating'].toString());
// 		status = json['status'];
// 		createdAt = json['created_at'];
// 		updatedAt = json['updated_at'];
// 	}
//
// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['id'] = this.id;
// 		data['product_id'] = this.productId;
// 		data['customer_id'] = this.customerId;
// 		data['comment'] = this.comment;
// 		data['attachment'] = this.attachment;
// 		data['rating'] = this.rating;
// 		data['status'] = this.status;
// 		data['created_at'] = this.createdAt;
// 		data['updated_at'] = this.updatedAt;
// 		return data;
// 	}
// }
