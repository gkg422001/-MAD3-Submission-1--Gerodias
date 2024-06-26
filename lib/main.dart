import 'package:flutter/material.dart';
import 'package:midterm_activity/screens/auth/login_screen.dart';
import 'package:midterm_activity/controllers/auth_controller.dart';
import 'package:midterm_activity/screens/routing/router.dart';

void main() async {
  AuthController.initialize();
  GlobalRouter.initialize();
  await AuthController.I.loadSession();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Midterm Activity',
      routerConfig: GlobalRouter.I.router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
