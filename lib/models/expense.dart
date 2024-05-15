import 'package:equatable/equatable.dart';

class Expense extends Equatable {
  final int tipo;
  final DateTime data;
  final String descricao;
  final String categoria;
  final String cartao;
  final double valor;

  const Expense({
    required this.tipo,
    required this.data,
    required this.descricao,
    required this.categoria,
    required this.cartao,
    required this.valor,
  });

  @override
  List<Object?> get props => [tipo, data, descricao, categoria, cartao, valor];
}
