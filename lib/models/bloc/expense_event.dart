part of 'expense_bloc.dart';

sealed class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

class LoadExpense extends ExpenseEvent {}

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
