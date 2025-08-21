import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyView extends StatelessWidget {
  final String text;
  final String title;

  const PrivacyPolicyView({super.key, required this.text, required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: customAppBarView(context: context, titleText: title),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Html(
              onLinkTap: (url, __, _) {
                _launchUrl(url!);
              },
              style: {
                "body": Style(
                  backgroundColor: Colors.white,
                  fontSize: FontSize(20.0),
                  fontFamily: "KantumruyPro",
                  fontWeight: FontWeight.w600,
                ),
              },
              data: text,
              shrinkWrap: true,
            ),
          ),
        ),
        topSafeArea: true);
  }

  _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
