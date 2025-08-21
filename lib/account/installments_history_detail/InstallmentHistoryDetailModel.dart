class InstallmentHistoryDetailModel {
	InstDetailData? data;

	InstallmentHistoryDetailModel({this.data});

	InstallmentHistoryDetailModel.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ? InstDetailData.fromJson(json['data']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		if (this.data != null) {
			data['data'] = this.data!.toJson();
		}
		return data;
	}
}

class InstDetailData {
	String? fullName;
	String? age;
	String? email;
	String? phone;
	String? city;
	String? currentAddress;
	String? jobPosition;
	String? salary;
	String? jobType;
	String? installDuration;
	String? cardNumber;
	String? dob;
	String? permanentHomeNumber;
	String? permanentStreetNumber;
	String? permanentCurrentAddress;
	String? cardImage;
	String? cardImageBack;
	String? refName;
	String? refPhone;
	Product? product;
	PaymentTable? paymentTable;
	List<MfpsTable>? mfpsTable;
	String? mfpsTotalPrincipal;
	String? mfpsTotalInterestRate;
	String? mfpsTotalAmountToBePaid;
	String? mfpsTotalBalance;

	InstDetailData(
			{this.fullName,
				this.age,
				this.email,
				this.phone,
				this.city,
				this.currentAddress,
				this.jobPosition,
				this.salary,
				this.jobType,
				this.installDuration,
				this.cardNumber,
				this.dob,
				this.permanentHomeNumber,
				this.permanentStreetNumber,
				this.permanentCurrentAddress,
				this.cardImage,
				this.cardImageBack,
				this.refName,
				this.refPhone,
				this.product,
				this.paymentTable,
				this.mfpsTable,
				this.mfpsTotalPrincipal,
				this.mfpsTotalInterestRate,
				this.mfpsTotalAmountToBePaid,
				this.mfpsTotalBalance});

	InstDetailData.fromJson(Map<String, dynamic> json) {
		fullName = json['full_name'];
		age = json['age'];
		email = json['email'];
		phone = json['phone'];
		city = json['city'];
		currentAddress = json['current_address'];
		jobPosition = json['job_position'];
		salary = json['salary'];
		jobType = json['job_type'];
		installDuration = json['install_duration'];
		cardNumber = json['card_number'];
		dob = json['dob'];
		permanentHomeNumber = json['permanent_home_number'];
		permanentStreetNumber = json['permanent_street_number'];
		permanentCurrentAddress = json['permanent_current_address'];
		cardImage = json['card_image'];
		cardImageBack = json['card_image_back'];
		refName = json['ref_name'];
		refPhone = json['ref_phone'];
		product =
		json['product'] != null ? Product.fromJson(json['product']) : null;
		paymentTable = json['payment_table'] != null
				? PaymentTable.fromJson(json['payment_table'])
				: null;
		if (json['mfps_table'] != null) {
			mfpsTable = <MfpsTable>[];
			json['mfps_table'].forEach((v) {
				mfpsTable!.add(MfpsTable.fromJson(v));
			});
		}
		mfpsTotalPrincipal = json['mfps_total_principal'];
		mfpsTotalInterestRate = json['mfps_total_interest_rate'];
		mfpsTotalAmountToBePaid = json['mfps_total_amount_to_be_paid'];
		mfpsTotalBalance = json['mfps_total_balance'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['full_name'] = fullName;
		data['age'] = age;
		data['email'] = email;
		data['phone'] = phone;
		data['city'] = city;
		data['current_address'] = currentAddress;
		data['job_position'] = jobPosition;
		data['salary'] = salary;
		data['job_type'] = jobType;
		data['install_duration'] = installDuration;
		data['card_number'] = cardNumber;
		data['dob'] = dob;
		data['permanent_home_number'] = permanentHomeNumber;
		data['permanent_street_number'] = permanentStreetNumber;
		data['permanent_current_address'] = permanentCurrentAddress;
		data['card_image'] = cardImage;
		data['card_image_back'] = cardImageBack;
		data['ref_name'] = refName;
		data['ref_phone'] = refPhone;
		if (product != null) {
			data['product'] = product!.toJson();
		}
		if (paymentTable != null) {
			data['payment_table'] = paymentTable!.toJson();
		}
		if (mfpsTable != null) {
			data['mfps_table'] = mfpsTable!.map((v) => v.toJson()).toList();
		}
		data['mfps_total_principal'] = mfpsTotalPrincipal;
		data['mfps_total_interest_rate'] = mfpsTotalInterestRate;
		data['mfps_total_amount_to_be_paid'] = mfpsTotalAmountToBePaid;
		data['mfps_total_balance'] = mfpsTotalBalance;
		return data;
	}
}

class Product {
	int? id;
	String? name;
	String? url;
	String? thumbnail;
	Shop? shop;

