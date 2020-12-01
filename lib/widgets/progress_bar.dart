import 'package:custo_usb/constants.dart';
import 'package:flutter/material.dart';

class MyProgressBar extends StatefulWidget {
  @override
  State<MyProgressBar> createState() => _MyProgressBarState();
}

class _MyProgressBarState extends State<MyProgressBar> {
  double height = 10;
  bool full = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedContainer(
                alignment: Alignment.bottomCenter,
                color: Colors.green,
                width: double.infinity,
                height: height,
                duration: Duration(seconds: 5),
                child: FlatButton(
                  color: Colors.transparent,
                  onPressed: increaseProgressBar,
                  child: Text(" "),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  AnimatedOpacity(
                    child: Center(
                      child: Text(
                        "BURNING...",
                        style: TextStyle(
                          letterSpacing: 10,
                          fontFamily: 'Avenir',
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    opacity: !full ? 1 : 0,
                    duration: Duration(milliseconds: 200),
                  ),
                  AnimatedOpacity(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "DONE",
                                style: TextStyle(
                                  letterSpacing: 10,
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 30,
                                ),
                              ),
                              Text(
                                "You can now eject your drive!",
                                style: kTextStyle(kColor: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                      duration: Duration(seconds: 2),
                      opacity: !full ? 0 : 1),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void increaseProgressBar() {
    if (height < 613) {
      setState(() {
        height += 613;
      });
      return;
    }
    setState(() {
      full = true;
    });
  }
}
