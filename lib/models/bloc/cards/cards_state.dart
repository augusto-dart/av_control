part of 'cards_bloc.dart';

sealed class CardsState extends Equatable {
  const CardsState();

  @override
  List<Object> get props => [];
}

final class CardsInitial extends CardsState {}

final class CardsLoaded extends CardsState {
  final List<Cards> cards;
  const CardsLoaded({required this.cards});

  @override
  List<Object> get props => [cards];
}
