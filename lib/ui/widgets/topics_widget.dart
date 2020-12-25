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
          child: Row(
            children: [
              _tagToIcon(item),
              Text(_tagToTopic(item))
            ],
          )
        ),
      );
    });
    return topics;
  }

  Icon _tagToIcon(String tag) {
    switch(tag) {
      case "citizens": {return Icon(Icons.map);}
      case "citizen": {return Icon(Icons.map);}
      case "nature": {return Icon(Icons.add);}
      case "national development": {return Icon(Icons.add);}
      case "national_development": {return Icon(Icons.add);}
      case "borders": {return Icon(Icons.add);}
      case "economy": {return Icon(Icons.add);}
      case "communications": {return Icon(Icons.add);}
      default: {return Icon(Icons.add);}
    }
  }

  String _tagToTopic(String tag) {
    switch(tag) {
      case "citizens": {return "Health, Education & Social Issues";}
      case "citizen": {return "Health, Education & Social Issues";}
      case "nature": {return "Environment & Agriculture";}
      case "national development": {return "Science, Transport and Infrastructure";}
      case "national_development": {return "Science, Transport and Infrastructure";}
      case "borders": {return "Security & Foreign Affairs";}
      case "economy": {return "Economy & Finance";}
      case "communications": {return "Media & Communication";}
      default: {return "Australia";}
    }

  }



  @override
  Widget build(BuildContext context) {
    return topics != null
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildTopicList(topics, context),
    )
        : Padding(
      padding: EdgeInsets.only(bottom: 0, top: 0),
    );
  }
}
