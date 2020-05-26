import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 4)
class User {
  @HiveField(0)
  String firstName;
  @HiveField(1)
  String ethereumAddress;

  User({this.firstName,this.ethereumAddress});

  User.fromJson(Map<String, dynamic> json){
    firstName = json['first_name'];
    ethereumAddress = json['id'];
  }
}