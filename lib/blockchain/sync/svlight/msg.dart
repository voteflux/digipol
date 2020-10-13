import 'package:adt_annotation/adt_annotation.dart';

part 'msg.g.dart';

@union
class Msg {
  const factory Msg.addDemocracy(String democId) = _$Msg.addDemocracy;
}
