import 'package:av_control/models/cards.dart';
import 'package:av_control/pages/home/Components/carousel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeTopWidget extends StatefulWidget {
  const HomeTopWidget({
    super.key,
    required this.cards,
  });
  final List<Cards> cards;

  @override
  State<HomeTopWidget> createState() => _HomeTopWidgetState();
}

class _HomeTopWidgetState extends State<HomeTopWidget> {
  final DateTime hoje = DateTime.now();
  late DateTime dataSelecionada;
  final f = DateFormat('MM/yyyy');
  @override
  void initState() {
    dataSelecionada = DateTime(hoje.year, hoje.month, hoje.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double valorTotal =
        widget.cards.fold<double>(0, (sum, item) => sum + item.valor);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Despesas do Mês ${f.format(dataSelecionada)}',
                style: Theme.of(context).textTheme.labelLarge,
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
        Carousel(cartoes: widget.cards),
      ],
    );
  }
}
