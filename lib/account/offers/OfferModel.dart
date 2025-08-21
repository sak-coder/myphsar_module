class OfferModel {
  int? id;
  String? photo;
  String? bannerType;
  int? published;
  String? createdAt;
  String? updatedAt;
  String? url;

  OfferModel({this.id, this.photo, this.bannerType, this.published, this.createdAt, this.updatedAt, this.url});

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    bannerType = json['banner_type'];
    published = json['published'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['photo'] = photo;
    data['banner_type'] = bannerType;
    data['published'] = published;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['url'] = url;
    return data;
  }
}
