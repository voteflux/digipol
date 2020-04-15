class Bill {
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
      {this.chamber,
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
    chamber = json['chamber'];
    shortTitle = json['short_title'];
    introHouse = json['intro_house'];
    passedHouse = json['passed_house'];
    introSenate = json['intro_senate'];
    passedSenate = json['passed_senate'];
    assentDate = json['assent_date'];
    actNo = json['act_no'];
    url = json['url'];
    summary = json['summary'];
    sponsor = json['sponsor'];
    textLinkDoc = json['text_link_doc'];
    textLinkPdf = json['text_link_pdf'];
    emLinkPdf = json['em_link_pdf'];
    emLinkHtml = json['em_link_html'];
    yes = json['yes'];
    no = json['no'];
  }
}