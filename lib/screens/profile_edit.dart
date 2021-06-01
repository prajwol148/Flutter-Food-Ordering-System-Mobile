import 'dart:io';
import 'package:firebase_image/firebase_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:trial1/helpers/common.dart';
import 'package:trial1/models/user.dart';
import 'package:trial1/provider/user.dart';
import 'package:trial1/screens/home.dart';
import 'package:trial1/screens/login.dart';
import 'package:trial1/view_controller/user_controller.dart';
import 'package:trial1/widgets/avatar.dart';
import 'package:path/path.dart';
import 'package:trial1/widgets/manage_profile_information_widget.dart';
import '../locator.dart';

class ProfileEdit extends StatefulWidget {
  final UserModel userModel;
  ProfileEdit({this.userModel});
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  TextEditingController _userNameController;
  TextEditingController _phoneNumberController;
  TextEditingController _dobController;

  @override
  void initState() {
    _userNameController = TextEditingController(text: widget.userModel.name);
    _phoneNumberController = TextEditingController(text: widget.userModel.phoneNumber);
    _dobController = TextEditingController(text: widget.userModel.dob);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50.0, left: 10, right: 10),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Avatar(
                    avatarUrl: userProvider.userModel?.avatarUrl,
                    onTap: () async {
                      File image = await ImagePicker.pickImage(
                          source: ImageSource.gallery);
                      //  print(image.path);
                      //
                      // await locator
                      //     .get<UserController>()
                      //     .uploadProfilePicture(image);
                      //
                      // setState(() {});
                    },
                  ),
                  // child:

                  // Avatar(
                  //   avatarUrl: userProvider.userModel?.avatarUrl,
                  //   onTap: () async {
                  //     File image = await ImagePicker.pickImage(
                  //         source: ImageSource.gallery);

                  //     await locator
                  //         .get<UserController>()
                  //         .uploadProfilePicture(image);

