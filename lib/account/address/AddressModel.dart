class AddressModel {
	int? id;
	int? cityId;
	int? customerId;
	String? contactPersonName;
	String? addressType;
	String? address;
	String? city;
	String? zip;
	String? phone;
	String? createdAt;
	String? updatedAt;
	String? state;
	String? country;

	AddressModel(
			{this.id,
				this.cityId,
				this.customerId,
				this.contactPersonName,
				this.addressType,
				this.address,
				this.city,
				this.zip,
				this.phone,
				this.createdAt,
				this.updatedAt,
				this.state,
				this.country});

	AddressModel.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		cityId = json['city_id'];
		customerId = json['customer_id'];
		contactPersonName = json['contact_person_name'] ?? 'empty';
		addressType = json['address_type'];
		address = json['address'].toString();
		city = json['city_name'];
		zip = json['zip'];
		phone = json['phone'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
		state = json['state'];
		country = json['country'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['city_id'] = cityId;
		data['customer_id'] = customerId;
		data['contact_person_name'] = contactPersonName;
		data['address_type'] = addressType;
		data['address'] = address;
		data['city'] = city;
		data['zip'] = zip;
		data['phone'] = phone;
		data['created_at'] = createdAt;
		data['updated_at'] = updatedAt;
		data['state'] = state;
		data['country'] = country;
		return data;
	}
}