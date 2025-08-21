
class SearchRecommendModel {
	List<Categories>? categories;
	List<ProductList>? productsList;
	List<Shops>? shops;

	SearchRecommendModel({this.categories, this.productsList, this.shops});

	SearchRecommendModel.fromJson(Map<String, dynamic> json) {
		if (json['categories'] != null) {
			categories = <Categories>[];
			json['categories'].forEach((v) {
				categories!.add(Categories.fromJson(v));
			});
		}
		if (json['products'] != null) {
			productsList = <ProductList>[];
			json['products'].forEach((v) {
				productsList!.add(ProductList.fromJson(v));
			});
		}
		if (json['shops'] != null) {
			shops = <Shops>[];
			json['shops'].forEach((v) {
				shops!.add(Shops.fromJson(v));
			});
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		if (categories != null) {
			data['categories'] = categories!.map((v) => v.toJson()).toList();
		}
		if (productsList != null) {
			data['products'] = productsList!.map((v) => v.toJson()).toList();
		}
		if (shops != null) {
			data['shops'] = shops!.map((v) => v.toJson()).toList();
		}
		return data;
	}
}

class Categories {
	int? id;
	String? name;
	String? slug;
	String? icon;

	Categories({this.id, this.name, this.slug, this.icon});

	Categories.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		slug = json['slug'];
		icon = json['icon'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['name'] = name;
		data['slug'] = slug;
		data['icon'] = icon;
		return data;
	}
}

class ProductList {
	String? name;

	ProductList({this.name});

	ProductList.fromJson(Map<String, dynamic> json) {
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['name'] = name;
		return data;
	}
}

class Shops {
	int? id;
	String? name;
	Null? slug;
	String? image;

	Shops({this.id, this.name, this.slug, this.image });

	Shops.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		slug = json['slug'];
		image = json['image'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['name'] = name;
		data['slug'] = slug;
		data['image'] = image;
		return data;
	}
}