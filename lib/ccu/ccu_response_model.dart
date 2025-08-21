class CcuResponseModel {
  int? id;
  String? orderId;
  String? formUrl;
  bool? embled;

  CcuResponseModel({this.id, this.orderId, this.formUrl, this.embled});

  CcuResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
    formUrl = json['formUrl'];
    embled = json['embled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['orderId'] = orderId;
    data['formUrl'] = formUrl;
    data['embled'] = embled;
    return data;
  }
}
