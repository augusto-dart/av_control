import 'package:av_control/models/cards.dart';
import 'package:av_control/pages/home/Components/carousel.dart';
import 'package:flutter/material.dart';

class HomeTopWidget extends StatelessWidget {
  const HomeTopWidget({
    super.key,
    required this.cards,
  });

  // final List<Expense> expenses;
  final List<Cards> cards;

  @override
  Widget build(BuildContext context) {
    double valorTotal = cards.fold<double>(0, (sum, item) => sum + item.valor);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
        Carousel(cartoes: cards),
      ],
    );
  }
}
