import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_colors.dart';

import '../base_widget/custom_appbar_view.dart';
import '../base_widget/custom_icon_button.dart';
import '../base_widget/custom_scaffold.dart';
import '../base_widget/myphsar_text_view.dart';
import '../configure/config_controller.dart';
import '../home/seller/seller_model.dart';

class SampleTabAnimationView extends StatefulWidget {
  final SellerModel sellerModel;

  const SampleTabAnimationView(this.sellerModel, {super.key});

  @override
  State<SampleTabAnimationView> createState() => _SampleTabAnimationViewState();
}

class _SampleTabAnimationViewState extends State<SampleTabAnimationView> with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();

  // this will control the button clicks and tab changing
  TabController? _controller;

  // this will control the animation when a button changes from an off state to an on state
  AnimationController? _animationControllerOn;

  // this will control the animation when a button changes from an on state to an off state
  AnimationController? _animationControllerOff;

  // this will give the background color values of a button when it changes to an on state
  Animation? _colorTweenBackgroundOn;
  Animation? _colorTweenBackgroundOff;

  // this will give the foreground color values of a button when it changes to an on state
  Animation? _colorTweenForegroundOn;
  Animation? _colorTweenForegroundOff;

  // when swiping, the _controller.index value only changes after the animation, therefore, we need this to trigger the animations and save the current index
  int _currentIndex = 0;

  // saves the previous active tab
  int _prevControllerIndex = 0;

  // saves the value of the tab animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
  double _aniValue = 0.0;

  // saves the previous value of the tab animation. It's used to figure the direction of the animation
  double _prevAniValue = 0.0;

  // these will be our tab icons. You can use whatever you like for the content of your buttons
  final List _icons = [Icons.star, Icons.whatshot, Icons.call, Icons.contacts, Icons.email, Icons.donut_large];

  // active button's foreground color
  final Color _foregroundOn = Colors.white;
  final Color _foregroundOff = Colors.black;

  // active button's background color
  final Color _backgroundOn = Colors.blue;
  final Color? _backgroundOff = Colors.grey[300];

  // scroll controller for the TabBar
  final ScrollController _scrollController = ScrollController();

  // this will save the keys for each Tab in the Tab Bar, so we can retrieve their position and size for the scroll controller
  final List _keys = [];

  // regist if the the button was tapped
  bool _buttonTap = false;

  @override
  void initState() {
    for (int index = 0; index < _icons.length; index++) {
      // create a GlobalKey for each Tab
      _keys.add(GlobalKey());
    }
    // this creates the controller with 6 tabs (in our case)
    _controller = TabController(vsync: this, length: _icons.length);
    // this will execute the function every time there's a swipe animation
    _controller?.animation?.addListener(_handleTabAnimation);
    // this will execute the function every time the _controller.index value changes
    _controller!.addListener(_handleTabChange);

    _animationControllerOff = AnimationController(vsync: this, duration: const Duration(milliseconds: 75));
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOff!.value = 1.0;
    _colorTweenBackgroundOff = ColorTween(begin: _backgroundOn, end: _backgroundOff).animate(_animationControllerOff!);
    _colorTweenForegroundOff = ColorTween(begin: _foregroundOn, end: _foregroundOff).animate(_animationControllerOff!);

    _animationControllerOn = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOn!.value = 1.0;
    _colorTweenBackgroundOn = ColorTween(begin: _backgroundOff, end: _backgroundOn).animate(_animationControllerOn!);
    _colorTweenForegroundOn = ColorTween(begin: _foregroundOff, end: _foregroundOn).animate(_animationControllerOn!);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      topSafeArea: true,
      appBar: customAppBarView(
          context: context,
          titleText: "Shop Name",
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  "assets/images/chat_ic.png",
                  width: 26,
                  height: 23,
                )),
          )),
      body: CustomScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 1,
            pinned: false,
            expandedHeight: 325,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      customImageButton(
                        padding: 0,
                        width: 80,
                        height: 80,
                        onTap: () {},
                        icon: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(100)),
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/images/placeholder_img.png",
                            fit: BoxFit.fitHeight,
                            image: '${Get.find<ConfigController>().configModel.baseUrls?.baseShopImageUrl}/${widget.sellerModel.image!}',
                            width: 80,
                            height: 80,
                            imageErrorBuilder: (c, o, s) => Image.asset(
                              "assets/images/placeholder_img.png",
                              fit: BoxFit.fitWidth,
                              height: 80,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textView20(
                              context: context,
                              text: widget.sellerModel.name!,
                              maxLine: 2,
                              color: ColorResource.darkTextColor),
                          textView12(
                              context: context, text: widget.sellerModel.name!, color: ColorResource.darkTextColor),
                        ],
                      ),
                      // TextViewSize_12(context: context, text: widget.sellerModel.name!)
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 3),
                        ],
                      ),
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/phone_ic.png",
                              width: 19,
                              height: 19,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            textView15(
                              context: context,
                              text: "010599343",
                              maxLine: 1,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/mail_ic.png",
                              width: 19,
                              height: 19,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            textView15(context: context, text: "sak@myphsar.com", maxLine: 1)
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/pin_ic.png",
                              width: 19,
                              height: 19,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: textView15(
                                    context: context,
                                    text:
                                        "#188B, St 186, Khan toul kork Phnom Penh asdfas fsaf saf safsdf asf saf safsa f a",
                                    maxLine: 2))
                          ],
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: textView20(context: context, text: "Product", color: ColorResource.darkTextColor),
                    )
                  ],
                ),
              ),
            ),
            automaticallyImplyLeading: false,
          ),

          /// Search Button
          SliverPersistentHeader(
              pinned: true,
              delegate: SliverDelegate(
                child: Expanded(
                    child: Column(children: <Widget>[
                  SizedBox(
                      height: 40.0,
                      // this generates our tabs buttons
                      child: ListView.builder(
                          // this gives the TabBar a bounce effect when scrolling farther than it's size
                          physics: const BouncingScrollPhysics(),
                          controller: _scrollController,
                          // make the list horizontal
                          scrollDirection: Axis.horizontal,
                          // number of tabs
                          itemCount: _icons.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                // each button's key
                                key: _keys[index],
                                // padding for the buttons
                                padding: const EdgeInsets.all(6.0),
                                child: ButtonTheme(
                                    child: AnimatedBuilder(
                                  animation: _colorTweenBackgroundOn!,
                                  builder: (context, child) => FloatingActionButton(
                                      // get the color of the button's background (dependent of its state)
                                      focusColor: _getBackgroundColor(index),
                                      // make the button a rectangle with round corners
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
                                      onPressed: () {
                                        setState(() {
                                          _buttonTap = true;
                                          // trigger the controller to change between Tab Views
                                          _controller!.animateTo(index);
                                          // set the current index
                                          _setCurrentIndex(index);
                                          // scroll to the tapped button (needed if we tap the active button and it's not on its position)
                                          _scrollTo(index);
                                        });
                                      },
                                      child: Icon(
                                        // get the icon
                                        _icons[index],
                                        // get the color of the icon (dependent of its state)
                                        color: _getForegroundColor(index),
                                      )),
                                )));
                          })),
                ])),
              )),
          SliverToBoxAdapter(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                // this will host our Tab Views
                child: TabBarView(
                  // and it is controlled by the controller
                  controller: _controller,
                  children: <Widget>[
                    // our Tab Views
                    Icon(_icons[0]),
                    Icon(_icons[1]),
                    Icon(_icons[2]),
                    Icon(_icons[3]),
                    Icon(_icons[4]),
                    Icon(_icons[5])
                  ],
                )),
          )
        ],
      ),
    );
  }

  _getForegroundColor(int index) {
    // the same as the above
    if (index == _currentIndex) {
      return _colorTweenForegroundOn!.value;
    } else if (index == _prevControllerIndex) {
      return _colorTweenForegroundOff!.value;
    } else {
      return _foregroundOff;
    }
  }

  _getBackgroundColor(int index) {
    if (index == _currentIndex) {
      // if it's active button
      return _colorTweenBackgroundOn!.value;
    } else if (index == _prevControllerIndex) {
      // if it's the previous active button
      return _colorTweenBackgroundOff!.value;
    } else {
      // if the button is inactive
      return _backgroundOff;
    }
  }

  // runs when the displayed tab changes
  _handleTabChange() {
    // if a button was tapped, change the current index
    if (_buttonTap) _setCurrentIndex(_controller!.index);

    // this resets the button tap
    if ((_controller!.index == _prevControllerIndex) || (_controller!.index == _aniValue.round())) _buttonTap = false;

    // save the previous controller index
    _prevControllerIndex = _controller!.index;
  }

  _setCurrentIndex(int index) {
    // if we're actually changing the index
    if (index != _currentIndex) {
      setState(() {
        // change the index
        _currentIndex = index;
      });

      // trigger the button animation
      _triggerAnimation();
      // scroll the TabBar to the correct position (if we have a scrollable bar)
      _scrollTo(index);
    }
  }

  _scrollTo(int index) {
    // get the screen width. This is used to check if we have an element off screen
    double screenWidth = MediaQuery.of(context).size.width;

    // get the button we want to scroll to
    RenderBox renderBox = _keys[index].currentContext.findRenderObject();
    // get its size
    double size = renderBox.size.width;
    // and position
    double position = renderBox.localToGlobal(Offset.zero).dx;

    // this is how much the button is away from the center of the screen and how much we must scroll to get it into place
    double offset = (position + size / 2) - screenWidth / 2;

    // if the button is to the left of the middle
    if (offset < 0) {
      // get the first button
      renderBox = _keys[0].currentContext.findRenderObject();
      // get the position of the first button of the TabBar
      position = renderBox.localToGlobal(Offset.zero).dx;

      // if the offset pulls the first button away from the left side, we limit that movement so the first button is stuck to the left side
      if (position > offset) offset = position;
    } else {
      // if the button is to the right of the middle

      // get the last button
      renderBox = _keys[_icons.length - 1].currentContext.findRenderObject();
      // get its position
      position = renderBox.localToGlobal(Offset.zero).dx;
      // and size
      size = renderBox.size.width;

      // if the last button doesn't reach the right side, use it's right side as the limit of the screen for the TabBar
      if (position + size < screenWidth) screenWidth = position + size;

      // if the offset pulls the last button away from the right side limit, we reduce that movement so the last button is stuck to the right side limit
      if (position + size - offset < screenWidth) {
        offset = position + size - screenWidth;
      }
    }

    // scroll the calculated ammount
    _scrollController.animateTo(offset + _scrollController.offset,
        duration: const Duration(milliseconds: 150), curve: Curves.easeInOut);
  }

  _triggerAnimation() {
    // reset the animations so they're ready to go
    _animationControllerOn!.reset();
    _animationControllerOff!.reset();

    // run the animations!
    _animationControllerOn!.forward();
    _animationControllerOff!.forward();
  }

  _handleTabAnimation() {
    // gets the value of the animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
    _aniValue = _controller!.animation!.value;

    // if the button wasn't pressed, which means the user is swiping, and the amount swipped is less than 1 (this means that we're swiping through neighbor Tab Views)
    if (!_buttonTap && ((_aniValue - _prevAniValue).abs() < 1)) {
      // set the current tab index

      _setCurrentIndex(_aniValue.round());
    }

    // save the previous Animation Value
    _prevAniValue = _aniValue;
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 46;

  @override
  double get minExtent => 46;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 46 || oldDelegate.minExtent != 46 || child != oldDelegate.child;
  }
}
