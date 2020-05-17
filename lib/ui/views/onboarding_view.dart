import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class OnBoardingView extends StatefulWidget {
  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  double currentIndexPage;
  int pageLength;

  @override
  void initState() {
    super.initState();
    currentIndexPage = 0;
    pageLength = 3;
  }

  @override
  Widget build(BuildContext context) {
    double marginFromSafeArea = 24;
    var heightOfScreen =
        MediaQuery.of(context).size.height - marginFromSafeArea;
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: heightOfScreen * 0.6,
              child: PageView(
                children: <Widget>[
                  _buildWalkThrough(),
                  _buildWalkThrough(),
                  _buildWalkThrough()
                ],
                onPageChanged: (value) {
                  setState(() => currentIndexPage = value.toDouble());
                },
              ),
            ),
            Container(
              height: heightOfScreen * 0.1,
              child: DotsIndicator(
                dotsCount: pageLength,
                position: currentIndexPage,
                decorator: DotsDecorator(
                  color: Colors.blue,
                  activeColor: Colors.red,
                ),
              ),
            ),
            Container(height: heightOfScreen * 0.2)
          ],
        ),
      )),
    );
  }
}

Widget _buildWalkThrough() {
  return Container(
    child: Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Image.asset(
                "assets/graphics/vote.png",
              ),
              ListBody(
                mainAxis: Axis.vertical,
                children: <Widget>[
                  Text(
                    "StringConst.JOIN",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
