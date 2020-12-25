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
          child: Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
          border: Border.all(color: Colors.grey) // TODO need to use theme color - Kip
        ),
            child: Row(
              children: [
                _tagToIcon(item),
                Text(_tagToTopic(item))
              ],
            )
          ),
          )
      );
    });
    return topics;
  }

  Icon _tagToIcon(String tag) {
    switch(tag) {
      case "citizens": {return Icon(Icons.person, color: Color(0XffF6A6FE),);} // TODO abstract these colors - Kip
      case "citizen": {return Icon(Icons.person, color: Color(0XffF6A6FE),);}
      case "nature": {return Icon(Icons.grass, color: Color(0XffBDFDC1),);}
      case "national development": {return Icon(Icons.biotech, color: Color(0XffFFABAB),);}
      case "national_development": {return Icon(Icons.biotech, color: Color(0XffFFABAB),);}
      case "borders": {return Icon(Icons.shield, color: Color(0Xff49F2DD),);}
      case "economy": {return Icon(Icons.money, color: Color(0XffFFF58B),);}
      case "communications": {return Icon(Icons.smartphone, color: Color(0XffB28DFF),);}
      default: {return Icon(Icons.add, color: Color(0XffB28DFF),);}
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
