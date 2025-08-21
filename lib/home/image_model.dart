class ImageModel {
  // int? totalSize;
  // int? limit;
  // int? offset;
  List<ProductsImage>? products;

  ImageModel({this.products});

  ImageModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <ProductsImage>[];
      json['products'].forEach((v) {
        products!.add(ProductsImage.fromJson(v));
      });
    }
  }
}

class ProductsImage {
  List<String>? images;

  ProductsImage({this.images});

  ProductsImage.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['images'] = images;
    return data;
  }
}
