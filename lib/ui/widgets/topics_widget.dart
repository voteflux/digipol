import 'package:flutter/material.dart';

class TopicsWidget extends StatelessWidget {
  final List<String> topics;

  /// To convert tags to topics and display them
  ///
  /// List<String> topics
  /// usage:
  ///
  /// `child: TopicsWidget(topics: topics),`
  TopicsWidget({Key /*?*/ key, @required this.topics})
      : super(key: key);

  List<Widget> _buildTopicList(List<String> billTopics, BuildContext context) {
    List<Widget> topics = new List();
    billTopics.forEach((item) {
      topics.add(
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Chip(
              label: Text(_tagToTopic(item)),
              labelStyle: Theme.of(context).textTheme.caption),
        ),
      );
    });
    return topics;
  }

  String _tagToTopic(String tag) {
    switch(tag) {
      case "citizens": {return "Health, Education & Social Issues";}
      case "nature": {return "Environment & Agriculture";}
      case "national development": {return "Science, Transport and Infrastructure";}
      case "national_development": {return "Science, Transport and Infrastructure";}
      case "borders": {return "Security & Foreign Affairs";}
      case "economy": {return "Economy & Finance";}
      case "communications": {return "Media & Communication";}
      default: {return "";}

    }

  }



  @override
  Widget build(BuildContext context) {
    return topics != null
        ? Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: 30.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:
        _buildTopicList(topics, context),
      ),
    )
        : Padding(
      padding: EdgeInsets.only(bottom: 0, top: 0),
    );
  }
}
