import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voting_app/ui/views/login_view.dart';

class OnBoardingView extends StatefulWidget {
  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class OnboardingSlide {
  String image;
  String heading;
  String body;
  String label;

  OnboardingSlide(this.image, this.heading, this.body, this.label);
}

class _OnBoardingViewState extends State<OnBoardingView> {
  double currentIndexPage = 0;
  /*late*/ int pageLength;
  List<OnboardingSlide> pages = [
    OnboardingSlide(
        'undraw_Hello_qnas.svg',
        'Hi!',
        'Welcome to DigiPol! Where digital direct democracy starts. (draft)',
        'Welcome!'),
    OnboardingSlide(
        'undraw_process_e90d.svg',
        'What is DigiPol?',
        'DigiPol collates all the current bills in the Australian government for you. So you can read about them and express your support or opposition by voting directly on a Bill. (draft)',
        'The DigiPol Process'),
    OnboardingSlide(
        'undraw_voting_nvu7.svg',
        'How does it do it?',
        'So you can stay informed & make your opinion known when it matters most. (draft)',
        'DigiPol keeps you informed'),
    OnboardingSlide(
        'undraw_new_ideas_jdea.svg',
        'Issues',
        'You can even vote on current issues created by the community. (draft)',
        "DigiPol let's you vote on issues."),
    OnboardingSlide(
        'undraw_ethereum_fb7n.svg',
        'Zero',
        'None of your personal information is stored, and all votes are verified by our blockchain. (draft)',
        'Your personal info is safe and all votes are verified by a blockchain.'),
  ];

  @override
  void initState() {
    super.initState();
    currentIndexPage = 0;
    pageLength = pages.length + 1;
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
                      for (var page in pages)
                        _buildWalkThrough(context, page.image, page.heading,
                            page.body, page.label)
                      // ProfilePage() // moved to StartupView
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

Widget _buildWalkThrough(BuildContext context, String graphic, String heading,
    String text, String label) {
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
                      semanticsLabel: label),
                ),
              ),
              ListBody(
                mainAxis: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(left: 40.0, right: 40.0, bottom: 20.0),
                    child: Text(
                      heading,
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 40.0, right: 40.0, bottom: 60.0),
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.bodyText1,
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