                  //     setState(() {});
                  //   },
                  // ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            userProvider.userModel?.name ??
                                "username lading...",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "@" + userProvider.userModel?.name ??
                                "username lading...",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              userProvider.signOut();
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (BuildContext context) {
                              //       return Login();
                              //     },
                              //   ),
                              // );
                            },
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).accentColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  flex: 3,
                ),
              ],
            ),
            Divider(),
            Container(height: 15.0),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                "Account Information".toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Full Name",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(hintText: "Enter your Full Name"),
              ),
            ),
            ListTile(
              title: Text(
                "Phone",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: TextFormField(
                controller: _phoneNumberController,
                decoration:
                    InputDecoration(hintText: "Enter your Phone Number"),
              ),
            ),
            ListTile(
              title: Text(
                "Date Of Birth",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: TextFormField(
                controller: _dobController,
                decoration:
                    InputDecoration(hintText: "Enter your Date of Birth"),
              ),
            ),
            SizedBox(height: 5.0),
            Divider(),
            // Container(height: 15.0),
            // Padding(
            //   padding: EdgeInsets.all(5.0),
            //   child: Text(
            //     "Change Password".toUpperCase(),
            //     style: TextStyle(
            //       fontSize: 16.0,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            // ListTile(
            //   title: TextFormField(
            //     decoration: InputDecoration(hintText: "Old Password"),
            //   ),
            // ),
            // ListTile(
            //   title: TextFormField(
            //     decoration: InputDecoration(hintText: "New Password"),
            //   ),
            // ),
            // ListTile(
            //   title: TextFormField(
            //     decoration: InputDecoration(hintText: "Re-enter New Password"),
            //   ),
            // ),
            RaisedButton(
              onPressed: () {
                // TODO: Save somehow
                Map<String, dynamic> data = {
                  'id': userProvider.userModel.id,
                  'name': _userNameController.text,
                  'phoneNumber': _phoneNumberController.text,
                  'dob': _dobController.text
                };
                userProvider.updateUserData(data);
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


// class ProfileEdit extends StatefulWidget {
//   @override
//   _ProfileEditState createState() => _ProfileEditState();
// }

// class _ProfileEditState extends State<ProfileEdit> {
//   File _image;
//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);

//     String linkImage = 'gs://medhavicafeteria.appspot.com/' +
//         userProvider.userModel.name +
//         '.jpg';
//     Future getImage() async {
//       var image = await ImagePicker.pickImage(source: ImageSource.gallery);

//       setState(() {
//         _image = image;
//         print('Image Path $_image');
//       });
//     }

//     Future uploadPic(BuildContext context) async {
//       String fileName = userProvider.userModel?.name ?? "username lading...";
//       StorageReference firebaseStorageRef =
//           FirebaseStorage.instance.ref().child(fileName);
//       StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
//       StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//       setState(() {
//         print("Profile Picture uploaded");
//         Scaffold.of(context)
//             .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
//       });
//     }

//     return Scaffold(
//       body: Builder(
//         builder: (BuildContext context) => Container(
//           child: ListView(
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Align(
//                     alignment: Alignment.center,
//                     child: CircleAvatar(
//                         radius: 44,
//                         backgroundColor: Color(0xff476cfb),
//                         child: CircleAvatar(
//                           backgroundImage: FirebaseImage(linkImage),
//                         )),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 60.0),
//                     child: Avatar(
//                       avatarUrl: userProvider.userModel?.avatarUrl,
//                       onTap: () async {
//                         File image = await ImagePicker.pickImage(
//                             source: ImageSource.gallery);
//                         print(image.path);

//                         await locator
//                             .get<UserController>()
//                             .uploadProfilePicture(image);

//                         setState(() {});
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Text(
//                               userProvider.userModel?.name ??
//                                   "username lading...",
//                               style: TextStyle(
//                                 fontSize: 20.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 5.0),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Text(
//                               "@" + userProvider.userModel?.name ??
//                                   "username lading...",
//                               style: TextStyle(
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 20.0),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             InkWell(
//                               onTap: () {
//                                 userProvider.signOut();
//                                 // Navigator.of(context).push(
//                                 //   MaterialPageRoute(
//                                 //     builder: (BuildContext context) {
//                                 //       return Login();
//                                 //     },
//                                 //   ),
//                                 // );
//                               },
//                               child: Text(
//                                 "Logout",
//                                 style: TextStyle(
//                                   fontSize: 13.0,
//                                   fontWeight: FontWeight.w400,
//                                   color: Theme.of(context).accentColor,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     flex: 3,
//                   ),
//                 ],
//               ),
//               Divider(),
//               Container(height: 15.0),
//               Padding(
//                 padding: EdgeInsets.all(5.0),
//                 child: Text(
//                   "Account Information".toUpperCase(),
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               ListTile(
//                 title: Text(
//                   "Full Name",
//                   style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 subtitle: TextFormField(
//                   decoration: InputDecoration(hintText: "Enter your Full Name"),
//                 ),
//               ),
//               ListTile(
//                 title: Text(
//                   "Phone",
//                   style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 subtitle: TextFormField(
//                   decoration:
//                       InputDecoration(hintText: "Enter your Phone Number"),
//                 ),
//               ),
//               ListTile(
//                 title: Text(
//                   "Date Of Birth",
//                   style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 subtitle: TextFormField(
//                   decoration:
//                       InputDecoration(hintText: "Enter your Date of Birth"),
//                 ),
//               ),
//               SizedBox(height: 5.0),
//               Divider(),
//               Container(height: 15.0),
//               Padding(
//                 padding: EdgeInsets.all(5.0),
//                 child: Text(
//                   "Change Password".toUpperCase(),
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               ListTile(
//                 title: TextFormField(
//                   decoration: InputDecoration(hintText: "Old Password"),
//                 ),
//               ),
//               ListTile(
//                 title: TextFormField(
//                   decoration: InputDecoration(hintText: "New Password"),
//                 ),
//               ),
//               ListTile(
//                 title: TextFormField(
//                   decoration:
//                       InputDecoration(hintText: "Re-enter New Password"),
//                 ),
//               ),
//               RaisedButton(
//                 onPressed: () {
//                   uploadPic(context);
//                 },
//                 child: Text("Save Profile"),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

