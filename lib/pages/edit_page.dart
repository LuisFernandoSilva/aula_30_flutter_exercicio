import 'package:aula_30_flutter_exercicio/entities/cards.dart';
import 'package:aula_30_flutter_exercicio/services/api_cards.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  static String routeName = 'edit_page';

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool _editCard = false;
  String _title = '';

  Cards _cards = Cards();
  ApiCards _serviceCards = ApiCards();
  TextEditingController _titleController;
  TextEditingController _contentController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //quando vier um card para editar seta para true isso ainda nao e certeza depende da home
/*     final card = ModalRoute.of(context).settings.arguments as Cards;
    if (card == null) {
      _editCard = true;
    } */
    //depois dentro dos controllers setando a variavel texto tem que vir a informaçao do card
    _titleController = TextEditingController();
    _contentController = TextEditingController();
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
      ),
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
                        onChanged: (value) {
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
                        onChanged: (value) {
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
                onTap: () {
                  _serviceCards.save(_cards);
                })
          ],
        ),
      ),
    );
  }
}
