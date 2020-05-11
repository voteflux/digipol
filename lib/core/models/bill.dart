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

  Bill(
      {this.id,
      this.chamber,
      this.shortTitle,
      this.question,
      this.introHouse,
      this.passedHouse,
      this.introSenate,
      this.passedSenate,
      this.assentDate,
      this.actNo,
      this.url,
      this.summary,
      this.sponsor,
      this.textLinkDoc,
      this.textLinkPdf,
      this.emLinkPdf,
      this.emLinkHtml,
      this.yes,
      this.no});

  Bill.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    chamber = json['data']['chamber'];
    shortTitle = json['data']['short_title'];
    question = json['data']['question'];
    introHouse = json['data']['intro_house'];
    passedHouse = json['data']['passed_house'];
    introSenate = json['data']['intro_senate'];
    passedSenate = json['data']['passed_senate'];
    assentDate = json['data']['assent_date'];
    actNo = json['data']['act_no'];
    url = json['data']['url'];
    summary = json['data']['summary'];
    sponsor = json['sponsor'];
    textLinkDoc = json['data']['text_link_doc'];
    textLinkPdf = json['data']['text_link_pdf'];
    emLinkPdf = json['data']['em_link_pdf'];
    emLinkHtml = json['data']['em_link_html'];
    yes = json['data']['yes'];
    no = json['data']['no'];
  }
}
