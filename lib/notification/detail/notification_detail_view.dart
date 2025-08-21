import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../base_colors.dart';
import '../../base_widget/custom_appbar_view.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../../configure/config_controller.dart';
import '../notification_model.dart';

class NotificationDetailView extends StatelessWidget {
  final NotificationModel notificationModel;

  const NotificationDetailView(this.notificationModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(
        context: context,
        titleText: notificationModel.title!,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              SizedBox(
                height: 320,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                    child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/placeholder_img.png",
                  placeholderFit: BoxFit.contain,
                  fadeInDuration: const Duration(seconds: 1),
                  fit: BoxFit.fill,
                  // height: 320,
                  // width: 320,
                  image:
                      '${Get.find<ConfigController>().configModel.baseUrls?.baseNotificationImageUrl}/${notificationModel.image!}',
                  imageErrorBuilder: (c, o, s) => Image.asset(
                    "assets/images/placeholder_img.png",
                    fit: BoxFit.contain,
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: textView16(context: context, text: 'desc'.tr, color: ColorResource.secondaryColor),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Linkify(
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  linkStyle: const TextStyle(),
                  onOpen: (link) => _launchUrl(link.url),
                  text: notificationModel.description!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
