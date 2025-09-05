import 'package:flutter/material.dart';
import 'package:myphsar/base_widget/no_internet_alert_widget.dart';

class CustomScaffoldRefreshIndicator extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final bool topSafeArea;
  final Future Function() onRefresh;
  final Color color;
  final GlobalKey<RefreshIndicatorState>? refreshIndicatorKey;

  const CustomScaffoldRefreshIndicator(
      {super.key,
      this.refreshIndicatorKey,
      required this.body,
      required this.onRefresh,
      this.bottomNavigationBar,
      this.appBar,
      this.topSafeArea = true,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: topSafeArea,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: appBar,
              backgroundColor: color,
              body: RefreshIndicator(key: refreshIndicatorKey, onRefresh: onRefresh, child: body),
              bottomNavigationBar: bottomNavigationBar,
            ),
      ),
    );
  }
}
