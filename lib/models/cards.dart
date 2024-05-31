// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Cards implements Equatable {
  Cards({
    required this.descricao,
    required this.cor,
    required this.userId,
    this.valor = 0.0,
  });

  late final String _id;
  String get id => _id;
  set id(String value) {
    _id = value;
  }

  final String descricao;
  final int cor;
  late double valor;
  final String userId;

  void setValor(double valor) {
    this.valor = valor;
  }

  factory Cards.fromJson(Map<String, dynamic> json) => Cards(
        descricao: json['descricao'] as String,
        valor: (json['valor'] as num).toDouble(),
        cor: json['cor'] as int,
        userId: json['userId'] as String,
      );

  Map<String, dynamic> toJson() => _$ExpenseToJson(this);

  Map<String, dynamic> _$ExpenseToJson(Cards instance) => <String, dynamic>{
        'descricao': instance.descricao,
        'valor': instance.valor,
        'cor': instance.cor,
        'userId': instance.userId,
      };

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;
}
