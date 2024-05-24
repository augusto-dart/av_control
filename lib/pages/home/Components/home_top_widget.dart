import 'package:av_control/models/cards.dart';
import 'package:av_control/models/expense.dart';
import 'package:av_control/pages/home/Components/carousel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeTopWidget extends StatelessWidget {
  HomeTopWidget({
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;

  final List<Cards> cards = [
    Cards(
      descricao: 'Nubank',
      cor: Colors.purple.value,
      userId: FirebaseAuth.instance.currentUser!.uid,
    ),
    Cards(
      descricao: 'Bradesco',
      cor: Colors.red.value,
      userId: FirebaseAuth.instance.currentUser!.uid,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double valorTotal =
        expenses.fold<double>(0, (sum, item) => sum + item.valor);

    for (Cards card in cards) {
      card.setValor(expenses
          .where((element) => element.cartao == card.descricao)
          .fold(0, (sum, item) => sum + item.valor));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Valor Total',
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
        Carousel(cartoes: cards),
      ],
    );
  }
}
