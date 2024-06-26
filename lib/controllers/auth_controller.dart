import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:midterm_activity/enum/enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController with ChangeNotifier {
  static void initialize() {
    GetIt.instance.registerSingleton<AuthController>(AuthController());
  }

  static AuthController get instance => GetIt.instance<AuthController>();

  static AuthController get I => GetIt.instance<AuthController>();

  AuthState state = AuthState.unauthenticated;
  SimulatedAPI api = SimulatedAPI();

  login(String userName, String password) async {
    bool isLoggedIn = await api.login(userName, password);
    if (isLoggedIn) {
      state = AuthState.authenticated;
      //should store session
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('session', state.toString());

      notifyListeners();
    }
  }

  //to be provided
  logout() async {
    //should clear session
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('session');
    state = AuthState.unauthenticated;
    notifyListeners();
  }

  ///must be called in main before runApp
  loadSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? session = prefs.getString('session');

    if (session != null) {
      state = AuthState.authenticated;
    } else {
      state = AuthState.unauthenticated;
    }
    notifyListeners();
    //check secure storage method
    //see if there is a stored session if yes set the appropriate state and notify the listener.
  }
}

class SimulatedAPI {
  Map<String, String> users = {"testUser": "12345678ABCabc!"};

  Future<bool> login(String userName, String password) async {
    await Future.delayed(const Duration(seconds: 4));
    if (users[userName] == null) {
      throw Exception("User does not exist");
    }
    if (users[userName] != password) {
      throw Exception("Password does not match!");
    }
    return users[userName] == password;
  }
}
