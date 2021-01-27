import 'package:HarmonyHub/screens/botton_navigation_screen.dart';
import 'package:HarmonyHub/utilities/globals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HarmonyHubNotificationHandler {
  static bool backgroundNotificationReceived = false;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NotificationDetails initializationSettings;
  var initializationSettingsAndroid;
  var initializationSettingsIOS;
  dynamic _context;

  void initNotifications(dynamic context) async {
    _context = context;
    await Firebase.initializeApp();
    final _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.subscribeToTopic(Global.calenderEventPushNotifications);
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    initializationSettingsIOS = new IOSInitializationSettings(requestSoundPermission: false);
    var initializationSettings = new InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    //print('User granted permission: ${settings.authorizationStatus}');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Map<String, dynamic> notification = new Map<String, dynamic>();
      notification['title'] = "New Event is Added!";
      notification['body'] = "A new event was added to the HarmonyHUB calendar!!! Open the app to check it out!";
      _showNotification(
        1234,
        "New Event is Added!",
        "A new event was added to the HarmonyHUB calendar!!! Open the app to check it out!",
        "",
      );
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Got a message open from notification!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigationScreen(),
        ),
      );
    });
  }

  Future<void> _showNotification(
    int notificationId,
    String notificationTitle,
    String notificationContent,
    String payload, {
    String channelId = '',
    String channelTitle = '',
    String channelDescription = '',
  }) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      channelId,
      channelTitle,
      channelDescription,
      playSound: false,
      importance: Importance.high,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      notificationId,
      notificationTitle,
      notificationContent,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  static void _saveDeviceToken(String oneAddress, String addressType) async {
    /*String fcmToken = await _fcm.getToken();
    if (fcmToken != null) {
      FirebaseFirestore.instance.collection('device_tokens_debug').doc('$fcmToken:-:$addressType').set({
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'platform': Platform.operatingSystem,
        'oneAddress': oneAddress,
        'token': fcmToken,
        'addressType': addressType,
      });
    }*/
  }
}
