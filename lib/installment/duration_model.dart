class DurationModel {
	List<DurationData>? data;

	DurationModel({this.data});

	DurationModel.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			data = <DurationData>[];
			json['data'].forEach((v) {
				data!.add(new DurationData.fromJson(v));
			});
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
			data['data'] = this.data!.map((v) => v.toJson()).toList();
		}
		return data;
	}
}

class DurationData {
	int? id;
	String? title;
	int? months;
	String? type;
	String? deletedAt;
	String? createdAt;
	String? updatedAt;

	DurationData(
			{this.id,
				this.title,
				this.months,
				this.type,
				this.deletedAt,
				this.createdAt,
				this.updatedAt});

	DurationData.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		title = json['title'];
		months = json['months'];
		type = json['type'];
		deletedAt = json['deleted_at'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['title'] = this.title;
		data['months'] = this.months;
		data['type'] = this.type;
		data['deleted_at'] = this.deletedAt;
		data['created_at'] = this.createdAt;
		data['updated_at'] = this.updatedAt;
		return data;
	}
}