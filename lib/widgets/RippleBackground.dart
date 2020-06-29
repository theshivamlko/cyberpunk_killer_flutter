import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cyberpunkkillerapp/utils/ColorConstant.dart' as ColorConstant;

class RippleBackground extends StatefulWidget {
  final VoidCallback onComplete;
  bool isPlaying;
  AnimationController controller;
  AnimationController fadeController;
  bool flag = false;

  RippleBackground({this.isPlaying, this.onComplete});

  @override
  RippleBackgroundState createState() => RippleBackgroundState();

  void startAnimation() {
    print(controller.isDismissed);
    flag = false;
    controller.reset();
    fadeController.reset();
    controller.forward();
  }
}

class RippleBackgroundState extends State<RippleBackground>
    with TickerProviderStateMixin {
  Animation<double> moveAnim1;
  Animation<double> fadeAnim;

  @override
  void initState() {
    super.initState();

    widget.controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10));

    widget.fadeController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    moveAnim1 = Tween(begin: 100.0, end: 1000.0).animate(
        CurvedAnimation(parent: widget.controller, curve: Curves.decelerate));
    fadeAnim = Tween(begin: 1.0, end: 0.0).animate(widget.fadeController);

    moveAnim1.addListener(() {
      setState(() {
        if (widget.controller.isAnimating &&
            widget.controller.lastElapsedDuration.inSeconds != null &&
            widget.controller.lastElapsedDuration.inSeconds >= 2 &&
            !widget.flag) {
          widget.flag = true;
          widget.onComplete();
        }
        if (widget.controller.isAnimating &&
            widget.controller.lastElapsedDuration.inSeconds != null &&
            (widget.controller.lastElapsedDuration.inSeconds == 6 ||
                widget.controller.lastElapsedDuration.inSeconds == 7)) {
          widget.fadeController.forward();
        }
      });
    });

    moveAnim1.addStatusListener((status) {});

    if (widget.isPlaying != null) {
      Timer(Duration(milliseconds: 500), () {
        widget.controller.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Opacity(
        opacity: fadeAnim.value,
        child: Container(
          width: moveAnim1.value,
          height: moveAnim1.value,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorConstant.neonPinkColor,
                width: 10.0,
                style: BorderStyle.solid,
              )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    widget.fadeController.dispose();
    super.dispose();
  }
}
