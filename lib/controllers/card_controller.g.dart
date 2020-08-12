// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CardController on _CardControllerBase, Store {
  final _$cardsAtom = Atom(name: '_CardControllerBase.cards');

  @override
  ObservableList<Cards> get cards {
    _$cardsAtom.reportRead();
    return super.cards;
  }

  @override
  set cards(ObservableList<Cards> value) {
    _$cardsAtom.reportWrite(value, super.cards, () {
      super.cards = value;
    });
  }

  final _$updateCardAsyncAction = AsyncAction('_CardControllerBase.updateCard');

  @override
  Future<void> updateCard(Cards card) {
    return _$updateCardAsyncAction.run(() => super.updateCard(card));
  }

  final _$saveCardAsyncAction = AsyncAction('_CardControllerBase.saveCard');

  @override
  Future<void> saveCard(Cards card) {
    return _$saveCardAsyncAction.run(() => super.saveCard(card));
  }

  final _$_CardControllerBaseActionController =
      ActionController(name: '_CardControllerBase');

  @override
  void takeAllCards() {
    final _$actionInfo = _$_CardControllerBaseActionController.startAction(
        name: '_CardControllerBase.takeAllCards');
    try {
      return super.takeAllCards();
    } finally {
      _$_CardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cards: ${cards}
    ''';
  }
}
