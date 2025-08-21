class AbaPaymentModel {
	int? id;
	String? reqTime;
	String? merchantId;
	String? tranId;
	double? amount;
	String? items;
	String? firstname;
	String? lastname;
	String? email;
	String? phone;
	String? paymentOption;
	String? returnUrl;
	String? continueSuccessUrl;
	String? hash;
	String? apiUrl;
	bool? embled;
	String? embledUrl;
	String? deepLink;

	AbaPaymentModel(
			{this.id,
				this.reqTime,
				this.merchantId,
				this.tranId,
				this.amount,
				this.items,
				this.firstname,
				this.lastname,
				this.email,
				this.phone,
				this.paymentOption,
				this.returnUrl,
				this.continueSuccessUrl,
				this.hash,
				this.apiUrl,
				this.embled,
				this.embledUrl,this.deepLink});

	AbaPaymentModel.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		reqTime = json['req_time'];
		merchantId = json['merchant_id'];
		tranId = json['tran_id'];
		amount = double.parse(json['amount'].toString());
		items = json['items'];
		firstname = json['firstname'];
		lastname = json['lastname'];
		email = json['email'];
		phone = json['phone'];
		paymentOption = json['payment_option'];
		returnUrl = json['return_url'];
		continueSuccessUrl = json['continue_success_url'];
		hash = json['hash'];
		apiUrl = json['api_url'];
		embled = json['embled'];
		deepLink = json['abapay_deeplink'];
		embledUrl = json['embled_url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['req_time'] = reqTime;
		data['merchant_id'] = merchantId;
		data['tran_id'] = tranId;
		data['amount'] = amount;
		data['items'] = items;
		data['firstname'] = firstname;
		data['lastname'] = lastname;
		data['email'] = email;
		data['phone'] = phone;
		data['payment_option'] = paymentOption;
		data['return_url'] = returnUrl;
		data['continue_success_url'] = continueSuccessUrl;
		data['hash'] = hash;
		data['api_url'] = apiUrl;
		data['embled'] = embled;
		data['abapay_deeplink'] = deepLink;
		data['embled_url'] = embledUrl;
		return data;
	}
}