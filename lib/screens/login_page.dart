import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginregisternodejs/screens/home_page.dart';
import 'package:loginregisternodejs/screens/register_page.dart';
import 'package:loginregisternodejs/widgets/form_fields_widgets.dart';
import 'package:loginregisternodejs/rest/rest_api.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
// call shared preference object here
  // late SharedPreferences _sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: new LinearGradient(
                  colors: [Colors.grey, Colors.black87],
                  begin: const FractionalOffset(0.0, 1.0),
                  end: const FractionalOffset(0.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.repeated)
              // same code from main.dart we copy paste here
              ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 60,
              ),
              // Container(
              //   alignment: Alignment.center,
              //   child: Image.asset(
              //     "assets/images/logo.png",
              //     fit: BoxFit.cover,
              //     width: 150,
              //     height: 150,
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormFields(
                        key: Key('email_field'),
                        controller: _emailController,
                        data: Icons.email,
                        txtHint: 'Email',
                        obsecure: false,
                      ),
                      FormFields(
                        key: Key('password_field'),
                        controller: _passwordController,
                        data: Icons.lock,
                        txtHint: 'Password',
                        obsecure: true,
                      )
                    ],
                  )),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  TextButton(
                    onPressed: () async {
                      print("ddfg");
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        await doLogin(
                                _emailController.text, _passwordController.text)
                            .then((_) {
                          // Login successful
                        }).catchError((error) {
                          // Login failed
                          Fluttertoast.showToast(
                            msg: 'Login failed: $error',
                            textColor: Colors.red,
                          );
                        });
                      } else {
                        Fluttertoast.showToast(
                          msg: 'All fields are required',
                          textColor: Colors.red,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don`t have an account',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> doLogin(String email, String password) async {
    final res = await userLogin(email.trim(), password.trim());
    print(res.toString());
    if (res['success']) {
      print(res);
      // Set user data
      final route = MaterialPageRoute(builder: (_) => HomePage());
      Navigator.pushReplacement(context, route);
    } else {
      Fluttertoast.showToast(
          msg: 'Invalid email or password', textColor: Colors.red);
    }
  }
}
