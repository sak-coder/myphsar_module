import '../home/flash_deal/flash_deal_list_model.dart';

class CartParamModel {
  int? id;
  int? quantity;
  String? variant;
  String? color;
  Variation? variation;
  List<ChoiceOptions>? choiceOptions;
  List<int>? variationIndexes;

  CartParamModel(
      {this.id, this.quantity, this.variant, this.color, this.variation, this.choiceOptions, this.variationIndexes});

  CartParamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    quantity = int.parse(json['quantity'].toString());

    variant = json['variant'];
    color = json['color'];
    variation = (json['variation'] != null ? Variation.fromJson(json['variation']) : null)!;

    if (json['choice_options'] != null) {
      choiceOptions = [];
      json['choice_options'].forEach((v) {
        choiceOptions?.add(ChoiceOptions.fromJson(v));
      });
    }
    variationIndexes = json['variation_indexes'] != null ? json['variation_indexes'].cast<int>() : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['variant'] = variant;
    data['color'] = color;
    data['variation'] = variation;
    data['choice_options'] = choiceOptions?.map((v) => v.toJson()).toList();
    data['variation_indexes'] = variationIndexes;
    return data;
  }
}
