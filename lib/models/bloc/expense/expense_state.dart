part of 'expense_bloc.dart';

sealed class ExpenseState extends Equatable {
  const ExpenseState();
  @override
  List<Object> get props => [];
}

final class ExpenseInitial extends ExpenseState {}

final class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;
  const ExpenseLoaded({required this.expenses});

  @override
  List<Object> get props => [expenses];
}
