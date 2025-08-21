class ParamAddAddressModel {
  String? contactPersonName;
  String? addressType;
  String? address;
  String? zip;
  String? city;
  String? phone;
  String? cityId;

  ParamAddAddressModel(
      {this.contactPersonName, this.addressType, this.address, this.zip, this.phone, this.city, this.cityId});

  ParamAddAddressModel.fromJson(Map<String, dynamic> json) {
    contactPersonName = json['contact_person_name'];
    addressType = json['address_type'];
    address = json['address'];
    zip = json['zip'];
    phone = json['phone'];
    city = json['city'];
    cityId = json['city_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contact_person_name'] = contactPersonName;
    data['address_type'] = addressType;
    data['address'] = address;
    data['zip'] = zip;
    data['phone'] = phone;
    data['city'] = city;
    data['city_id'] = cityId;

    return data;
  }
}
