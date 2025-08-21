class SubmitInstallmentBody {
  String? productId;
  String? fullName;
  String? email;
  String? age;
  String? phone;
  String? currentAddress;
  String? jobPosition;
  String? salary;
  String? cityId;
  String? jobTypeId;
  String? installDurationId;
  String? cardNumber;
  String? dob;
  String? refName;
  String? refPhone;
  String? permanentHomeNumber;
  String? permanentStreetNumber;
  String? permanentCurrentAddress;
  String? cardIdImage;
  String? cardIdBackImage;

  SubmitInstallmentBody(
      {this.productId,
      this.fullName,
      this.email,
      this.age,
      this.phone,
      this.currentAddress,
      this.jobPosition,
      this.salary,
      this.cityId,
      this.jobTypeId,
      this.installDurationId,
      this.cardNumber,
      this.dob,
      this.refName,
      this.refPhone,
      this.permanentHomeNumber,
      this.permanentStreetNumber,
      this.permanentCurrentAddress,
      this.cardIdImage,
      this.cardIdBackImage});

  SubmitInstallmentBody.fromJson(Map<String?, dynamic> json) {
    productId = json['product_id'];
    fullName = json['full_name'];
    email = json['email'];
    age = json['age'];
    phone = json['phone'];
    currentAddress = json['current_address'];
    jobPosition = json['job_position'];
    salary = json['salary'];
    cityId = json['city_id'];
    jobTypeId = json['job_type_id'];
    installDurationId = json['install_duration_id'];
    cardNumber = json['card_number'];
    dob = json['dob'];
    refName = json['ref_name'];
    refPhone = json['ref_phone'];
    permanentHomeNumber = json['permanent_home_number'];
    permanentStreetNumber = json['permanent_street_number'];
    permanentCurrentAddress = json['permanent_current_address'];
    cardIdImage = json['card_id'];
    cardIdBackImage = json['card_id_back'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['product_id'] = productId!;
    data['full_name'] = fullName!;
    data['email'] = email!;
    data['age'] = age!;
    data['phone'] = phone!;
    data['current_address'] = currentAddress!;
    data['job_position'] = jobPosition!;
    data['salary'] = salary!;
    data['city_id'] = cityId!;
    data['job_type_id'] = jobTypeId!;
    data['install_duration_id'] = installDurationId!;
    data['card_number'] = cardNumber!;
    data['dob'] = dob!;
    data['ref_name'] = refName!;
    data['ref_phone'] = refPhone!;
    data['permanent_home_number'] = permanentHomeNumber!;
    data['permanent_street_number'] = permanentStreetNumber!;
    data['permanent_current_address'] = permanentCurrentAddress!;
    data['card_id'] = cardIdImage!;
    data['card_id_back'] = cardIdBackImage!;
    return data;
  }
}
