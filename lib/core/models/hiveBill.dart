import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class HiveBill {
  @HiveField(0)
  String id;
  @HiveField(1)
  String chamber;


  HiveBill(
      {this.id,
      this.chamber});

  HiveBill.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    chamber = json['data']['chamber'];
  }
}
