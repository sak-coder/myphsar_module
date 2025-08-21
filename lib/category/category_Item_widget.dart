import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';
import 'package:myphsar/category/category_model.dart';

import '../configure/config_controller.dart';
import 'category_detail/category_detail_view.dart';

class CategoryItemWidget extends StatefulWidget {
  final CategoryModel category;

  const CategoryItemWidget(this.category, {super.key});

  @override
  State<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => {Get.to(CategoryDetailView(widget.category,false))},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 0),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder: "assets/images/placeholder_img.png",
                placeholderFit: BoxFit.fitHeight,
                fadeInDuration: const Duration(seconds: 2),
                fit: BoxFit.fitHeight,
                image: '${Get.find<ConfigController>().configModel.baseUrls?.baseCategoryImageUrl}/${widget.category.icon}',
                imageErrorBuilder: (c, o, s) => Image.asset(
                  "assets/images/placeholder_img.png",
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10),
          height: 50,
          child: textView15(
              context: context,
              text: widget.category.name!,
              maxLine: 2,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center),
        )
      ],
    );
  }
}
