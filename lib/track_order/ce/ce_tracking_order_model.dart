class CeTrackingOrderModel {
  List<Data>? data;
  String? message;

  CeTrackingOrderModel({this.data, this.message});

  CeTrackingOrderModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? statusMsg;
  String? date;

  Data({this.statusMsg, this.date});

  Data.fromJson(Map<String, dynamic> json) {
    statusMsg = json['status_msg'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_msg'] = statusMsg;
    data['date'] = date;
    return data;
  }
}
