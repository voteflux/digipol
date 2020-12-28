import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 4)
class User {
  @HiveField(0)
  String firstName;
  @HiveField(1)
  String ethereumAddress;
  @HiveField(2)
  List<String> tags;

  User({this.firstName, this.ethereumAddress, this.tags});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        firstName: json['first_name'] as String,
        ethereumAddress: json['id'] as String,
        tags: json['tags'] as List<String>);
  }
}