	Product({this.id, this.name, this.url, this.thumbnail, this.shop});

	Product.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		url = json['url'];
		thumbnail = json['thumbnail'];
		shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['name'] = name;
		data['url'] = url;
		data['thumbnail'] = thumbnail;
		if (shop != null) {
			data['shop'] = shop!.toJson();
		}
		return data;
	}
}

class Shop {
	int? id;
	String? fullName;
	String? email;
	String? phone;

	Shop({this.id, this.fullName, this.email, this.phone});

	Shop.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		fullName = json['full_name'];
		email = json['email'];
		phone = json['phone'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['full_name'] = fullName;
		data['email'] = email;
		data['phone'] = phone;
		return data;
	}
}

class PaymentTable {
	String? totalInstallment;
	String? totalInstallmentDuration;
	String? totalInstallmentInterest;
	String? totalInstallmentFee;
	String? totalInstallmentDownPayment;
	String? totalInstallmentMinusTotalInstallmentDownPayment;
	int? iTotalInstallmentInterest;
	int? iTotalInstallmentFee;
	String? sTotalInstallmentDownPayment;

	PaymentTable(
			{this.totalInstallment,
				this.totalInstallmentDuration,
				this.totalInstallmentInterest,
				this.totalInstallmentFee,
				this.totalInstallmentDownPayment,
				this.totalInstallmentMinusTotalInstallmentDownPayment,
				this.iTotalInstallmentInterest,
				this.iTotalInstallmentFee,
				this.sTotalInstallmentDownPayment});

	PaymentTable.fromJson(Map<String, dynamic> json) {
		totalInstallment = json['total_installment'];
		totalInstallmentDuration = json['total_installment_duration'];
		totalInstallmentInterest = json['total_installment_interest'];
		totalInstallmentFee = json['total_installment_fee'];
		totalInstallmentDownPayment = json['total_installment_down_payment'];
		totalInstallmentMinusTotalInstallmentDownPayment =
		json['total_installment_minus_total_installment_down_payment'];
		iTotalInstallmentInterest = json['_total_installment_interest'];
		iTotalInstallmentFee = json['_total_installment_fee'];
		sTotalInstallmentDownPayment = json['_total_installment_down_payment'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['total_installment'] = totalInstallment;
		data['total_installment_duration'] = totalInstallmentDuration;
		data['total_installment_interest'] = totalInstallmentInterest;
		data['total_installment_fee'] = totalInstallmentFee;
		data['total_installment_down_payment'] = totalInstallmentDownPayment;
		data['total_installment_minus_total_installment_down_payment'] =
				totalInstallmentMinusTotalInstallmentDownPayment;
		data['_total_installment_interest'] = iTotalInstallmentInterest;
		data['_total_installment_fee'] = iTotalInstallmentFee;
		data['_total_installment_down_payment'] = sTotalInstallmentDownPayment;
		return data;
	}
}

class MfpsTable {
	int? period;
	String? principal;
	String? interestRate;
	String? amountToBePaid;
	String? balance;

	MfpsTable(
			{this.period,
				this.principal,
				this.interestRate,
				this.amountToBePaid,
				this.balance});

	MfpsTable.fromJson(Map<String, dynamic> json) {
		period = json['period'];
		principal = json['principal'];
		interestRate = json['interest_rate'];
		amountToBePaid = json['amount_to_be_paid'];
		balance = json['balance'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['period'] = period;
		data['principal'] = principal;
		data['interest_rate'] = interestRate;
		data['amount_to_be_paid'] = amountToBePaid;
		data['balance'] = balance;
		return data;
	}
}
