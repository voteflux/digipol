import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:voting_app/core/consts.dart';
import 'package:voting_app/core/funcs/convert_topic.dart';
import 'package:voting_app/core/models/user.dart';

class TopicsWidget extends StatelessWidget {
  final List<String> topics;
  final Box userPrefs = Hive.box<List>('USER_TAGS');

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
      topics.add(TopicsButtonWidget(topic: item));
    });
    return topics;
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

class TopicsButtonWidget extends StatefulWidget {
  final String topic;

  TopicsButtonWidget({Key key, @required this.topic}) : super(key: key);

  @override
  _TopicsButtonWidgetState createState() => _TopicsButtonWidgetState();
}

class _TopicsButtonWidgetState extends State<TopicsButtonWidget> {
  final Box userPrefs = Hive.box<List>('USER_TAGS');
  bool _active = false;
  void _updateTagPreferences(String item) {
    List<String> finalTags = [];
    List<String> tags = userPrefs.get('tags');
    finalTags.addAll(tags);
    tags.contains(item)
        ? finalTags.removeWhere((tag) => tag == item)
        : finalTags.add(item);
    userPrefs.put('tags', finalTags);

    setState(() {
      if (_active) {
        _active = false;
      } else {
        _active = true;
      }
    });
    print(_active);
    print(tags);
  }

  @override
  void initState() {
    checkActive(widget.topic);
  }

  void checkActive(String item) {
    List<String> tags = userPrefs.get('tags');
    if (tags.contains(item)) {
      _active = true;
    } else {
      _active = false;
    }
  }

  Widget build(BuildContext context) {
    return OutlineButton.icon(
      splashColor: Theme.of(context).colorScheme.primary,
      textColor: _active
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.onSecondary,
      borderSide: BorderSide(
          color: _active
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSecondary,
          style: BorderStyle.solid,
          width: 1),
      onPressed: () {
        _updateTagPreferences(widget.topic);
      },
      icon: _tagToIcon(widget.topic),
      label: Text(
        widget.topic,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 11,
          color: _active
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
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
