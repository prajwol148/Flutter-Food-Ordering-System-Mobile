import 'package:flutter/material.dart';
import 'package:trial1/models/user.dart';
import 'package:trial1/provider/user.dart';
import 'package:trial1/view_controller/user_controller.dart';

import '../locator.dart';

class ManageProfileInformationWidget extends StatefulWidget {
  final UserModel currentUser;

  ManageProfileInformationWidget({this.currentUser});

  @override
  _ManageProfileInformationWidgetState createState() =>
      _ManageProfileInformationWidgetState();
}

class _ManageProfileInformationWidgetState
    extends State<ManageProfileInformationWidget> {
  var _displayNameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _newPasswordController = TextEditingController();
  var _repeatPasswordController = TextEditingController();

  @override
  void initState() {
    _displayNameController.text = UserModel.NAME;
    super.initState();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _passwordController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "Username"),
              controller: _displayNameController,
            ),
            SizedBox(height: 20.0),
            Flexible(
              child: Column(
                children: <Widget>[
                  Text(
                    "Manage Password",
                    style: Theme.of(context).textTheme.display1,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Password"),
                    controller: _passwordController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "New Password"),
                    controller: _newPasswordController,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Repeat Password"),
                    controller: _repeatPasswordController,
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                if (widget.currentUser.displayName !=
                    _displayNameController.text) {
                  var displayName = _displayNameController.text;
                  locator.get<UserController>().updateDisplayName(displayName);
                }

                Navigator.pop(context);
              },
              child: Text("Save Profile"),
            )
          ],
        ),
      ),
    );
  }
}
