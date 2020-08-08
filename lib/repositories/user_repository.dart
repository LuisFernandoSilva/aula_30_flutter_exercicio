import 'package:aula_30_flutter_exercicio/db/db.dart';
import 'package:aula_30_flutter_exercicio/entities/user.dart';

class UserRepository {
  final _table = 'user';
  final _dbHelper = Db();

  Future<User> getCurrent() async {
    final db = await _dbHelper.openDB();
    final result = await db.query(_table);
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  Future<void> save(User user) async {
    final db = await _dbHelper.openDB();
    await db.transaction((txn) async {
      await txn.delete(_table);
      await txn.insert(_table, user.toMap());
    });
  }

  Future<void> clear() async {
    final db = await _dbHelper.openDB();
    await db.delete(_table);
  }
}
