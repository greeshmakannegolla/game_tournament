import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';
import 'constants/Stringconstants.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _nameValid = false;
  bool _passwordValid = false;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormFieldState> _nameInputKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> _passwordInputKey = GlobalKey<FormFieldState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //         begin: Alignment.topCenter,
      //         end: Alignment(0.8, 0.0),
      //         colors: [const Color(0xff301934), const Color(0xff9400d3)])),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        c_logo,
                        color: Colors.black,
                        filterQuality: FilterQuality.high,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      TextFormField(
                        key: _nameInputKey,
                        maxLength: 10,
                        controller: _nameController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          //hintText: "Username",
                          labelText: "Username",

                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (name) {
                          setState(() {});
                          _nameValid = false;
                          if (_nameController.text.length == 0)
                            return "Please enter a username";
                          else if (_nameController.text.length < 3)
                            return "Your username must contain atleast 3 characters.";
                          else if (_nameController.text.length > 10)
                            return "Your username is too long. Username is expected to be below 10 characters.";
                          else {
                            _nameValid = true;
                            return null;
                          }
                        },
                        onFieldSubmitted: (_) {
                          _nameInputKey.currentState.validate();
                        },
                        onChanged: (_) {
                          _nameInputKey.currentState.validate();
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        key: _passwordInputKey,
                        obscureText: true,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          //hintText: "Password",
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        validator: (password) {
                          setState(() {});
                          _passwordValid = false;
                          if (_passwordController.text.length == 0)
                            return "Please enter a password";
                          else if (_passwordController.text.length < 3)
                            return "Your password must contain atleast 3 characters.";
                          else if (_passwordController.text.length > 11)
                            return "Your password is too long. Password is expected to be below 11 characters.";
                          else {
                            _passwordValid = true;
                            return null;
                          }
                        },
                        onFieldSubmitted: (_) {
                          _passwordInputKey.currentState.validate();
                        },
                        onChanged: (_) {
                          _passwordInputKey.currentState.validate();
                        },
                      ),
                      SizedBox(height: 30),
                      RaisedButton(
                        onPressed: () async {
                          if ((_nameController.text == "9898989898" ||
                                  _nameController.text == "9876543210") &&
                              _passwordController.text == "password123") {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool('isLoggedIn', true);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                                (_) => false);
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Incorrect credentials"),
                                content:
                                    Text("Please check your username/password"),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop(); // dismisses only the dialog and returns nothing
                                    },
                                    child: Text('OK',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: const Text('Submit',
                            style: TextStyle(fontSize: 20)),
                        color: (_nameValid == true && _passwordValid == true)
                            ? Colors.black
                            : Colors.grey,
                        textColor: Colors.white,
                        elevation: 5,
                      )
                    ]),
              ),
            )),
          )),
    );
  }
}
