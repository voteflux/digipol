import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/ui/views/login_view.dart';

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
    pageLength = 6;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                child: Container(
                  child: PageView(
                    children: <Widget>[
                      _buildWalkThrough(context, 'undraw_Hello_qnas.svg',
                          "Welcome to DigiPol! Where digital direct democracy starts."),
                      _buildWalkThrough(context, 'undraw_process_e90d.svg',
                          "DigiPol collates all the current bills in the Australian goverment for you."),
                      _buildWalkThrough(context, 'undraw_voting_nvu7.svg',
                          "So you can stay informed & make your opinion known when it matters most."),
                      _buildWalkThrough(context, 'undraw_new_ideas_jdea.svg',
                          "You can even vote on current issues created by the community or submit your own (in development)."),
                      _buildWalkThrough(context, 'undraw_ethereum_fb7n.svg',
                          "None of your personal information is stored, and all votes are verified by the ethereum blockchain."),
                      ProfilePage()
                    ],
                    onPageChanged: (value) {
                      setState(() => currentIndexPage = value.toDouble());
                    },
                  ),
                ),
              ),
              Container(
                child: DotsIndicator(
                  dotsCount: pageLength,
                  position: currentIndexPage,
                  decorator: DotsDecorator(
                    color: Colors.grey,
                    activeColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildWalkThrough(context, graphic, text) {
  return Container(
    child: Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: SvgPicture.asset('assets/graphics/' + graphic,
                      semanticsLabel: 'Acme Logo'),
                ),
              ),
              ListBody(
                mainAxis: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(left: 40.0, right: 40.0, bottom: 60.0),
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
