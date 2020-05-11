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
  int yes;
  @HiveField(9)
  int no;

  Issue(
      {this.chamber,
      this.shortTitle,
      this.startDate,
      this.endDate,
      this.id,
      this.question,
      this.description,
      this.sponsor,
      this.yes,
      this.no});

  Issue.fromJson(Map<String, dynamic> json){
    chamber = json['data']['chamber'];
    shortTitle = json['data']['short_title'];
    startDate = json['data']['start_date'];
    endDate = json['data']['end_date'];
    id = json['_id'];
    question = json['data']['question'];
    description = json['data']['description'];
    sponsor = json['data']['sponsor'];
  }
}
