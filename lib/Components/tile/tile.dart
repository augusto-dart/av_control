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
    const double width = 200.0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: NormalIconButton(
              icone: Icons.attach_money,
              onPress: () => _detalhaDespesa(context, expense),
              width: 50,
              parentWidth: width,
            ),
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Column(
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
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              "R\$ ${expense.valor}",
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _detalhaDespesa(BuildContext context, Expense expense) {}
}
