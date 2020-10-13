import 'package:hive/hive.dart';
on.dart';
import 'package:hive/hive.dart';

part 'issue.g.dart';

@HiveType(typeId: 3)
class Issue {
  @HiveField(0)
  String chamber;
  @HiveField(1)
  String shortTitle;
  @HiveField(2)
  String startDate;
  @HiveField(3)
  String endDate;
  @HiveField(4)
  String id;
  @HiveField(5)
  String question;
  @HiveField(6)
  String description;
  @HiveField(7)
  String sponsor;
  @HiveField(8)
  int /*?*/ yes;
  @HiveField(9)
  int /*?*/ no;

  Issue(
      {@required this.chamber,
      @required this.shortTitle,
      @required this.startDate,
      @required this.endDate,
      @required this.id,
      @required this.question,
      @required this.description,
      @required this.sponsor,
      this.yes,
      this.no});

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      chamber: json['data']['chamber'] as String,
      shortTitle: json['data']['short_title'] as String,
      startDate: json['data']['start_date'] as String,
      endDate: json['data']['end_date'] as String,
      id: json['_id'] as String,
      question: json['data']['question'] as String,
      description: json['data']['description'] as String,
      sponsor: json['data']['sponsor'] as String,
    );
  }
}
