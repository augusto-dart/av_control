import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense.g.dart';

@JsonSerializable()
class Expense extends Equatable {
  final int tipo;
  final DateTime data;
  final String descricao;
  final String categoria;
  final String cartao;
  final String userId;
  final double valor;

  const Expense({
    required this.tipo,
    required this.data,
    required this.descricao,
    required this.categoria,
    required this.cartao,
    required this.valor,
    required this.userId,
  });

  @override
  List<Object?> get props => [
        tipo,
        data,
        descricao,
        categoria,
        cartao,
        valor,
        userId,
      ];

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}
