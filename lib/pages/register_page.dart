import 'package:aula_30_flutter_exercicio/controllers/register_controller.dart';
import 'package:aula_30_flutter_exercicio/entities/user.dart';
import 'package:aula_30_flutter_exercicio/repositories/user_repository.dart';
import 'package:aula_30_flutter_exercicio/services/register_service.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class RegisterPage extends StatefulWidget {
  static String routeName = '/register_page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  User _users = User();
  RegisterService _registerService = RegisterService();
  RegisterController _registerController;
  TextEditingController _namecontroller;
  TextEditingController _emailcontroller;
  TextEditingController _passwordcontroller;
  final _formKey = GlobalKey<FormState>();
  final repository = UserRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _namecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Cadastro'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _namecontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Campo Vazio';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _users.name = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Informe seu Nome',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (!EmailValidator.validate(value))
                      return 'E-mail Inválido';
                    return null;
                  },
                  onSaved: (value) {
                    _users.email = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Informe seu Email',
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
                    _users.password = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Informe uma nova senha',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 30),
                OutlineButton(
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();
                    _registerService.save(_users);
                    Navigator.of(context).pop();
                  },
                  child: Text('Cadastrar'),
                ),
              ],
            ),
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
