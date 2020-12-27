import 'package:flutter/material.dart';
import 'package:voting_app/core/funcs/convert_topic.dart';

class TopicsWidget extends StatelessWidget {
  final List<String> topics;

  /// To convert tags to topics and display them
  ///
  /// List<String> topics
  /// usage:
  ///
  /// `child: TopicsWidget(topics: topics),`
  TopicsWidget({Key /*?*/ key, @required this.topics}) : super(key: key);

  List<Widget> _buildTopicList(List<String> billTopics, BuildContext context) {
    List<Widget> topics = new List();
    billTopics.forEach((item) {
      topics.add(Padding(
        padding: EdgeInsets.only(right: 10),
        child: Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
//              border: Border.all(color: Colors.grey,) // TODO need to use theme color - Kip
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: _tagToIcon(item),
                ),
                Text(item)
              ],
            )),
      ));
    });
    return topics;
  }

  Icon _tagToIcon(String tag) {
    switch (tag) {
      case HEALTH_EDU_SOCIAL:
        {
          return Icon(
            Icons.person,
            color: Color(0XffF6A6FE),
          );
        } // TODO abstract these colors - Kip
      case ENV_AG:
        {
          return Icon(
            Icons.grass,
            color: Color(0XffBDFDC1),
          );
        }
      case SCI_TRANS_INF:
        {
          return Icon(
            Icons.biotech,
            color: Color(0XffFFABAB),
          );
        }
      case SECURITY_FOREIGN:
        {
          return Icon(
            Icons.shield,
            color: Color(0Xff49F2DD),
          );
        }
      case ECONOMY_FINANCE:
        {
          return Icon(
            Icons.money,
            color: Color(0XffFFF58B),
          );
        }
      case MEDIA_COMS:
        {
          return Icon(
            Icons.smartphone,
            color: Color(0XffB28DFF),
          );
        }
      default:
        {
          return Icon(Icons.map);
        }
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
