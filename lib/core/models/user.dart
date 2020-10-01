import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 4)
class User {
  @HiveField(0)
  String firstName;
  @HiveField(1)
  String ethereumAddress;

  User({required this.firstName, required this.ethereumAddress});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'] as String,
      ethereumAddress: json['id'] as String,
    );
  }
}
