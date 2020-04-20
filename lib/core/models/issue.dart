class Issue {
  String chamber;
  String shortTitle;
  String startDate;
  String endDate;
  String id;
  String summary;
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
      this.summary,
      this.description,
      this.sponsor,
      this.yes,
      this.no});

  Issue.fromJson(Map<String, dynamic> json){
    chamber = json['Chamber'];
    shortTitle = json['Short_Title'];
    startDate = json['Start_Date'];
    endDate = json['End_Date'];
    id = json['id'];
    summary = json['Summary'];
    description = json['Description'];
    sponsor = json['Sponsor'];
    yes = json['Yes'];
    no = json['No'];
  }
}
