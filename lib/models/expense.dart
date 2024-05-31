import 'package:av_control/models/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@JsonSerializable()
class Expense extends Equatable {
  final ExpenseType tipo;
  final Timestamp data;
  final String descricao;
  final String categoria;
  final String cartao;
  final String userId;
  final double valor;

  double get valorCalc {
    return tipo == ExpenseType.expense ? valor * -1 : valor;
  }

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

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        tipo: ExpenseType.fromJson(json['tipo'] as String),
        data: json['data'] as Timestamp,
        descricao: json['descricao'] as String,
        categoria: json['categoria'] as String,
        cartao: json['cartao'] as String,
        valor: (json['valor'] as num).toDouble(),
        userId: json['userId'] as String,
      );

  Map<String, dynamic> toJson() => _$ExpenseToJson(this);

  Map<String, dynamic> _$ExpenseToJson(Expense instance) => <String, dynamic>{
        'tipo': instance.tipo.toJson(),
        'data': instance.data,
        'descricao': instance.descricao,
        'categoria': instance.categoria,
        'cartao': instance.cartao,
        'userId': instance.userId,
        'valor': instance.valor,
      };
}
