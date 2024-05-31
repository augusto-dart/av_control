import 'package:av_control/models/cards.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  CardsBloc() : super(CardsInitial()) {
    on<LoadCards>((event, emit) async {
      emit(const CardsLoaded(cards: []));
    });
    on<ClearCards>((event, emit) {
      emit(CardsInitial());
    });
    on<AddCards>((event, emit) {
      emit(
        CardsLoaded(
          cards: event.cards,
        ),
      );
    });
    on<AddCard>((event, emit) {
      if (state is CardsLoaded) {
        final state = this.state as CardsLoaded;
        emit(
          CardsLoaded(
            cards: List.from(state.cards)..add(event.card),
          ),
        );
      }
    });
    on<RemoveCard>((event, emit) {
      if (state is CardsLoaded) {
        final state = this.state as CardsLoaded;
        emit(
          CardsLoaded(
            cards: List.from(state.cards)..remove(event.card),
          ),
        );
      }
    });
    on<UpdateCard>((event, emit) {
      if (state is CardsLoaded) {
        final state = this.state as CardsLoaded;

        state.cards.remove(
            state.cards.where((card) => card.id == event.card.id).first);
        List<Cards> cards = List.from(state.cards);
        emit(
          CardsLoaded(
            cards: cards..add(event.card),
          ),
        );
      }
    });
  }
}
