

class SupportTicketParamModel {
	String? type;
	String? subject;
	String? description;

	SupportTicketParamModel({this.type,this.subject,this.description});

	SupportTicketParamModel.fromJson(Map<String, dynamic> json) {
		 type = json['type'];
		 subject = json['subject'];
		 description = json['description'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['type'] = type;
		data['subject'] = subject;
		data['description'] = description;
		return data;
	}
}
