// ignore_for_file: non_constant_identifier_names

import 'package:av_control/Components/tile/tile.dart';
import 'package:av_control/models/cards.dart';
import 'package:av_control/models/enums.dart';
import 'package:av_control/models/expense.dart';
import 'package:flutter/material.dart';

class LastExpenses extends StatefulWidget {
  const LastExpenses({
    super.key,
    required this.expenses,
    required this.cards,
  });
  final List<Expense> expenses;
  final List<Cards> cards;

  @override
  State<LastExpenses> createState() => _LastExpensesState();
}

class _LastExpensesState extends State<LastExpenses> {
  late ExpenseType selectedType = ExpenseType.all;
  late List<Expense> filteredExpenses;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.cards.isNotEmpty) {
    //   for (int i = 0; i < widget.expenses.length; i++) {
    //     Expense despesa = widget.expenses[i];
    //     Cards card =
    //         widget.cards.where((card) => card.id == despesa.cartao).first;
    //     despesa.nomeCartao = card.descricao;
    //   }
    // }
    filteredExpenses = widget.expenses
        .where((x) => selectedType == ExpenseType.all || x.tipo == selectedType)
        .toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            style: BorderStyle.solid,
            color: Theme.of(context).dividerColor,
          ),
        ),
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Histórico de Transações",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Lista de todas as transações já realizadas",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  choice(ExpenseType.all, "Tudo"),
                  choice(ExpenseType.expense, "Despesas"),
                  choice(ExpenseType.receive, "Receitas"),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: filteredExpenses.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return Tile(
                      expense: filteredExpenses[index],
                      card: widget.cards
                          .where((card) =>
                              card.id == filteredExpenses[index].cartao)
                          .firstOrNull);
                },
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ChoiceChip choice(ExpenseType tipo, String label) {
    return ChoiceChip(
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedColor: Theme.of(context).colorScheme.inversePrimary,
      elevation: 0,
      side: BorderSide(
        color: Theme.of(context).dividerColor,
      ),
      label: Text(label),
      selected: selectedType == tipo,
      onSelected: (bool selected) {
        setState(() {
          selected ? selectedType = tipo : null;
        });
      },
    );
  }
}
