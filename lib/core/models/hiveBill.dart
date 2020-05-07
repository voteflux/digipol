import 'package:hive/hive.dart';
part 'hiveBill.g.dart';

@HiveType(typeId: 0)
class Hivebill {
  @HiveField(0)
  String id;
  @HiveField(1)
  String chamber;


  Hivebill(
      {this.id,
      this.chamber});

  Hivebill.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    chamber = json['data']['chamber'];
  }
}
