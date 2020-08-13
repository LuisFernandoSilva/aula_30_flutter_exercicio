import 'dart:convert';

import 'package:aula_30_flutter_exercicio/entities/user.dart';
import 'package:aula_30_flutter_exercicio/utils/api_helper.dart';
import 'package:aula_30_flutter_exercicio/entities/state.dart';
import 'package:dio/dio.dart';

class RegisterService {
  final Dio _dio;
  RegisterService({AppState appState})
      : _dio = ApiHelper.getDioInstance(appState: appState);

//salvar
  Future<User> save(User user) async {
    var dataUser = jsonEncode(user.toMap());
    var response = await _dio.post('/users', data: dataUser);
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
}
