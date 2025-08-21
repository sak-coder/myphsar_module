import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myphsar/base_colors.dart';
import 'package:myphsar/base_widget/myphsar_text_view.dart';
import 'package:myphsar/base_widget/snack_bar_message.dart';
import 'package:myphsar/order/order_detail/order_detail_model.dart';
import 'package:myphsar/reviews/review_body_model.dart';
import 'package:myphsar/reviews/review_view_controller.dart';

import '../base_widget/alert_dialog_view.dart';
import '../base_widget/custom_icon_button.dart';
import '../base_widget/input_text_field_custom.dart';
import '../configure/config_controller.dart';
import '../utils/price_converter.dart';

class SubmitReviewsItemView extends StatefulWidget {
  final OrderDetailModel orderDetail;

  const SubmitReviewsItemView(this.orderDetail, {super.key});

  @override
  State<SubmitReviewsItemView> createState() => _SubmitReviewsItemViewState();
}

class _SubmitReviewsItemViewState extends State<SubmitReviewsItemView> with TickerProviderStateMixin {
  var descriptionFormKey = GlobalKey<FormState>();
  var descriptionController = TextEditingController();
  var file1 = File('');
  var file2 = File('');
  var file3 = File('');
  var file4 = File('');
  final picker = ImagePicker();
  double ratingStar = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool toggleButton = false;

  void _choose(int index) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500, maxWidth: 500);

    setState(() {
      if (pickedFile != null) {
        switch (index) {
          case 1:
            file1 = File(pickedFile.path);
            break;
          case 2:
            file2 = File(pickedFile.path);
            break;
          case 3:
            file3 = File(pickedFile.path);
            break;
          case 4:
            file4 = File(pickedFile.path);
            break;
        }

        //Noted* check with back-end for update only need param

      } else {
        snackBarMessage(context, 'no_image_select'.tr);
      }
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInBack,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              height: 60,
              width: 60,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/placeholder_img.png",
                    placeholderFit: BoxFit.contain,
                    fadeInDuration: const Duration(seconds: 1),
                    fit: BoxFit.contain,
                    image:
                    '${Get.find<ConfigController>().configModel.baseUrls?.baseProductThumbnailUrl}/${widget.orderDetail.productDetails!.thumbnail!}',

                    imageErrorBuilder: (c, o, s) => Image.asset(
                      "assets/images/placeholder_img.png",
                      fit: BoxFit.contain,
                    ),
                  )),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: textView15(
                                context: context,
                                text: widget.orderDetail.productDetails!.name.toString(),
                                maxLine: 2,
                                color: ColorResource.darkTextColor,
                                fontWeight: FontWeight.w700,
                                height: 1.2)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textView15(
                            context: context,
                            text: PriceConverter.currencySignAlignment(widget.orderDetail.price!),
                            maxLine: 1,
                            fontWeight: FontWeight.w800,
                            color: ColorResource.primaryColor),
                        Expanded(
                          child: textView15(
                              height: 0.8,
                              context: context,
                              text: " | x ${widget.orderDetail.qty}",
                              maxLine: 1,
                              fontWeight: FontWeight.w800,
                              color: ColorResource.primaryColor),
                        ),
                        textView12(
                            context: context,
                            text: widget.orderDetail.variant.toString(),
                            fontWeight: FontWeight.w800,
                            color: ColorResource.lightTextColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizeTransition(
          sizeFactor: _animation,
          axis: Axis.vertical,
          child: Column(
            children: [
              RatingBarIndicator(
                rating: ratingStar,
                itemPadding: const EdgeInsets.all(10),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    setState(() {
                      ratingStar = index.toDouble() + 1;
                    });
                  },
                  child: Image.asset("assets/images/star_ic.png"),
                ),
                itemCount: 5,
                itemSize: 30.0,
                direction: Axis.horizontal,
              ),
              textView13(context: context, text: 'tap_star_rate'.tr, color: ColorResource.lightShadowColor),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        _choose(1);
                      },
                      child: file1.path == ''
                          ? Image.asset(
                              "assets/images/camera_dot_ic.png",
                            )
                          : Image.file(file1, height: 100, width: 100, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        _choose(2);
                      },
                      child: file2.path == ''
                          ? Image.asset(
                              "assets/images/camera_dot_ic.png",
                            )
                          : Image.file(file2, height: 100, width: 100, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        _choose(3);
                      },
                      child: file3.path == ''
                          ? Image.asset(
                              "assets/images/camera_dot_ic.png",
                            )
                          : Image.file(file3, height: 100, width: 100, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        _choose(4);
                      },
                      child: file4.path == ''
                          ? Image.asset(
                              "assets/images/camera_dot_ic.png",
                            )
                          : Image.file(file4, height: 100, width: 100, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InputTextFieldCustom(
                formKey: descriptionFormKey,
                controller: descriptionController,
                hintTxt: "rate_msg".tr,
                maxLine: 4,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        customTextButton(
            height: 50,
            blur: 0,
            radius: 10,
            color: toggleButton ? ColorResource.primaryColor : ColorResource.lightHintTextColor,
            onTap: () async {
              setState(() {
                if (toggleButton) {
                  if (descriptionController.value.text.isNotEmpty) {
                    Get.find<ReviewViewController>().submitReviewsProduct(
                        context,
                        ReviewBodyModel(
                            fileUpload: [file1.path],
                            productId: widget.orderDetail.productId.toString(),
                            comment: descriptionController.value.text.trim(),
                            rating: ratingStar.toString()), (status) {
                      if (status) {
                        snackBarMessage(context, "rate_success_msg".tr,bgColor: ColorResource.greenColor);
                      }
                      _controller.animateBack(0, duration: const Duration(milliseconds: 300));
                    });
                    toggleButton = false;
                    descriptionFormKey.currentState!.validate();
                  } else {
                    descriptionFormKey.currentState!.validate();
                  }
                } else {
                  toggleButton = true;
                  if (_animation.status != AnimationStatus.completed) {
                    _controller.forward();
                  }
                }
              });
            },
            text: Center(
                child: textView15(
                    context: context,
                    text: toggleButton ? "submit_feedback".tr : "feedback".tr,
                    color: toggleButton ? Colors.white : ColorResource.primaryColor,
                    fontWeight: FontWeight.w800))),
      ],
    );
  }
}
