import 'package:flutter/cupertino.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_controller.dart';
import 'package:myphsar/configure/config_controller.dart';
import 'package:myphsar/configure/config_model.dart';

import '../base_colors.dart';
import '../home/all_product/product_item_widget.dart';
import 'product_model.dart';

class ProductItemGridView extends StatefulWidget {
  final List<Products> _productModel;
  final BaseController _control;
  final ScrollController? scrollController;

  final Function function;
  final String? catId;
  final bool isShop;
  final bool isCategory;
  final double paddingBottom;
  final double paddingRight;
  final double paddingLeftItem;
  final double paddingRightItem;

  const ProductItemGridView(this._control, this._productModel, this.scrollController, this.function,
      {super.key,
      this.catId,
      this.isShop = false,
      this.isCategory = false,
      this.paddingBottom = 30,
      this.paddingRight = 5,
      this.paddingLeftItem = 5,
      this.paddingRightItem = 5});

  @override
  State<ProductItemGridView> createState() => _ProductItemGridViewState();
}

class _ProductItemGridViewState extends State<ProductItemGridView> {
  int offSetCount = 1;

  @override
  void initState() {
    initScrollListener();
    super.initState();
  }

  void initScrollListener() async {
    widget.scrollController!.addListener(() async {
      if (widget.scrollController?.position.pixels == widget.scrollController?.position.maxScrollExtent) {
        if (!widget._control.getInfiniteLoader.value) {
          offSetCount++;
          widget.function(offSetCount);
        }
      }
    });
  }

//TODO Delay render view loading
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: widget.paddingRight, bottom: widget.paddingBottom),
      child: Column(
        children: [
          MasonryView(
            itemPadding: 0,
            listOfItem: List.generate(widget._productModel.length, (index) => index),
            numberOfColumn: 2,
            itemBuilder: (item) {
              return Padding(
                  padding:
                      EdgeInsets.only(right: widget.paddingRightItem, top: 5, bottom: 5, left: widget.paddingLeftItem),
                  child: widget.isShop
                      ? widget._productModel[item].categoryIds!.first.id == widget.catId
                          ? ProductItemWidget(
                              product: widget._productModel[item], elevation: 0,
                            )
                          : Container()
                      : ProductItemWidget(
                          product: widget._productModel[item],
                          isCategory: widget.isCategory,
                          elevation: 0,
                        ));
            },
          ),
          Obx(() => widget._control.getInfiniteLoader.value
              ? const SizedBox(
                  height: 50,
                  child: CupertinoActivityIndicator(radius: 15, color: ColorResource.lightShadowColor50),
                )
              : SizedBox(
                  height: widget.paddingBottom,
                ))
        ],
      ),
    );
  }
}
