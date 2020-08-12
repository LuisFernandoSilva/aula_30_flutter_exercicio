import 'package:aula_30_flutter_exercicio/controllers/auth_controller.dart';
import 'package:aula_30_flutter_exercicio/controllers/card_controller.dart';
import 'package:aula_30_flutter_exercicio/entities/cards.dart';
import 'package:aula_30_flutter_exercicio/pages/home_page.dart';
import 'package:aula_30_flutter_exercicio/services/cards_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  static String routeName = 'edit_page';

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool _editCard = false;
  String _title = '';

  Cards _cards = Cards();
  CardService _serviceCards;
  AuthController _authController;
  CardController _cardController;
  TextEditingController _titleController;
  TextEditingController _contentController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authController = Provider.of<AuthController>(context);
    _cardController = Provider.of<CardController>(context);
    /*  _serviceCards = CardService(appState: _authController.appState); */

    final card = ModalRoute.of(context).settings.arguments as Cards;
    if (card != null) {
      _editCard = true;
      _cards.id = card?.id ?? '';
    }

    _titleController = TextEditingController(text: card?.title ?? '');
    _contentController = TextEditingController(text: card?.content ?? '');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_editCard) {
      _title = 'Editando';
    } else {
      _title = 'Novo';
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text('Card: $_title '),
          centerTitle: true,
          backgroundColor: Colors.blue[900]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: 'Titulo'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Titulo Vazio';
                          }
                          if (value.length <= 3) {
                            return 'Titulo muito curto';
                          }
                          if (value.length >= 30) {
                            return 'Titulo muito longo';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _cards.title = value;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _contentController,
                        maxLines: 10,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: 'Conteudo'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'conteudo Vazio';
                          }
                          if (value.length <= 3) {
                            return 'conteudo muito curto';
                          }
                          if (value.length >= 300) {
                            return 'conteudo muito longo';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _cards.content = value;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
                child: Container(
                  width: 350,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'Salvar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                onTap: () async {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  if (_editCard) {
                    await _cardController.updateCard(_cards);
                    /* _serviceCards.update(_cards); */
                    Navigator.of(context).pop();
                  } else {
                    await _cardController.saveCard(_cards);
                    /* _serviceCards.save(_cards); */
                    Navigator.of(context).pop();
                  }
                })
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
    Navigator.of(context).pop();
  }
}
