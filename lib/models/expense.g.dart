// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expense _$ExpenseFromJson(Map<String, dynamic> json) => Expense(
      tipo: (json['tipo'] as num).toInt(),
      data: DateTime.parse(json['data'] as String),
      descricao: json['descricao'] as String,
      categoria: json['categoria'] as String,
      cartao: json['cartao'] as String,
      valor: (json['valor'] as num).toDouble(),
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$ExpenseToJson(Expense instance) => <String, dynamic>{
      'tipo': instance.tipo,
      'data': instance.data.toIso8601String(),
      'descricao': instance.descricao,
      'categoria': instance.categoria,
      'cartao': instance.cartao,
      'userId': instance.userId,
      'valor': instance.valor,
    };
