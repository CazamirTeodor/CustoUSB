import 'package:custo_usb/constants.dart';
import 'package:flutter/material.dart';

class MyProgressBar extends StatefulWidget {
  final Stream<double> stream;
  final double maxHeight = 585;

  MyProgressBar({this.stream});

  @override
  State<MyProgressBar> createState() => _MyProgressBarState();
}

class _MyProgressBarState extends State<MyProgressBar> {
  double progress = 0;
  bool full = false;

  @override
  void initState() {
    super.initState();
    widget.stream.listen((newProgress) {
      setState(() {
        if (newProgress == 100) full = true;
        progress = newProgress;
      });
    });
  }

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
                height: widget.maxHeight * (progress / 100),
                duration: Duration(seconds: 1),
                child: null,
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
                      child: Column(
                        children: [
                          Text(
                            "BURNING...",
                            style: TextStyle(
                              letterSpacing: 10,
                              fontFamily: 'Avenir',
                              fontWeight: FontWeight.w800,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            "${progress.floor()} %",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          )
                        ],
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
}
