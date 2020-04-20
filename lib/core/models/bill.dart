class Bill {
  String id;
  String chamber;
  String shortTitle;
  String introHouse;
  String passedHouse;
  String introSenate;
  String passedSenate;
  String assentDate;
  String actNo;
  String url;
  String summary;
  String sponsor;
  String textLinkDoc;
  String textLinkPdf;
  String emLinkPdf;
  String emLinkHtml;
  int yes;
  int no;

  Bill(
      {this.id,
      this.chamber,
      this.shortTitle,
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

  Bill.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    chamber = json['data']['chamber'];
    shortTitle = json['data']['short_title'];
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