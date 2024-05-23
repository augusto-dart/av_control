import 'package:json_annotation/json_annotation.dart';

enum ExpenseType {
  @JsonValue("bike")
  all,
  @JsonValue("despesa")
  expense,
  @JsonValue("receita")
  receive;

  String toJson() => name;
  static ExpenseType fromJson(String json) => values.byName(json);
}
