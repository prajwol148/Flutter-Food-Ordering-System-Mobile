import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trial1/provider/user.dart';
import 'package:trial1/widgets/loading.dart';
import 'home.dart';

class PWreset extends StatefulWidget {
  PWreset({Key key}) : super(key: key);

  @override
  _PWresetState createState() => _PWresetState();
}

class _PWresetState extends State<PWreset> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _newpassword = TextEditingController();
  bool hidePass = true;
  Firestore _firestore = Firestore.instance;
  FirebaseAuth _auth;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
        key: _key,
        body: user.status == Status.Authenticating
            ? Loading()
            : SingleChildScrollView(
                child: Container(
                    child: Column(
                children: <Widget>[
                  Container(
                    height: 450,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/reset.png'),
                    )),

                    //yesma form key thyo
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20, 8.0, 25.0, 21.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.withOpacity(0.2),
                                elevation: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: ListTile(
                                    title: TextFormField(
                                      controller: _email,
                                      decoration: InputDecoration(
                                          hintText: "Email",
                                          icon: Icon(Icons.alternate_email),
                                          border: InputBorder.none),
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
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  user.resetPassword(_email.text);
                                  _key.currentState.showSnackBar(SnackBar(
                                      backgroundColor: Colors.blueAccent,
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                        "Your password resent link has been sent to your Gmail account.Please check",
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      )));
                                },
                                child: Text(
                                  "Reset",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
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
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ))));
  }
}
