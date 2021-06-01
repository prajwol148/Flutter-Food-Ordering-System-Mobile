import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trial1/helpers/common.dart';
import 'package:trial1/helpers/style.dart';
import 'package:trial1/provider/user.dart';
import 'package:trial1/screens/OTP.dart';
import 'package:trial1/screens/OTP2.dart';
import 'package:trial1/screens/login.dart';
import 'package:trial1/widgets/loading.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;

    return Scaffold(
      key: _key,
      body: user.status == Status.Authenticating
          ? Loading()
          : Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[350],
                          blurRadius:
                              20.0, // has the effect of softening the shadow
                        )
                      ],
                    ),
                    child: Form(
                        key: _formKey,
                        child: ListView(
                          children: <Widget>[
                            SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                width: 230,
                                height: 100,
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "assets/images/logo.png",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFF2F3F5),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: ListTile(
                                    title: TextFormField(
                                      controller: _name,
                                      showCursor: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        filled: true,
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Color(0xFF666666),
                                          size: defaultIconSize,
                                        ),
                                        fillColor: Color(0xFFF2F3F5),
                                        hintStyle: TextStyle(
                                          color: Color(0xFF666666),
                                          fontFamily: defaultFontFamily,
                                          fontSize: defaultFontSize,
                                        ),
                                        hintText: "Full Name",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "The name field cannot be empty";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFF2F3F5),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: ListTile(
                                    title: TextFormField(
                                      controller: _phoneNumber,
                                      showCursor: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        filled: true,
                                        prefixIcon: Icon(
                                          Icons.phone,
                                          color: Color(0xFF666666),
                                          size: defaultIconSize,
                                        ),
                                        fillColor: Color(0xFFF2F3F5),
                                        hintStyle: TextStyle(
                                          color: Color(0xFF666666),
                                          fontFamily: defaultFontFamily,
                                          fontSize: defaultFontSize,
                                        ),
                                        hintText: "Phone Number",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "The name field cannot be empty";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFF2F3F5),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: ListTile(
                                    title: TextFormField(
                                      controller: _email,
                                      showCursor: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        filled: true,
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Color(0xFF666666),
                                          size: defaultIconSize,
                                        ),
                                        fillColor: Color(0xFFF2F3F5),
                                        hintStyle: TextStyle(
                                          color: Color(0xFF666666),
                                          fontFamily: defaultFontFamily,
                                          fontSize: defaultFontSize,
                                        ),
                                        hintText: "Email Address",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          Pattern pattern =
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                          RegExp regex = new RegExp(pattern);
                                          if (!regex.hasMatch(value))
                                            return 'Please make sure your email address is valid';
                                          else
                                            return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFF2F3F5),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: ListTile(
                                    title: TextFormField(
                                      obscureText: hidePass,
                                      controller: _password,
                                      showCursor: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        filled: true,
                                        prefixIcon: Icon(
                                          Icons.security,
                                          color: Color(0xFF666666),
                                          size: defaultIconSize,
                                        ),
                                        fillColor: Color(0xFFF2F3F5),
                                        hintStyle: TextStyle(
                                          color: Color(0xFF666666),
                                          fontFamily: defaultFontFamily,
                                          fontSize: defaultFontSize,
                                        ),
                                        hintText: "Password",
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "The password field cannot be empty";
                                        } else if (value.length < 6) {
                                          return "the password has to be at least 6 characters long";
                                        }
                                        return null;
                                      },
                                    ),
                                    trailing: IconButton(
                                        icon: Icon(Icons.remove_red_eye),
                                        onPressed: () {
                                          setState(() {
                                            hidePass = !hidePass;
                                          });
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Color(0xFFff3b5c),
                                  elevation: 0.0,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        if (!await user.signUp(
                                            _name.text,
                                            _email.text,
                                            _password.text,
                                            _phoneNumber.text)) {
                                          _key.currentState.showSnackBar(
                                              SnackBar(
                                                  content:
                                                      Text("Sign up failed")));
                                          return;
                                        }
                                        changeScreenReplacement(
                                            context, HomePage());
                                      }
                                    },
                                    minWidth: MediaQuery.of(context).size.width,
                                    child: Text(
                                      "SIGN UP",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                          fontFamily: "WorkSansBold"),
                                    ),
                                  )),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {
                                      changeScreen(context, LoginScreen());
                                    },
                                    child: Text(
                                      "Register with Phone Number",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0xFF666666),
                                          fontSize: 14),
                                    ))),
                            SizedBox(height: 10),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "I already have an account",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0xFF666666),
                                          fontSize: 14),
                                    ))),
                          ],
                        )),
                  ),
                ),
              ],
            ),
    );
  }
}
