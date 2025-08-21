class AuthModel {
	String email = "";
	String password = "";
	List<Errors>? errors;

	AuthModel({ required this.email, required this.password});

	AuthModel.fromJson(Map<String, dynamic> json) {
		email = json['email'];
		password = json['password'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['email'] = email;
		data['password'] = password;
		return data;
	}


}
class AuthResponseErrorModel {
	List<Errors>? errors;

	AuthResponseErrorModel({this.errors});

	AuthResponseErrorModel.fromJson(Map<String, dynamic> json) {
		if (json['errors'] != null) {
			errors = <Errors>[];
			json['errors'].forEach((v) {
				errors!.add(Errors.fromJson(v));
			});
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		if (errors != null) {
			data['errors'] = errors!.map((v) => v.toJson()).toList();
		}
		return data;
	}
}

class Errors {
	String? code;
	String? message;

	Errors({this.code, this.message});

	Errors.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		message = json['message'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['code'] = code;
		data['message'] = message;
		return data;
	}
}
