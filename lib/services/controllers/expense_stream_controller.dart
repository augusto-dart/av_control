import 'dart:async';

import 'package:av_control/models/expense.dart';

enum Event { increment, decrement }

class ExpenseController {
  List<Expense> despesas = [];
  final StreamController<List<Expense>> _expenseController =
      StreamController<List<Expense>>();
  StreamSink<List<Expense>> get expenseSink => _expenseController.sink;
  Stream<List<Expense>> get expenseStream => _expenseController.stream;

  final StreamController<Event> _eventController = StreamController<Event>();
  StreamSink<Event> get eventSink => _eventController.sink;
  Stream<Event> get eventStream => _eventController.stream;

  StreamSubscription? listener;
  ExpenseController() {
    listener = eventStream.listen((Event event) {
      switch (event) {
        case Event.increment:
          break;
        case Event.decrement:
          break;
        default:
      }
      // counterSink.add(Expense);
    });
  }

  dispose() {
    listener?.cancel();
    _expenseController.close();
    _eventController.close();
  }
}
