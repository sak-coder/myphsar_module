import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final bool topSafeArea;
  final Color? backGroundColor;

  const CustomScaffold(
      {super.key,
      this.backGroundColor = Colors.white,
      required this.body,
      this.bottomNavigationBar,
      this.appBar,
      this.topSafeArea = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: topSafeArea,
        child: Scaffold(
          backgroundColor: backGroundColor,
          resizeToAvoidBottomInset: true,
          appBar: appBar,
          body: body,
          bottomNavigationBar: bottomNavigationBar,
        ),
      ),
    );
  }
}
