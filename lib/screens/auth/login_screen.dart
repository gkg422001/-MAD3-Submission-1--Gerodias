import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:midterm_activity/controllers/auth_controller.dart';
import 'package:midterm_activity/dialogs/waiting_dialog.dart';

class LoginScreen extends StatefulWidget {
  static const String route = "/auth";
  static const String name = "Login Screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> formKey;
  late TextEditingController username, password;
  late FocusNode usernameFn, passwordFn;

  bool obfuscate = true;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    username = TextEditingController();
    password = TextEditingController();
    usernameFn = FocusNode();
    passwordFn = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
    usernameFn.dispose();
    passwordFn.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 75, 12, 183),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 75, 12, 183),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Login Page",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              // color: Colors.grey[400],
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      // color: Colors.green,
                      child: TextFormField(
                        decoration: decoration.copyWith(
                            labelText: "Username",
                            prefixIcon: const Icon(Icons.person)),
                        focusNode: usernameFn,
                        controller: username,
                        onEditingComplete: () {
                          passwordFn.requestFocus();
                        },
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'Please fill out the username'),
                          MaxLengthValidator(32,
                              errorText:
                                  "Username cannot exceed 32 characters"),
                          PatternValidator(r'^[a-zA-Z0-9 ]+$',
                              errorText:
                                  'Username cannot contain special characters'),
                        ]).call,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      // color: Colors.red,
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obfuscate,
                        decoration: decoration.copyWith(
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.password),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obfuscate = !obfuscate;
                                  });
                                },
                                icon: Icon(obfuscate
                                    ? CupertinoIcons.eye_slash
                                    : Icons.remove_red_eye_rounded))),
                        focusNode: passwordFn,
                        controller: password,
                        onEditingComplete: () {
                          passwordFn.unfocus();
                        },
                        validator: MultiValidator([
                          RequiredValidator(errorText: "Password is required"),
                          MinLengthValidator(12,
                              errorText:
                                  "Password must be at least 12 characters long"),
                          MaxLengthValidator(128,
                              errorText:
                                  "Password cannot exceed 72 characters"),
                          PatternValidator(
                              r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+?\-=[\]{};':,.<>]).*$",
                              errorText:
                                  'Password must contain at least one symbol, one uppercase letter, one lowercase letter, and one number.')
                        ]).call,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Color.fromARGB(255, 216, 216, 216),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Color.fromARGB(255, 216, 216, 216),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 108, 38, 228)),
                        onPressed: () {
                          onSubmit();
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 221, 221, 221),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      WaitingDialog.show(context,
          future: AuthController.I
              .login(username.text.trim(), password.text.trim()));
    }
  }

  OutlineInputBorder _baseBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.all(Radius.circular(4)),
  );

  InputDecoration get decoration => InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        filled: true,
        fillColor: const Color.fromARGB(255, 222, 221, 221),
        errorMaxLines: 3,
        disabledBorder: _baseBorder,
        enabledBorder: _baseBorder.copyWith(
            borderSide: const BorderSide(color: Colors.black87, width: 1)),
        focusedBorder: _baseBorder.copyWith(
            borderSide: const BorderSide(color: Colors.blueAccent, width: 1)),
        errorBorder: _baseBorder.copyWith(
            borderSide:
                const BorderSide(color: Colors.deepOrangeAccent, width: 1)),
      );
}
