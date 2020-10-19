import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'bill.g.dart';

@HiveType(typeId: 2)
class Bill {
  @HiveField(0)
  String id;
  @HiveField(1)
  String chamber;
  @HiveField(2)
  String shortTitle;
  @HiveField(3)
  String question;
  @HiveField(4)
  String introHouse;
  @HiveField(5)
  String passedHouse;
  @HiveField(6)
  String introSenate;
  @HiveField(7)
  String passedSenate;
  @HiveField(8)
  String assentDate;
  @HiveField(9)
  String actNo;
  @HiveField(10)
  String url;
  @HiveField(11)
  String summary;
  @HiveField(12)
  String sponsor;
  @HiveField(13)
  String textLinkDoc;
  @HiveField(14)
  String textLinkPdf;
  @HiveField(15)
  String emLinkPdf;
  @HiveField(16)
  String emLinkHtml;
  @HiveField(17)
  int yes;
  @HiveField(18)
  int no;
  @HiveField(19)
  String portfolio;
  @HiveField(20)
  String startDate;
  @HiveField(21)
  List<String> topics;

  Bill(
      {@required this.id,
      @required this.chamber,
      @required this.shortTitle,
      @required this.question,
      @required this.introHouse,
      @required this.passedHouse,
      @required this.introSenate,
      @required this.passedSenate,
      @required this.assentDate,
      @required this.actNo,
      @required this.url,
      @required this.summary,
      @required this.sponsor,
      @required this.textLinkDoc,
      @required this.textLinkPdf,
      @required this.emLinkPdf,
      @required this.emLinkHtml,
      @required this.yes,
      @required this.no,
      @required this.portfolio,
      @required this.startDate,
      @required this.topics});

  factory Bill.fromJson(Map<String, dynamic> json) {
    var data = json['data'] as Map<String, dynamic>;
    var topics = ((data['topics'] as List<dynamic>) ?? <dynamic>[])
        .map((dynamic s) => s as String)
        .toList();
    return new Bill(
      id: json['_id'] as String,
      chamber: data['chamber'] as String,
      shortTitle: data['short_title'] as String,
      question: data['question'] as String,
      introHouse: data['intro_house'] as String,
      passedHouse: data['passed_house'] as String,
      introSenate: data['intro_senate'] as String,
      passedSenate: data['passed_senate'] as String,
      assentDate: data['assent_date'] as String,
      actNo: data['act_no'] as String,
      url: data['url'] as String,
      summary: data['summary'] as String,
      sponsor: json['sponsor'] as String,
      textLinkDoc: data['text_link_doc'] as String,
      textLinkPdf: data['text_link_pdf'] as String,
      emLinkPdf: data['em_link_pdf'] as String,
      emLinkHtml: data['em_link_html'] as String,
      portfolio: data['portfolio'] as String,
      startDate: data['start_date'] as String,
      topics: List<String>.from(topics),
      yes: data['yes'] as int,
      no: data['no'] as int,
    );
  }

  @override
  String toString() {
    return 'Bill <id: ${this.id}; shortTitle: ${this.shortTitle}>';
  }
}
