import 'package:aula_30_flutter_exercicio/entities/cards.dart';
import 'package:aula_30_flutter_exercicio/services/cards_service.dart';
import 'package:mobx/mobx.dart';
part 'card_controller.g.dart';

class CardController = _CardControllerBase with _$CardController;

abstract class _CardControllerBase with Store {
  CardService _cardService;
  @observable
  var cards = ObservableList<Cards>();

  _CardControllerBase({CardService cardService}) : _cardService = cardService;

  @action
  void takeAllCards() {
    _cardService.takeAll().then((value) {
      cards = value.asObservable();
    });
  }

  @action
  Future<void> updateCard(Cards card) async {
    await _cardService.update(card);
    takeAllCards();
  }

  @action
  Future<void> saveCard(Cards card) async {
    var cardSave = await _cardService.save(card);
    cards.add(cardSave);
  }

  @action
  Future<void> deleCard(int index) async {
    await _cardService.delete(index);
    takeAllCards();
  }
}
