import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:voting_app/ui/views/login_view.dart';

class OnBoardingView extends StatefulWidget {
  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  double currentIndexPage;
  int pageLength;
  List<Map<String, String>> pages = [
    {
      'image': 'undraw_Hello_qnas.svg',
      'heading': 'Hi!',
      'text':
          'Welcome to DigiPol! Where digital direct democracy starts. (draft)',
      'label': 'Welcome!'
    },
    {
      'image': 'undraw_process_e90d.svg',
      'heading': 'What is DigiPol?',
      'text':
          'DigiPol collates all the current bills in the Australian government for you. So you can read about them and express your support or opposition by voting directly on a Bill. (draft)',
      'label': 'The DigiPol Process'
    },
    {
      'image': 'undraw_voting_nvu7.svg',
      'heading': 'How does it do it?',
      'text':
          'So you can stay informed & make your opinion known when it matters most. (draft)',
      'label': 'DigiPol keeps you informed'
    },
    {
      'image': 'undraw_new_ideas_jdea.svg',
      'heading': 'Issues',
      'text':
          'You can even vote on current issues created by the community. (draft)',
      'label': "DigiPol let's you vote on issues."
    },
    {
      'image': 'undraw_ethereum_fb7n.svg',
      'heading': 'Zero',
      'text':
          'None of your personal information is stored, and all votes are verified by our blockchain. (draft)',
      'label':
          'Your personal info is safe and all votes are verified by a blockchain.'
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
                      for (var page in pages)
                        _buildWalkThrough(context, page['image'],
                            page['heading'], page['text'], page['label']),
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
                      semanticsLabel: label) as Widget,
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
