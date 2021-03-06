import 'package:aula_30_flutter_exercicio/controllers/auth_controller.dart';
import 'package:aula_30_flutter_exercicio/entities/user.dart';
import 'package:aula_30_flutter_exercicio/pages/register_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart';

class LogoFront extends StatefulWidget {
  @override
  _LogoFrontState createState() => _LogoFrontState();
}

class _LogoFrontState extends State<LogoFront> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logosemfundo.png',
      scale: 2,
    );
  }
}

class LogoBack extends StatefulWidget {
  @override
  _LogoBackState createState() => _LogoBackState();
}

class _LogoBackState extends State<LogoBack> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logosemfundo.png',
      color: Colors.white,
      scale: 2,
    );
  }
}

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
      onWillPop: _dialog,
      child: Scaffold(
          backgroundColor: Color.fromRGBO(0, 20, 50, 1),
          key: _scaffoldKey,
          resizeToAvoidBottomInset: true,
          body: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 48, right: 16, left: 16),
              child: SingleChildScrollView(
                child: Container(
                  color: Color.fromRGBO(28, 43, 74, 1),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        FlipCard(
                          front: LogoFront(),
                          back: LogoBack(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32, bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Novo por aqui?',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              FlatButton(
                                child: Text(
                                  'Crie sua conta aqui',
                                  style: TextStyle(
                                      color: Color.fromRGBO(225, 110, 0, 1),
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(RegisterPage.routeName);
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromRGBO(80, 92, 118, 1),
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              suffixIcon: Icon(Icons.email),
                              hintText: "E-mail",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16)),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (!EmailValidator.validate(value))
                                return 'E-mail Inválido';
                              return null;
                            },
                            onChanged: (value) {
                              _user.email = value;
                              _textEdited = true;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        _isTextFieldVisible
                            ? inputFieldPassword(_passController, 'Senha',
                                'Senha', true, true, TextInputType.text)
                            : SizedBox(
                                height: 16.0,
                              ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, top: 12),
                          child: Row(
                            children: <Widget>[
                              Transform.scale(
                                scale: 2,
                                child: Observer(
                                  builder: (context) {
                                    return Checkbox(
                                        value: _authController.value,
                                        onChanged: (value) {
                                          _authController.checked(value);
                                        });
                                  },
                                ),
                              ),
                              Text('Mantenha-me conectado',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        ButtonTheme(
                          minWidth: 320,
                          height: 40,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 12, bottom: 64.0),
                            child: RaisedButton(
                                color: Color.fromRGBO(225, 110, 0, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: Text(
                                  "Entrar",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                                textColor: Colors.black,
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _sigin();
                                  }
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Widget inputFieldPassword(
      TextEditingController contoller,
      String labelText,
      String hintText,
      bool showSuffixIcon,
      bool enableObscureText,
      TextInputType keyInputtype) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: TextFormField(
        onChanged: (value) {
          _user.password = value;
          _textEdited = true;
        },
        keyboardType: keyInputtype,
        controller: contoller,
        obscureText: enableObscureText == true ? passwordVisible : false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(80, 92, 118, 1),
          hintStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          labelText: labelText,
          hintText: hintText,
          suffixIcon: showSuffixIcon == true
              ? IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }

  Future<bool> _dialog() {
    if (_textEdited) {
      showDialog(
          context: context,
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
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
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
