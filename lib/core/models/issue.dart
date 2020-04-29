class Issue {
  String chamber;
  String shortTitle;
  String startDate;
  String endDate;
  String id;
  String question;
  String description;
  String sponsor;
  int yes;
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
