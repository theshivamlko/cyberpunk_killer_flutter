import 'package:cyberpunkkillerapp/utils/ColorConstant.dart';
import 'package:cyberpunkkillerapp/models/Device.dart';
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HomeCard extends StatefulWidget {
  Map map;

  HomeCard(this.map);

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> with TickerProviderStateMixin {
  Device device;

  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    widget.map = widget.map ?? Map();
    print(widget.map);

    animationController = AnimationController(
        lowerBound: 1.0,
        upperBound: 2.0,
        duration: Duration(seconds: 1),
        vsync: this);

    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      animationController.addListener(() {
        setState(() {});
      });
      animationController.repeat(reverse: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    device = Device(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(device.deviceWidth * .05),
          image: DecorationImage(
            image: NetworkImage(widget.map['image']),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: neonPinkColor,
              blurRadius: 2.0 * animationController.value,
              spreadRadius: 3.0 * animationController.value,
            ),
            BoxShadow(
              color: Colors.white60,
              blurRadius: 1.0 * animationController.value,
              spreadRadius: 1.0 * animationController.value,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(device.deviceWidth * .05),
          child: Stack(
            children: <Widget>[
              /*      Image.network(
                widget.map['image'],
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitHeight,
              ),*/
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    widget.map['title']??'',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 40,
                      fontFamily: 'Cyberpunk',
                      shadows: [
                        Shadow(
                          color: midPrimaryColor,
                          //  offset: Offset(0.5, 0.0),
                          blurRadius: 30 * animationController.value,
                        ),
                        Shadow(
                          color: neonPinkColor,
                          //  offset: Offset(0.5, 0.0),
                          blurRadius: 15 * animationController.value,
                        ),
                        Shadow(
                          color: neonPinkColor,
                          // offset: Offset(0.5, 0.0),
                          blurRadius: 10 * animationController.value,
                        ),
                        Shadow(
                          color: neonPinkColor,
                          //  offset: Offset(0.5, 0.0),
                          blurRadius: 5 * animationController.value,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
