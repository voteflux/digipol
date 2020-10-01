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
      {
      /*required*/ this.id,
      /*required*/ this.chamber,
      /*required*/ this.shortTitle,
      /*required*/ this.question,
      /*required*/ this.introHouse,
      /*required*/ this.passedHouse,
      /*required*/ this.introSenate,
      /*required*/ this.passedSenate,
      /*required*/ this.assentDate,
      /*required*/ this.actNo,
      /*required*/ this.url,
      /*required*/ this.summary,
      /*required*/ this.sponsor,
      /*required*/ this.textLinkDoc,
      /*required*/ this.textLinkPdf,
      /*required*/ this.emLinkPdf,
      /*required*/ this.emLinkHtml,
      /*required*/ this.yes,
      /*required*/ this.no,
      /*required*/ this.portfolio,
      /*required*/ this.startDate,
      /*required*/ this.topics});

  factory Bill.fromJson(Map<String, dynamic> json) {
    return new Bill(
        id: json['_id'] as String,
        chamber: json['data']['chamber'] as String,
        shortTitle: json['data']['short_title'] as String,
        question: json['data']['question'] as String,
        introHouse: json['data']['intro_house'] as String,
        passedHouse: json['data']['passed_house'] as String,
        introSenate: json['data']['intro_senate'] as String,
        passedSenate: json['data']['passed_senate'] as String,
        assentDate: json['data']['assent_date'] as String,
        actNo: json['data']['act_no'] as String,
        url: json['data']['url'] as String,
        summary: json['data']['summary'] as String,
        sponsor: json['sponsor'] as String,
        textLinkDoc: json['data']['text_link_doc'] as String,
        textLinkPdf: json['data']['text_link_pdf'] as String,
        emLinkPdf: json['data']['em_link_pdf'] as String,
        emLinkHtml: json['data']['em_link_html'] as String,
        yes: json['data']['yes'] as int,
        no: json['data']['no'] as int,
        portfolio: json['data']['portfolio'] as String,
        startDate: json['data']['start_date'] as String,
        topics: json['data']['topics'] as List<String>);
  }
}
