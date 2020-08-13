import 'package:aula_30_flutter_exercicio/entities/user.dart';
import 'package:aula_30_flutter_exercicio/services/register_service.dart';
import 'package:mobx/mobx.dart';

part 'register_controller.g.dart';

class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
  RegisterService _registerService;
  @observable
  var users = ObservableList<User>();

  @action
  Future<void> saveUser(User user) async {
    var userSave = await _registerService.save(user);
    users.add(userSave);
  }
}
