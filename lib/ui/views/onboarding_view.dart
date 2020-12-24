import 'dart:convert';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voting_app/core/router.gr.dart';
import 'package:voting_app/ui/widgets/in_line_icon.dart';

class OnBoardingView extends StatefulWidget {
  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class OnboardingSlide {
  String image;
  String heading;
  String body;
  String label;
  List<String> bg; // background gradient colors in String
  OnboardingSlide(this.image, this.label, this.heading, this.body, this.bg);
}


class _OnBoardingViewState extends State<OnBoardingView> {
  PageController _pageController;
  double _currentIndexPage = 0;
  /*late*/ int pageLength;
  String _logo = 'assets/graphics/static-logo.png';

  List<OnboardingSlide> pages = [
    OnboardingSlide(
        'ob-1_ready_to_change.svg',
        'Welcome to DigiPol!',
        'Ready to make a change?',
        'The voting app where you can have your say!',
        ['0xFFBDFDC1', '0xFF49F2DD']
    ),
    OnboardingSlide(
        'ob-2_send_msg_politi.png',
        'Welcome to DigiPol!',
        'Send a message directly to politicians.',
        'By voting directly on the bills that affect you and your fellow '
            'citizens, DigiPol, gives you the power to have your voice heard.',
        ['0xFF4BE2FF', '0xFFB28DFF']
    ),
    OnboardingSlide(
        'ob-3_secure_final_decisions.svg',
        'Welcome to DigiPol!',
        'Your decisions are secure.',
        'By using state-of-the-art technology, no one can alter your votes but '
            'you.\nFind out more in <b:Settings>'
            '<image:icon-ios-android.png:20.0>(temporary icon).',
        ['0xFFF5A5FE', '0xFFFFABAB']
    ),
    OnboardingSlide(
        'ob-4_hear_from_commu.svg',
        'Welcome to DigiPol!',
        'Hear from your community.',
        'Coming soon - You can also comment on bills and see what others have '
            'to say about them!',
        ['0xFFFFABAB', '0xFFFFF6BA']
    ),
    OnboardingSlide(
        'ob-5_say_whats_important.svg',
        'Welcome to DigiPol!',
        'Have your say on what\'s important to you.',
        'We\'ve made it easier to find the bills and issues that you want to '
            'vote on. Start by selecting some tags below, and you can use the '
            '<image:icon-ios-android.png:32.0>(temporary icon) button to '
            'customise your result in the Bill Hub at any time.',
        ['0xFFFFF6BA', '0xFFBDFDF9']
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _currentIndexPage = 0;
    // pageLength = pages.length + 1;
    pageLength = pages.length;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration( // the gradient background
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.9],
              colors: <Color>[
                for(var color in pages[_currentIndexPage.toInt()].bg)
                  Color(int.parse(color))
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                  child: Image.asset(_logo, height: 70.0, width: 70.0),
                ),
              ),
              Flexible(child:
              Container(
                child: PageView(
                  controller: _pageController,
                  children: <Widget>[
                    for (var page in pages)
                      _buildWalkThrough(context, page.image, page.heading,
                          page.body, page.label)
                    // ProfilePage() // moved to StartupView
                  ],
                  onPageChanged: (value) {
                    setState(() => _currentIndexPage = value.toDouble());
                  },
                ),
              ),
              ),
              Container(
                child: RaisedButton(
                  onPressed: _nextPage,
                  child: (_currentIndexPage < pageLength-1) ?
                  Text('Next', style: TextStyle(color: Colors.white),) :
                  Text('View bills', style: TextStyle(color: Colors.white)),
                  color: Colors.black,
                ),
              ),
              Stack(
                children: [
                  if(_currentIndexPage > 0)
                    Align(alignment: Alignment.bottomLeft,
                      child: TextButton(
                        onPressed: _previousPage,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text('BACK',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 12.0),
                      child: DotsIndicator(
                        dotsCount: pageLength,
                        position: _currentIndexPage,
                        decorator: DotsDecorator(
                          color: Colors.grey,
                          activeColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  Align(alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: _toMainScreen,
                      child: Padding(
                        padding:  EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Text('SKIP',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _nextPage() {
    // go to the next page
    (_currentIndexPage < pageLength-1) ?
    _pageController.animateToPage(
      (_currentIndexPage + 1).toInt(),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    ) : _toMainScreen();
  }

  void _toMainScreen() {
    // redirect to the main screen
    // TODO: will change it later - Meena
    Navigator.pushNamed(context, Routes.mainScreen);
  }

  void _previousPage() {
    // go back to the previous page
    if(_currentIndexPage > 0)
    _pageController.animateToPage(
      (_currentIndexPage - 1).toInt(),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutBack,
    );
  }

}

Widget _buildWalkThrough(BuildContext context, String graphic, String heading,
    String body, String label) {
  return Container(
    child: Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Spacer(
                flex: 2
              ),
              ListBody(
                mainAxis: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding:
                      EdgeInsets.only(left: 40.0, right: 40.0, bottom: 20.0),
                    child: Text(label,
                      style: Theme.of(context).textTheme.headline5.apply(
                          color: Colors.black87
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding:
                      EdgeInsets.only(left: 40.0, right: 40.0, bottom: 20.0),
                    child: Text(heading,
                      style: Theme.of(context).textTheme.headline4.apply(
                          color: Colors.black87
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),Padding(
                      padding:
                        EdgeInsets.only(left: 40.0, right: 40.0, bottom: 20.0),
                      child: InLineIcon(body)
                  ),
                ],
              ),
              Spacer(
                flex: 1,
              ),
              Container(
                child: Flexible(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: _loadImage('assets/graphics/' + graphic, heading)
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _loadImage(String path, String label) {
  if(path.split('.')[1] == 'svg')
    return SvgPicture.asset(path,
        semanticsLabel: label);
  else
    return Image.asset(path);
}



