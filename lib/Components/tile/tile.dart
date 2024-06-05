import 'package:av_control/Components/buttons/icon_button.dart';
import 'package:av_control/models/cards.dart';
import 'package:av_control/models/enums.dart';
import 'package:av_control/models/expense.dart';
import 'package:av_control/pages/register/expense_register.dart';
import 'package:av_control/pages/register/receive_register.dart';
import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.expense,
    required this.card,
    required this.cards,
  });

  final List<Cards> cards;
  final Cards? card;
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
                  expense.tipo == ExpenseType.expense
                      ? "Pago com ${card != null ? card!.descricao : expense.cartao}"
                      : "",
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

  _detalhaDespesa(BuildContext context, Expense expense) {
    if (expense.tipo == ExpenseType.expense) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ExpenseRegister(
            expense: expense,
            cards: cards,
          ),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ReceiveRegister(receive: expense),
        ),
      );
    }
  }
}
