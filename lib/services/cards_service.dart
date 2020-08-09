import 'dart:convert';

import 'package:aula_30_flutter_exercicio/api_helper.dart';
import 'package:aula_30_flutter_exercicio/entities/cards.dart';
import 'package:aula_30_flutter_exercicio/entities/state.dart';
import 'package:dio/dio.dart';

class CardService {
  final Dio _dio;
  CardService({AppState appState})
      : _dio = ApiHelper.getDioInstance(appState: appState);

  //pega todas as cartas
  Future<List<Cards>> takeAll({int id}) async {
    var response = await _dio.get('/cards',
        queryParameters: id != null ? {'id': id} : null);
    var receive = List<Cards>();
    if (response.statusCode >= 200 && response.statusCode < 300) {
      List list = response.data;
      list.forEach((element) {
        receive.add(Cards.fromMap(element));
        /* print(element); */
      });
    } else {
      print('Algo deu errado.');
    }
    return receive;
  }

  //escolhe uma carta pelo id
  Future<Cards> takeId(int id) async {
    var response = await _dio.get('/cards/$id');
    Cards receive;
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        receive = Cards.fromMap(response.data);
        if (receive.id == null) {
          print(
              'Algo deu errado tenta novamente'); //retorno se nao existe o id passado
        } else {
          print(receive);
        }
      }
    } catch (e) {
      print('erro: $e');
    }
    if (response.statusCode >= 200 && response.statusCode < 300) {
    } else {
      print('Algo deu errado.');
    }
    return receive;
  }

  //salva uma carta
  Future<Cards> save(Cards card) async {
    var dataCard = jsonEncode(card.toMap());
    var response = await _dio.post('/cards', data: dataCard);
    Cards receive;
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        receive = Cards.fromMap(response.data);
        print('Salvo com sucesso'); //printa se o item foi salvo com sucesso
      }
    } catch (e) {
      print('Algo deu errado. $e'); //se der errado printa o erro
    }
    return receive;
  }

  //faz update
  Future<Cards> update(Cards card) async {
    var dataCard = jsonEncode(card.toMap());
    var response = await _dio.put('/cards/${card.id}', data: dataCard);
    Cards receive;
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        receive = Cards.fromMap(response.data);
        print(
            'Alterado com sucesso'); //printa quando o item foi alterado com sucesso
      }
    } catch (e) {
      print('Algo deu errado. $e');
    }
    return receive;
  }

  //faz delete
  Future<void> delete(int id) async {
    var response = await _dio.delete('/cards/$id');
    if (response.statusCode >= 300 && response.statusCode < 200) {
      print('Algo deu errado tente novamente'); //se der algo errado
    } else {
      print('Deletado com sucesso'); //quando e deletado com sucesso
    }
  }
}
