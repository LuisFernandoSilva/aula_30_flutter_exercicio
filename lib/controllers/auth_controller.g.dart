// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthController on _AuthControllerBase, Store {
  Computed<bool> _$isLogedInComputed;

  @override
  bool get isLogedIn =>
      (_$isLogedInComputed ??= Computed<bool>(() => super.isLogedIn,
              name: '_AuthControllerBase.isLogedIn'))
          .value;

  final _$isLoadingAtom = Atom(name: '_AuthControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$appStateAtom = Atom(name: '_AuthControllerBase.appState');

  @override
  AppState get appState {
    _$appStateAtom.reportRead();
    return super.appState;
  }

  @override
  set appState(AppState value) {
    _$appStateAtom.reportWrite(value, super.appState, () {
      super.appState = value;
    });
  }

  final _$loginResultAtom = Atom(name: '_AuthControllerBase.loginResult');

  @override
  Result<String> get loginResult {
    _$loginResultAtom.reportRead();
    return super.loginResult;
  }

  @override
  set loginResult(Result<String> value) {
    _$loginResultAtom.reportWrite(value, super.loginResult, () {
      super.loginResult = value;
    });
  }

  final _$signOutAsyncAction = AsyncAction('_AuthControllerBase.signOut');

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  final _$_AuthControllerBaseActionController =
      ActionController(name: '_AuthControllerBase');

  @override
  void getCurrent() {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.getCurrent');
    try {
      return super.getCurrent();
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void signIn({String email, String password}) {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.signIn');
    try {
      return super.signIn(email: email, password: password);
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
appState: ${appState},
loginResult: ${loginResult},
isLogedIn: ${isLogedIn}
    ''';
  }
}
