class AvailableLenderModel {
  List<AvailableLenderData>? data;

  AvailableLenderModel({this.data});

  AvailableLenderModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AvailableLenderData>[];
      json['data'].forEach((v) {
        data!.add(AvailableLenderData.fromJson(v));
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

class AvailableLenderData {
  int? id;
  String? avatar;
  String? phone;
  String? organization;
  String? address;
  int? installmentBooking;
  int? installmentFee;
  String? createdAt;

  AvailableLenderData(
      {this.id,
      this.avatar,
      this.phone,
      this.organization,
      this.address,
      this.installmentBooking,
      this.installmentFee,
      this.createdAt});

  AvailableLenderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    phone = json['phone'];
    organization = json['organization'];
    address = json['address'];
    installmentBooking = json['installment_booking'];
    installmentFee = json['installment_fee'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avatar'] = avatar;
    data['phone'] = phone;
    data['organization'] = organization;
    data['address'] = address;
    data['installment_booking'] = installmentBooking;
    data['installment_fee'] = installmentFee;
    data['created_at'] = createdAt;
    return data;
  }
}
