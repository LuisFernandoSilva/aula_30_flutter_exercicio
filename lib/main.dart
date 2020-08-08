import 'package:aula_30_flutter_exercicio/controllers/auth_controller.dart';
import 'package:aula_30_flutter_exercicio/pages/home_page.dart';
import 'package:aula_30_flutter_exercicio/pages/login_page.dart';
import 'package:aula_30_flutter_exercicio/pages/register_page.dart';
import 'package:aula_30_flutter_exercicio/repositories/state_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthController>(
          create: (_) =>
              AuthController(appStateRepository: AppStateRepository())
                ..getCurrent(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AuthController>(context);
    return MaterialApp(initialRoute: HomePage.routeName, routes: {
      HomePage.routeName: (context) {
        return Observer(
          builder: (context) {
            if (controller.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!controller.isLogedIn) {
              return LoginPage();
            }
            return HomePage();
          },
        );
      },
      RegisterPage.routeName: (context) => RegisterPage(),
    });
  }
}
