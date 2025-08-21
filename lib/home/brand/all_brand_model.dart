class AllBrandModel {
  int? id;
  String? name;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? brandProductsCount;

//	List<Null>? translations;

  AllBrandModel({
    this.id,
    this.name,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.brandProductsCount,
    // this.translations
  });

  AllBrandModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    brandProductsCount = json['brand_products_count'];
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
    data['name'] = name;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['brand_products_count'] = brandProductsCount;
    // if (this.translations != null) {
    // 	data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
