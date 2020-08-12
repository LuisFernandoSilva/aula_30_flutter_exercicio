import 'package:aula_30_flutter_exercicio/entities/state.dart';
import 'package:aula_30_flutter_exercicio/services/login_service.dart';
import 'package:aula_30_flutter_exercicio/repositories/state_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final AppStateRepository _appStateRepository;
  final _loginService = LoginService();
  _AuthControllerBase({@required AppStateRepository appStateRepository})
      : _appStateRepository = appStateRepository;

  @observable
  bool isLoading = true;
  @observable
  AppState appState;
  @observable
  Result<String> loginResult;

  @computed
  bool get isLogedIn => appState != null;

  @action
  void getCurrent() {
    isLoading = true;
    _appStateRepository
        .getCurrent()
        .then((value) => appState = value)
        .whenComplete(() => isLoading = false);
  }

  @action
  void signIn({String email, String password}) {
    _loginService.signIn(email: email, password: password).then((value) {
      loginResult = value;
      getCurrent();
    });
  }

  @action
  Future<void> signOut() async {
    await _loginService.signOut();
    appState = null;
  }
}
