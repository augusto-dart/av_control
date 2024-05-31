part of 'cards_bloc.dart';

sealed class CardsEvent extends Equatable {
  const CardsEvent();

  @override
  List<Object> get props => [];
}

class LoadCards extends CardsEvent {
  final List<Cards> cards;

  const LoadCards({required this.cards});

  @override
  List<Object> get props => [];
}

class AddCards extends CardsEvent {
  final List<Cards> cards;

  const AddCards({required this.cards});

  @override
  List<Object> get props => [];
}

class ClearCards extends CardsEvent {
  const ClearCards();

  @override
  List<Object> get props => [];
}

class AddCard extends CardsEvent {
  final Cards card;

  const AddCard({required this.card});

  @override
  List<Object> get props => [];
}

class RemoveCard extends CardsEvent {
  final Cards card;

  const RemoveCard({required this.card});

  @override
  List<Object> get props => [];
}

class UpdateCard extends CardsEvent {
  final Cards card;

  const UpdateCard({required this.card});

  @override
  List<Object> get props => [];
}
