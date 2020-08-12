import 'package:aula_30_flutter_exercicio/controllers/Register_controller.dart';
import 'package:aula_30_flutter_exercicio/entities/user.dart';
import 'package:aula_30_flutter_exercicio/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  static String routeName = '/register_page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
    bool _editUser = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  User _users = User();
  RegisterController _registerController;
  TextEditingController _namecontroller;
  TextEditingController _emailcontroller;
  TextEditingController _passwordcontroller;
  final User _user = User.empty();
  final _formKey = GlobalKey<FormState>();
  final repository = UserRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _namecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _registerController = Provider.of<RegisterController>(context);

    final user = ModalRoute.of(context).settings.arguments as User;
    if (user != null) {
      _editUser = true;
      _users.id = user?.id ?? '';
    }

    _namecontroller = TextEditingController(text: user?.name ?? '');
    _passwordcontroller = TextEditingController(text: user?.password ?? '');
    _emailcontroller = TextEditingController(text: user?.email ?? '');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: Text('Cadastro')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _emailcontroller,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (!EmailValidator.validate(value)) return 'E-mail Inválido';
                  return null;
                },
                onSaved: (value) {
                  _user.email = value;
                },
                decoration: InputDecoration(
                  hintText: 'Informe seu nome',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _namecontroller,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Campo Vazio';
                  }
                  return null;
                },
                onSaved: (value) {
                  _user.name = value;
                },
                decoration: InputDecoration(
                  hintText: 'Informe seu E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _passwordcontroller,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Campo Vazio';
                  }
                  return null;
                },
                onSaved: (value) {
                  _user.password = value;
                },
                decoration: InputDecoration(
                  hintText: 'Informe uma nova senha',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),
              OutlineButton(
                onPressed: () async {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  saveUser();
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(String mensagem) {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: Duration(
            seconds: 2,
          ),
          content: Text(
            mensagem,
            style: TextStyle(fontSize: 18),
          ),
          backgroundColor: Colors.red,
        ),
      );
  }
}
