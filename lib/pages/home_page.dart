import 'package:aula_30_flutter_exercicio/controllers/auth_controller.dart';
import 'package:aula_30_flutter_exercicio/controllers/card_controller.dart';

import 'package:aula_30_flutter_exercicio/entities/user.dart';
import 'package:aula_30_flutter_exercicio/pages/edit_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/';
  final _key = GlobalKey<ScaffoldState>();
  AuthController _alertDialog;

  @override
  Widget build(BuildContext context) {
    AuthController _authController = Provider.of<AuthController>(context);
    CardController _cardController = Provider.of<CardController>(context)
      ..takeAllCards();
    _alertDialog = _authController;
    return WillPopScope(
      child: Scaffold(
        key: _key,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Observer(
                builder: (context) {
                  var _user = User(
                    email: _authController.appState.email,
                    name: _authController.appState.name,
                  );
                  return UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Colors.blue[900]),
                    accountEmail: Text(_user.email),
                    accountName: Text(_user.name),
                    currentAccountPicture: CircleAvatar(
                      child: Icon(
                        Icons.person,
                        color: Colors.orange[800],
                        size: 50,
                      ),
                    ),
                  );
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sair'),
                onTap: () {
                  if (_alertDialog.value) {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  } else {
                    _alertDialog.signOut();
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Log out'),
                onTap: () {
                  _alertDialog.signOut();
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Home'),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditPage.routeName);
                })
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Observer(builder: (_) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: _cardController?.cards?.length ?? 1,
              itemBuilder: (context, index) {
                return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.startToEnd,
                    confirmDismiss: (direction) async => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: Text(
                                  'Exluir ${_cardController?.cards?.name}'),
                              content: Text(
                                  'Isso irá excluir permanentemente esse item.'),
                              actions: [
                                FloatingActionButton(
                                  backgroundColor: Colors.red,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(Icons.cancel),
                                ),
                                SizedBox(width: 20),
                                FloatingActionButton(
                                    backgroundColor: Colors.red,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _key.currentState.showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Item excluido com Sucesso.',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                      _cardController.deleCard(
                                          _cardController.cards[index].id);
                                    },
                                    child: Icon(Icons.delete_forever)),
                              ]);
                        }),
                    child: _cardContainer(
                        _cardController.cards[index].title,
                        _cardController.cards[index].content,
                        _cardController.cards[index].id, () {
                      Navigator.of(context).pushNamed(EditPage.routeName,
                          arguments: _cardController.cards[index]);
                    }));
              },
            );
          }),
        ),
      ),
      onWillPop: () => _dialog(context),
    );
  }

  Future<bool> _dialog(BuildContext context) {
    showDialog(
        builder: (context) {
          return AlertDialog(
            title: Text("Deseja realmente sair?"),
            content: Text("As alterações feitas serão perdidas!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Sim"),
                onPressed: () {
                  if (_alertDialog.value) {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  } else {
                    _alertDialog.signOut();
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  }
                },
              ),
            ],
          );
        },
        context: context);
    return Future.value(false);
  }

  Widget _cardContainer(
      String title, String content, int index, Function onpressed) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border(
          top: BorderSide(width: 2.0, color: Colors.orange[800]),
          left: BorderSide(width: 2.0, color: Colors.orange[800]),
          right: BorderSide(width: 2.0, color: Colors.orange[800]),
          bottom: BorderSide(width: 2.0, color: Colors.orange[800]),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.orange[800],
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                    child: Text(
                  index.toString() ?? '',
                  style: TextStyle(fontSize: 20),
                )),
              ),
              SizedBox(width: 20),
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  strutStyle: StrutStyle(fontSize: 12.0),
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    text: title ?? '',
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 20),
          Text(
            content ?? '',
            maxLines: 7,
          ),
          Divider(height: 20),
          FlatButton(
            onPressed: onpressed,
            child: Text('Editar'),
          ),
        ],
      ),
    );
  }
}
