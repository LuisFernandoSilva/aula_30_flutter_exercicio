// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegisterController on _RegisterControllerBase, Store {
  final _$usersAtom = Atom(name: '_RegisterControllerBase.users');

  @override
  ObservableList<User> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(ObservableList<User> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  final _$saveUserAsyncAction = AsyncAction('_RegisterControllerBase.saveUser');

  @override
  Future<void> saveUser(User user) {
    return _$saveUserAsyncAction.run(() => super.saveUser(user));
  }

  @override
  String toString() {
    return '''
users: ${users}
    ''';
  }
}
