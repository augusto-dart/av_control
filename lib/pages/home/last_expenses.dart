// ignore_for_file: non_constant_identifier_names

import 'package:av_control/Components/tile/tile.dart';
import 'package:av_control/models/enums.dart';
import 'package:av_control/models/expense.dart';
import 'package:flutter/material.dart';

class LastExpenses extends StatefulWidget {
  const LastExpenses({
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;
  @override
  State<LastExpenses> createState() => _LastExpensesState();
}

class _LastExpensesState extends State<LastExpenses> {
  late ExpenseType selectedExpenseType;
  late List<Expense> filteredExpenses;

  @override
  void initState() {
    super.initState();
    selectedExpenseType = ExpenseType.all;
    filteredExpenses = widget.expenses;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 6.0,
        shadowColor: Colors.blueGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Histórico de Transações",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Lista de todas as transações já realizadas",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedExpenseType = ExpenseType.all;
                        filteredExpenses = widget.expenses;
                      });
                    },
                    child: Chip(
                      label: const Text("Todos"),
                      backgroundColor: GetCorSelected(ExpenseType.all),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedExpenseType = ExpenseType.expense;
                        filteredExpenses = widget.expenses
                            .where((expense) =>
                                expense.tipo == ExpenseType.expense)
                            .toList();
                      });
                    },
                    child: Chip(
                      label: const Text("Despesas"),
                      backgroundColor: GetCorSelected(ExpenseType.expense),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedExpenseType = ExpenseType.receive;
                        filteredExpenses = widget.expenses
                            .where((expense) =>
                                expense.tipo == ExpenseType.receive)
                            .toList();
                      });
                    },
                    child: Chip(
                      label: const Text("Receitas"),
                      backgroundColor: GetCorSelected(ExpenseType.receive),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: filteredExpenses.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return Tile(expense: filteredExpenses[index]);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color GetCorSelected(ExpenseType selected) {
    if (selected == selectedExpenseType) {
      return Theme.of(context).colorScheme.primary;
    }
    return Colors.white;
  }

  Color GetBorderCorSelected(ExpenseType selected) {
    if (selected == selectedExpenseType) {
      return Theme.of(context).colorScheme.inversePrimary;
    }
    return Colors.white;
  }
}
