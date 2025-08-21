class CategoryModel {
  int? id;
  String? name;
  String? slug;
  String? icon;
  int? parentId;
  int? position;
  String? createdAt;
  String? updatedAt;
  int? homeStatus;
  List<Childes>? childes;

//	List<Null>? translations;

  CategoryModel({
    this.id,
    this.name,
    this.slug,
    this.icon,
    this.parentId,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.homeStatus,
    this.childes,
    //	this.translations
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
    parentId = json['parent_id'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    homeStatus = json['home_status'];
    if (json['childes'] != null) {
      childes = <Childes>[];
      json['childes'].forEach((v) {
        if (childes!.length == 1) {
          //all product
          childes!.insert(0, Childes(toggle: false));
        }
        childes!.add(Childes.fromJson(v));
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
    data['name'] = name;
    data['slug'] = slug;
    data['icon'] = icon;
    data['parent_id'] = parentId;
    data['position'] = position;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['home_status'] = homeStatus;
    if (childes != null) {
      data['childes'] = childes!.map((v) => v.toJson()).toList();
    }
    // if (this.translations != null) {
    // 	data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Childes {
  int? id;
  String? name;
  String? slug;
  String? icon;
  int? parentId;
  int? position;
  String? createdAt;
  String? updatedAt;
  int? homeStatus;
  List<Childes>? childes;
  List<Null>? translations;
  bool toggle = false;

  Childes(
      {this.id,
      this.name,
      this.slug,
      this.icon,
      this.parentId,
      this.position,
      this.createdAt,
      this.updatedAt,
      this.homeStatus,
      this.childes,
      this.translations,
      this.toggle = false});

  Childes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
    parentId = json['parent_id'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    homeStatus = json['home_status'];
    if (json['childes'] != null) {
      childes = <Childes>[];
      json['childes'].forEach((v) {
        childes!.add(Childes.fromJson(v));
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
    data['name'] = name;
    data['slug'] = slug;
    data['icon'] = icon;
    data['parent_id'] = parentId;
    data['position'] = position;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['home_status'] = homeStatus;
    if (childes != null) {
      data['childes'] = childes!.map((v) => v.toJson()).toList();
    }
    // if (this.translations != null) {
    // 	data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class SubChild2 {
  int? id;
  String? name;
  String? slug;
  String? icon;
  int? parentId;
  int? position;
  String? createdAt;
  String? updatedAt;
  int? homeStatus;

  //List<Null>? translations;

  SubChild2({
    this.id,
    this.name,
    this.slug,
    this.icon,
    this.parentId,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.homeStatus,
    // this.translations
  });

  SubChild2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
    parentId = json['parent_id'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    homeStatus = json['home_status'];
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
    data['slug'] = slug;
    data['icon'] = icon;
    data['parent_id'] = parentId;
    data['position'] = position;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['home_status'] = homeStatus;
    // if (this.translations != null) {
    // 	data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
