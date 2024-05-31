import 'package:av_control/models/cards.dart';
import 'package:av_control/models/enums.dart';
import 'package:av_control/models/expense.dart';
import 'package:av_control/pages/home/Components/carousel.dart';
import 'package:flutter/material.dart';

class HomeTopWidget extends StatelessWidget {
  const HomeTopWidget({
    super.key,
    required this.expenses,
    required this.cards,
  });

  final List<Expense> expenses;
  final Future<List<Cards>> cards;

  @override
  Widget build(BuildContext context) {
    double valorTotal = expenses
        .where((element) => element.tipo == ExpenseType.expense)
        .fold<double>(0, (sum, item) => sum + item.valor);

    double saldo =
        expenses.fold<double>(0, (sum, item) => sum + item.valorCalc);

    return FutureBuilder(
      future: cards,
      builder: (context, snapshot) {
        List<Cards> cartoes = [];
        if (snapshot.hasData) {
          cartoes = snapshot.data!;
          for (Cards card in cartoes) {
            card.setValor(expenses
                .where((element) => element.cartao == card.descricao)
                .fold(0, (sum, item) => sum + item.valor));
          }
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Despesas',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'R\$ $valorTotal',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Saldo',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'R\$ $saldo',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Carousel(cartoes: cartoes),
          ],
        );
      },
    );
  }
}
