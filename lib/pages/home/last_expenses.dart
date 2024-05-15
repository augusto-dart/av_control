import 'package:av_control/Components/tile/tile.dart';
import 'package:av_control/models/expense.dart';
import 'package:flutter/material.dart';

class LastExpenses extends StatelessWidget {
  const LastExpenses({
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;

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
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: expenses.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return Tile(expense: expenses[index]);
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
}
