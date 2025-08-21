class SocialLoginModelParam {
  String? token;
  String? uniqueId;
  String? medium;
  String? email;
  String? name;

  SocialLoginModelParam({this.token, this.uniqueId, this.medium, this.email, this.name});

  SocialLoginModelParam.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    uniqueId = json['unique_id'];
    medium = json['medium'];
    email = json['email'];
    name = json['name'];
    //	imageProfile = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['unique_id'] = uniqueId;
    data['medium'] = medium;
    data['email'] = email;
    data['name'] = name;
    return data;
  }
}
