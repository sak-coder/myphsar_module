class SupportReplyModel {
	int? id;
	int? supportTicketId;
	int? adminId;
	String? customerMessage;
	String? adminMessage;
	int? position;
	String? createdAt;
	String? updatedAt;

	SupportReplyModel(
			{this.id,
				this.supportTicketId,
				this.adminId,
				this.customerMessage,
				this.adminMessage,
				this.position,
				this.createdAt,
				this.updatedAt});

	SupportReplyModel.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		supportTicketId = json['support_ticket_id'];
		adminId = json['admin_id'];
		customerMessage = json['customer_message'] ?? "";
		adminMessage = json['admin_message'];
		position = json['position'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['id'] = id;
		data['support_ticket_id'] = supportTicketId;
		data['admin_id'] = adminId;
		data['customer_message'] = customerMessage;
		data['admin_message'] = adminMessage;
		data['position'] = position;
		data['created_at'] = createdAt;
		data['updated_at'] = updatedAt;
		return data;
	}
}