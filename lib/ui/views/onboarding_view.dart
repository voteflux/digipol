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
  List<Map> pages = [
    {
      'image': 'undraw_Hello_qnas.svg',
      'heading': 'Hi!',
      'text':
          'Welcome to DigiPol! Where digital direct democracy starts. (draft)'
    },
    {
      'image': 'undraw_process_e90d.svg',
      'heading': 'What is DigiPol?',
      'text':
          'DigiPol collates all the current bills in the Australian goverment for you. So you can read about them and express your support or opposition by voting directly on a Bill. (draft)'
    },
    {
      'image': 'undraw_voting_nvu7.svg',
      'heading': 'How does it do it?',
      'text':
          'So you can stay informed & make your opinion known when it matters most. (draft)'
    },
    {
      'image': 'undraw_new_ideas_jdea.svg',
      'heading': 'Issues',
      'text':
          'You can even vote on current issues created by the community. (draft)'
    },
    {
      'image': 'undraw_ethereum_fb7n.svg',
      'heading': 'Zero',
      'text':
          'None of your personal information is stored, and all votes are verified by the ethereum blockchain. (draft)'
    }
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
                      ProfilePage()
                    ],
                    onPageChanged: (value) {
                      setState(() => currentIndexPage = value.toDouble());
                    },
                  ),
                ),
              ),
//              Container(
//                child: DotsIndicator(
//                  dotsCount: pageLength,
//                  position: currentIndexPage,
//                  decorator: DotsDecorator(
//                    color: Colors.grey,
//                    activeColor: Theme.of(context).colorScheme.primary,
//                  ),
//                ),
//              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildWalkThrough(context, graphic, heading, text) {
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
