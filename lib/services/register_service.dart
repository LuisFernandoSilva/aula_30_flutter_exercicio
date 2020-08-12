import 'dart:convert';

import 'package:aula_30_flutter_exercicio/entities/user.dart';
import 'package:aula_30_flutter_exercicio/utils/api_helper.dart';
import 'package:aula_30_flutter_exercicio/entities/state.dart';
import 'package:dio/dio.dart';

class RegisterService {
  final Dio _dio;
  RegisterService({AppState appState})
      : _dio = ApiHelper.getDioInstance(appState: appState);

//pega tudo
  Future<List<User>> takeAll({int id}) async {
    var response = await _dio.get('/user',
        queryParameters: id != null ? {'id': id} : null);
    var receive = List<User>();
    if (response.statusCode >= 200 && response.statusCode < 300) {
      List list = response.data;
      list.forEach((element) {
        receive.add(User.fromMap(element));
        /* print(element); */
      });
    } else {
      print('Algo deu errado.');
    }
    return receive;
  }

//pega por id
  Future<User> takeId(int id) async {
    var response = await _dio.get('/user/$id');
    User receive;
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        receive = User.fromMap(response.data);
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

//salvar
  Future<User> save(User user) async {
    var dataUser = jsonEncode(user.toMap());
    var response = await _dio.post('/user', data: dataUser);
    User receive;
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        receive = User.fromMap(response.data);
        print('Salvo com sucesso'); //printa se o item foi salvo com sucesso
      }
    } catch (e) {
      print('Algo deu errado. $e'); //se der errado printa o erro
    }
    return receive;
  }

  //update
  Future<User> update(User user) async {
    var dataUser = jsonEncode(user.toMap());
    print('User editado${user.toMap()}');
    var response = await _dio.put('/user/${user.id}', data: dataUser);
    User receive;
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        receive = User.fromMap(response.data);

        print(
            'Alterado com sucesso'); //printa quando o item foi alterado com sucesso
      }
    } catch (e) {
      print('Algo deu errado. $e');
    }
    return receive;
  }

  //deleta
  Future<void> delete(int id) async {
    var response = await _dio.delete('/user/$id');
    if (response.statusCode >= 300 && response.statusCode < 200) {
      print('Algo deu errado tente novamente'); //se der algo errado
    } else {
      print('Deletado com sucesso'); //quando e deletado com sucesso
    }
  }
}
