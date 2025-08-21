class ReviewBodyModel {
  String? productId;
  String? comment;
  String? rating;
  List<String>? fileUpload;

  ReviewBodyModel({this.productId, this.comment, this.rating, this.fileUpload});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['comment'] = comment;
    data['rating'] = rating;
    data['fileUpload'] = fileUpload;
    return data;
  }
}
