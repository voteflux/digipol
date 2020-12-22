import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
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
  OnboardingSlide(this.image, this.label, this.heading, this.body);
}

class _OnBoardingViewState extends State<OnBoardingView> {

  double currentIndexPage = 0;
  /*late*/ int pageLength;

  List<OnboardingSlide> pages = [
    OnboardingSlide(
        'undraw_Hello_qnas.svg',
        'Welcome to DigiPol!',
        'Ready to make a change?',
        'The voting app where you can have your say!'),
    OnboardingSlide(
        'undraw_process_e90d.svg',
        'Welcome to DigiPol!',
        'Send a message directly to politicians.',
        'By voting directly on the bills that affect you and your fellow citizens, DigiPol, gives you the power to have your voice heard.'),
    OnboardingSlide(
        'undraw_voting_nvu7.svg',
        'Welcome to DigiPol!',
        'Your decisions are secure.',
        'By using state-of-the-art technology, no one can alter your votes but you.\nFind out more in `icon-ios-android.png`Settings.'),
    OnboardingSlide(
        'undraw_new_ideas_jdea.svg',
        'Welcome to DigiPol!',
        'Hear from your community.',
        "Coming soon - You can also comment on bills and see what others have to say about them!"),
    OnboardingSlide(
        'undraw_ethereum_fb7n.svg',
        'Welcome to DigiPol!',
        'Have your say on what\'s important to you.',
        'We\'ve made it easier to find the bills and issues that you want to vote on. Start by selecting some tags below, and you can use the `icon-ios-android.png`(Interest) button to customise your result in the Bill Hub at any time.'),
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
    String body, String label) {
  String logo = 'assets/graphics/static-logo.png';
  return Container(
    child: Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Spacer(
                flex: 1
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Image.asset(logo, height: 70.0, width: 70.0),
                ),
              ),
              ListBody(
                mainAxis: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding:
                    EdgeInsets.only(
                        left: 40.0,
                        right: 40.0,
                        top: 40,
                        bottom: 20.0
                    ),
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(left: 40.0, right: 40.0, bottom: 20.0),
                    child: Text(
                      heading,
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  ),Padding(
                    padding:
                    EdgeInsets.only(left: 40.0, right: 40.0, bottom: 20.0),
                    child: InLineIcon(text: body)
                  ),
                ],
              ),
              Flexible(
                flex: 10,
                child: Padding(
                  padding: EdgeInsets.only(left: 80.0, right: 80.0),
                  child: SvgPicture.asset('assets/graphics/' + graphic,
                      semanticsLabel: label),
                  ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}



