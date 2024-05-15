import 'package:av_control/Components/buttons/icon_button.dart';
import 'package:av_control/models/expense.dart';
import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.expense,
  });

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NormalIconButton(
            icone: Icons.attach_money,
            onPress: () => _detalhaDespesa(context, expense),
            width: 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense.descricao,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                "Pago com ${expense.cartao}",
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Text(
            "R\$ ${expense.valor}",
            style: const TextStyle(
              fontSize: 24.0,
            ),
          ),
        ],
      ),
    );
  }

  _detalhaDespesa(BuildContext context, Expense expense) {}
}
