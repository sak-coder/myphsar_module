class ProvinceCityModel {
  List<CityData>? data;

  ProvinceCityModel({required this.data});

  ProvinceCityModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CityData>[];
      json['data'].forEach((v) {
        data!.add(CityData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.map((v) => v.toJson()).toList();
    return data;
  }
}

class CityData {
  int? id;
  String? name;
  String? createdAt;

  CityData({this.id, this.name, this.createdAt});

  CityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    return data;
  }
}
