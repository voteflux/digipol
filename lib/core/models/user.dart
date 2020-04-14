class User {
  String firstName;
  String id;

  User.initial()
      : id = '',
        firstName = '';

  User({this.firstName,this.id});

  User.fromJson(Map<String, dynamic> json){
    firstName = json['first_name'];
    id = json['id'];
  }
}