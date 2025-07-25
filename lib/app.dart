import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seguro/core/themes/theme.dart';
import 'package:seguro/presentation/pages/auth/login_page.dart';
import 'package:seguro/presentation/pages/auth/register_page.dart';
import 'package:seguro/presentation/pages/dashboard/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
