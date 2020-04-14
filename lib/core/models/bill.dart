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
    chamber = json['Chamber'];
    shortTitle = json['Short_Title'];
    introHouse = json['Intro_House'];
    passedHouse = json['Passed_House'];
    introSenate = json['Intro_Senate'];
    passedSenate = json['Passed_Senate'];
    assentDate = json['Assent_Date'];
    actNo = json['Act_No.'];
    url = json['URL'];
    summary = json['Summary'];
    sponsor = json['Sponsor'];
    textLinkDoc = json['text_link_doc'];
    textLinkPdf = json['text_link_pdf'];
    emLinkPdf = json['em_link_pdf'];
    emLinkHtml = json['em_link_html'];
    yes = json['Yes'];
    no = json['No'];
  }
}