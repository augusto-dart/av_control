import 'package:av_control/models/expense.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(ExpenseInitial()) {
    on<LoadExpense>((event, emit) async {
      emit(const ExpenseLoaded(expenses: []));
    });
    on<AddExpense>((event, emit) {
      if (state is ExpenseLoaded) {
        final state = this.state as ExpenseLoaded;
        emit(
          ExpenseLoaded(
            expenses: List.from(state.expenses)..add(event.expense),
          ),
        );
      }
    });
    on<RemoveExpense>((event, emit) {
      if (state is ExpenseLoaded) {
        final state = this.state as ExpenseLoaded;
        emit(
          ExpenseLoaded(
            expenses: List.from(state.expenses)..remove(event.expense),
          ),
        );
      }
    });
  }
}
