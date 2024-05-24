part of 'expense_bloc.dart';

sealed class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

class LoadExpense extends ExpenseEvent {
  final List<Expense> expenses;

  const LoadExpense({required this.expenses});

  @override
  List<Object> get props => [];
}

class AddExpenses extends ExpenseEvent {
  final List<Expense> expenses;

  const AddExpenses({required this.expenses});

  @override
  List<Object> get props => [];
}

class ClearExpenses extends ExpenseEvent {
  const ClearExpenses();

  @override
  List<Object> get props => [];
}

class AddExpense extends ExpenseEvent {
  final Expense expense;

  const AddExpense({required this.expense});

  @override
  List<Object> get props => [];
}

class RemoveExpense extends ExpenseEvent {
  final Expense expense;

  const RemoveExpense({required this.expense});

  @override
  List<Object> get props => [];
}
