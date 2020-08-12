import 'package:aula_30_flutter_exercicio/controllers/auth_controller.dart';
import 'package:aula_30_flutter_exercicio/entities/user.dart';
import 'package:aula_30_flutter_exercicio/pages/register_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/login_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthController _authController;
  ReactionDisposer _disposer;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  User _user = User();
  bool _isTextFieldVisible = true;
  bool _textEdited = false;
  bool passwordVisible = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authController = Provider.of<AuthController>(context);
    _disposer = autorun((_) {
      if (_authController.loginResult != null &&
          !_authController.loginResult.status) {
        _onFail(_authController.loginResult.message?.toString());
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text("Login"),
            centerTitle: true,
            actions: <Widget>[
              FlatButton(
                child: Text("Cadastro", style: TextStyle(fontSize: 15.0)),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushNamed(RegisterPage.routeName);
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (!EmailValidator.validate(value))
                        return 'E-mail Inválido';
                      return null;
                    },
                    onChanged: (value) {
                      _user.email = value;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  _isTextFieldVisible
                      ? inputFieldPassword(_passController, 'Senha',
                          'insira uma Senha', true, true, TextInputType.text)
                      : SizedBox(),
                  SizedBox(
                    height: 16.0,
                  ),
                  OutlineButton(
                      borderSide: BorderSide(color: Colors.black),
                      color: Theme.of(context).primaryColorDark,
                      child: Text(
                        "Enter",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      textColor: Colors.black,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _sigin();
                        }
                      })
                ],
              ),
            ),
          )),
      onWillPop: _dialog,
    );
  }

  Widget inputFieldPassword(
      TextEditingController contoller,
      String labelText,
      String hintText,
      bool showSuffixIcon,
      bool enableObscureText,
      TextInputType keyInputtype) {
    return TextFormField(
      onChanged: (value) {
        _user.password = value;
      },
      keyboardType: keyInputtype,
      controller: contoller,
      obscureText: enableObscureText == true ? passwordVisible : false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
        suffixIcon: showSuffixIcon == true
            ? IconButton(
                icon: Icon(
                  passwordVisible ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              )
            : null,
      ),
    );
  }

  Future<bool> _dialog() {
    if (_textEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Confira seu email"),
              content: Text("Se sair as alterações serão perdidas"),
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
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  void _sigin() async {
    _authController.signIn(
      email: _emailController.text,
      password: _passController.text,
    );
  }

  void _onFail(String result) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(result ?? "Falha ao logar"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 5),
      ),
    );
  }
}
