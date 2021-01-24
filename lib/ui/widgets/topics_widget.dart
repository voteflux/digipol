import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:voting_app/core/consts.dart';
import 'package:voting_app/core/funcs/convert_topic.dart';

class TopicsWidget extends StatelessWidget {
  final List<String> topics;
  final bool canPress;
  final bool hasFill;
  final bool compressed;

  /// To convert tags to topics and display them
  ///
  /// List<String> topics
  /// usage:
  ///
  /// `child: TopicsWidget(topics: topics),`
  TopicsWidget(
      {Key /*?*/ key,
      @required this.topics,
      @required this.canPress,
      this.hasFill = false,
      this.compressed = false})
      : super(key: key);

  List<Widget> _buildTopicList(List<String> billTopics, BuildContext context,
      bool canPress, bool compressed) {
    List<Widget> topics = new List();
    billTopics.forEach((item) {
      topics.add(TopicsButtonWidget(
        topic: item,
        canPress: canPress,
        hasFill: hasFill,
        compressed: compressed,
      ));
    });
    return topics;
  }

  @override
  Widget build(BuildContext context) {
    return topics != null
        ? compressed == false
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    _buildTopicList(topics, context, canPress, compressed),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    _buildTopicList(topics, context, canPress, compressed),
              )
        : Padding(
            padding: EdgeInsets.only(bottom: 0, top: 0),
          );
  }
}

class TopicsButtonWidget extends StatefulWidget {
  final String topic;
  final bool canPress;
  final bool hasFill;
  final bool compressed;

  TopicsButtonWidget(
      {Key key,
      @required this.topic,
      @required this.canPress,
      this.hasFill = false,
      this.compressed = false})
      : super(key: key);

  @override
  _TopicsButtonWidgetState createState() => _TopicsButtonWidgetState();
}

class _TopicsButtonWidgetState extends State<TopicsButtonWidget> {
  final Box<List> userTags = Hive.box<List>(HIVE_USER_PREFS_LIST);
  bool _active = false;

  void _updateTagPreferences(String item) {
    List<String> blankTags = [];
    List<String> finalTags = [];

    List<String> tags =
        userTags.get(USER_TAGS, defaultValue: blankTags).cast<String>();

    finalTags.addAll(tags);

    finalTags.contains(item)
        ? finalTags.removeWhere((tag) => tag == item)
        : finalTags.add(item);

    setState(() {
      if (finalTags.contains(item)) {
        _active = true;
      } else {
        _active = false;
      }
    });
    userTags.put(USER_TAGS, finalTags);
  }

  @override
  void initState() {
    checkActive(widget.topic);
  }

  void checkActive(String item) {
    List<dynamic> tags = userTags.get(USER_TAGS);
    if (tags != null && tags.contains(item)) {
      _active = true;
    } else {
      _active = false;
    }
  }

  Widget build(BuildContext context) {
    Widget TopicButton = RaisedButton.icon(
      splashColor: Theme.of(context).colorScheme.primary,
      color: widget.hasFill ? Color.fromRGBO(0, 0, 0, 0.6) : Colors.transparent,
      highlightElevation: 0,
      disabledColor: Colors.transparent,
      textColor: _active
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.onSecondary,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(
              color: _active
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSecondary,
              width: 1.5)),
      onPressed: widget.canPress
          ? () {
              _updateTagPreferences(widget.topic);
            }
          : null,
      icon: _tagToIcon(widget.topic),
      label: Text(
        widget.topic,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 10,
          color: _active
              ? Theme.of(context).colorScheme.primary
              : widget.hasFill
                  ? Colors.white
                  : Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );

    return widget.compressed == false ? TopicButton : _tagToIcon(widget.topic);
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
