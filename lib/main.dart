import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:trial1/provider/category.dart';
import 'package:trial1/provider/faq.dart';
import 'package:trial1/provider/firebase_messaging.dart';

import 'provider/app.dart';
import 'provider/product.dart';
import 'provider/user.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: UserProvider.initialize()),
      ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
      ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ChangeNotifierProvider.value(value: FaqProvider.initialize()),
      ChangeNotifierProvider.value(value: FirebaseNotificationProvider.initialize()),
      ChangeNotifierProvider.value(value: AppProvider()),
    ],
    child: OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.white),
        home: ScreensController(),
      ),
    ),
  ));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return HomePage();
      default:
        return Login();
    }
  }
}
