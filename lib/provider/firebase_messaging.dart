import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:trial1/models/push_notification.dart';

class FirebaseNotificationProvider with ChangeNotifier {
  FirebaseMessaging _messaging;
  PushNotification _notificationInfo;

  FirebaseNotificationProvider.initialize() {
    _messaging = FirebaseMessaging();
    registerNotification();
  }

  registerNotification() async{
    print('Arrived');
    var token = await _messaging.getToken();
    print('Firebase Token: $token');
    _messaging.configure(
        onMessage: (message) async {
          print('onMessage received: $message');
          _notificationInfo = PushNotification.fromJson(message);

          showSimpleNotification(
              Text(_notificationInfo.title),
              subtitle: Text(_notificationInfo.body),
              background: Colors.cyan[700],
              duration: Duration(seconds: 3)
          );

        }
    );
  }
}