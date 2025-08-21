class FlashDealListModel {
  int? id;
  String? addedBy;
  int? userId;
  String? name;
  String? slug;

  // List<CategoryIds>? categoryIds;
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
  List<Null>? colors;
  int? variantProduct;
  List<int>? attributes;
  List<ChoiceOptions>? choiceOptions;
  List<Variation>? variation;
  int? published;
  double? unitPrice;
  dynamic purchasePrice;
  int? tax;
  String? taxType;
  double? discount;
  String? discountType;
  int? currentStock;
  String? details;
  int? freeShipping;
  String? attachment;
  String? createdAt;
  String? updatedAt;
  int? status;
  int? featuredStatus;
  String? metaTitle;
  String? metaDescription;
  String? metaImage;
  int? requestStatus;
  String? deniedNote;
  int? viewer;
  int? interestRateStatus;
  int? reviewsCount;
  List<Null>? rating;
  List<Null>? translations;
  List<Null>? reviews;
  List<FlashDealListModel>? flashDealListModel;

  FlashDealListModel(
      {this.id,
      this.addedBy,
      this.userId,
      this.name,
      this.slug,
      // this.categoryIds,
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
      this.attachment,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.featuredStatus,
      this.metaTitle,
      this.metaDescription,
      this.metaImage,
      this.requestStatus,
      this.deniedNote,
      this.viewer,
      this.interestRateStatus,
      this.reviewsCount,
      this.rating,
      this.translations,
      this.reviews,
      this.flashDealListModel});

  FlashDealListModel.fromJsonList(List<dynamic> json) {
    List<FlashDealListModel> flashDealList = [];
    json.forEach((value) {flashDealList.add(FlashDealListModel.fromJson(value));});
    flashDealListModel = flashDealList;
  }

  FlashDealListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addedBy = json['added_by'];
    userId = json['user_id'];
    name = json['name'];
    slug = json['slug'];
    // if (json['category_ids'] != null) {
    // 	categoryIds = <CategoryIds>[];
    // 	json['category_ids'].forEach((v) {
    // 		categoryIds!.add(new CategoryIds.fromJson(v));
    // 	});
    // }
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

    // if (json['colors'] != null) {
    // 	colors = <String>[];
    // 	json['colors'].forEach((v) {
    // 		colors!.add(new Null.fromJson(v));
    // 	});
    // }

    variantProduct = json['variant_product'];
    attributes = json['attributes'].cast<int>();
    if (json['choice_options'] != null) {
      choiceOptions = <ChoiceOptions>[];
      json['choice_options'].forEach((v) {
        choiceOptions!.add(new ChoiceOptions.fromJson(v));
      });
    }
    if (json['variation'] != null) {
      variation = <Variation>[];
      json['variation'].forEach((v) {
        variation!.add(new Variation.fromJson(v));
      });
    }
    published = json['published'];
    unitPrice = double.parse(json['unit_price'].toString());
    purchasePrice = json['purchase_price'];
    tax = json['tax'];
    taxType = json['tax_type'];
    discount = double.parse(json['discount'].toString());
    discountType = json['discount_type'];
    currentStock = json['current_stock'];
    details = json['details'];
    freeShipping = json['free_shipping'];
    attachment = json['attachment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    featuredStatus = json['featured_status'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaImage = json['meta_image'];
    requestStatus = json['request_status'];
    deniedNote = json['denied_note'];
    viewer = json['viewer'];
    interestRateStatus = json['interest_rate_status'];
    reviewsCount = json['reviews_count'];

    // if (json['rating'] != null) {
    // 	rating = <Null>[];
    // 	json['rating'].forEach((v) {
    // 		rating!.add(new Null.fromJson(v));
    // 	});
    // }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['added_by'] = this.addedBy;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    // if (this.categoryIds != null) {
    // 	data['category_ids'] = this.categoryIds!.map((v) => v.toJson()).toList();
    // }
    data['brand_id'] = this.brandId;
    data['unit'] = this.unit;
    data['min_qty'] = this.minQty;
    data['refundable'] = this.refundable;
    data['images'] = this.images;
    data['thumbnail'] = this.thumbnail;
    data['featured'] = this.featured;
    data['featured_at'] = this.featuredAt;
    data['flash_deal'] = this.flashDeal;
    data['video_provider'] = this.videoProvider;
    data['video_url'] = this.videoUrl;

    // if (this.colors != null) {
    // 	data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    // }

    data['variant_product'] = this.variantProduct;
    data['attributes'] = this.attributes;
    if (this.choiceOptions != null) {
      data['choice_options'] = this.choiceOptions!.map((v) => v.toJson()).toList();
    }
    if (this.variation != null) {
      data['variation'] = this.variation!.map((v) => v.toJson()).toList();
    }
    data['published'] = this.published;
    data['unit_price'] = this.unitPrice;
    data['purchase_price'] = this.purchasePrice;
    data['tax'] = this.tax;
    data['tax_type'] = this.taxType;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['current_stock'] = this.currentStock;
    data['details'] = this.details;
    data['free_shipping'] = this.freeShipping;
    data['attachment'] = this.attachment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['featured_status'] = this.featuredStatus;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_image'] = this.metaImage;
    data['request_status'] = this.requestStatus;
    data['denied_note'] = this.deniedNote;
    data['viewer'] = this.viewer;
    data['interest_rate_status'] = this.interestRateStatus;
    data['reviews_count'] = this.reviewsCount;
    // if (this.rating != null) {
    // 	data['rating'] = this.rating!.map((v) => v.toJson()).toList();
    // }
    // if (this.translations != null) {
    // 	data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    // }
    // if (this.reviews != null) {
    // 	data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class CategoryIds {
  int? id;
  int? position;

  CategoryIds({this.id, this.position});

  CategoryIds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['position'] = this.position;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['title'] = this.title;
    data['options'] = this.options;
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
    price = json['price'];
    sku = json['sku'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['price'] = this.price;
    data['sku'] = this.sku;
    data['qty'] = this.qty;
    return data;
  }
}
