class InstallmentsHistoryModel {
  List<InstallmentHistoryListData>? data;

  InstallmentsHistoryModel({this.data});

  InstallmentsHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <InstallmentHistoryListData>[];
      json['data'].forEach((v) {
        data!.add(InstallmentHistoryListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InstallmentHistoryListData {
  String? uuid;
  String? tranId;
  String? status;
  String? statusCode;
  String? createdAt;
  String? productPrice;

  InstallmentHistoryListData({this.uuid, this.tranId, this.status, this.statusCode, this.productPrice, this.createdAt});

  InstallmentHistoryListData.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    tranId = json['tran_id'];
    status = json['status'];
    statusCode = json['status_code'];
    productPrice = json['product_pricing'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['tran_id'] = tranId;
    data['status'] = status;
    data['status_code'] = statusCode;
    data['product_pricing'] = productPrice;
    data['created_at'] = createdAt;
    return data;
  }
}
