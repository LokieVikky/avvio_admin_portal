import 'package:flutter/material.dart';
import 'package:synced_admin_portal/routes.dart';
import 'package:synced_admin_portal/screens/login_screen.dart';

import 'configure_web.dart';
import 'screens/home_screen.dart';

void main() {
  configureApp();
  runApp(MaterialApp(
    initialRoute: Routes.login,
    routes: {
      Routes.login: (context) => LoginScreen(),
      Routes.home: (context) => HomeScreen(),
    },
    debugShowCheckedModeBanner: false,
    //builder: (context, child) => LoginScreen(),
  ));
}
