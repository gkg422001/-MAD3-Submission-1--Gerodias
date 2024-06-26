import 'package:flutter/material.dart';
import 'package:midterm_activity/controllers/auth_controller.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home';
  static const String path = "/home";
  static const String name = "Home Screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ElevatedButton(
            onPressed: () async {
              await AuthController.I.logout();
            },
            child: Text(
              "Logout",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "HOME",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // ElevatedButton(
            //     onPressed: () async {
            //       await AuthController.I.logout();
            //     },
            //     child: Text(
            //       "Logout",
            //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //     ))
          ],
        ),
      ),
    );
  }
}
