class CECityCityListModel {
  List<Cities>? cities;

  CECityCityListModel({this.cities});

  CECityCityListModel.fromJson(Map<String, dynamic> json) {
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cities != null) {
      data['cities'] = cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  int? id;
  String? cityName;
  double? deliveryPrice;

  Cities({this.id, this.cityName, this.deliveryPrice});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityName = json['city_name'];
    deliveryPrice = json['delivery_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city_name'] = cityName;
    data['delivery_price'] = deliveryPrice;
    return data;
  }
}
