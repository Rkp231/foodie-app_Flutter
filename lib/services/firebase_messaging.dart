import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodie/constants/api.dart';
import 'package:foodie/constants/app_routes.dart';
import 'package:foodie/constants/app_strings.dart';
import 'package:foodie/data/database/app_database_singleton.dart';
import 'package:foodie/data/models/notification_model.dart';
import 'package:foodie/services/http.service.dart';

class AppNotification extends HttpService {
  static BuildContext buildContext;
  static NotificationModel notificationModel;

  static setUpFirebaseMessaging() async {
    final appDatabase = AppDatabaseSingleton.database;
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
    //handling the notification process
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('ic_notification');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: selectNotification,
    );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    //Request for notification permission
    _firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      provisional: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // print("onMessage: $message");

      //Saving the notification
      notificationModel = NotificationModel();
      notificationModel.title = message.notification.title;
      notificationModel.body = message.notification.body;
      notificationModel.timeStamp = DateTime.now().millisecondsSinceEpoch;
      appDatabase.notificationDao.insertItem(
        notificationModel,
      );

      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        AppStrings.appName,
        AppStrings.appName,
        '${AppStrings.appName} Notification Channel',
        importance: Importance.Max,
        priority: Priority.High,
      );
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics,
        iOSPlatformChannelSpecifics,
      );

      //
      await flutterLocalNotificationsPlugin.show(
        0,
        notificationModel.title,
        notificationModel.body,
        platformChannelSpecifics,
      );
    });

    // _firebaseMessaging.onIosSettingsRegistered.listen(
    //   (IosNotificationSettings settings) {
    //     print("Settings registered: $settings");
    //   },
    // );
  }

  static Future selectNotification(String payload) async {
    await Navigator.pushNamed(
      buildContext,
      AppRoutes.notificationsRoute,
    );
  }

  //
  //sending notification
  Future<void> sendNotificationToTopic({
    String title = "",
    String body = "",
    String topic,
  }) async {
    //
    final payload = {
      'notification': {
        'title': title,
        'body': body,
      },
      'priority': 'high',
      'to': "/topics/$topic",
    };

    //
    await dio.post(
      Api.fcmServer,
      data: payload,
      options: Options(
        headers: {
          // 'content-type': 'application/json',
          'Authorization': 'key=${AppStrings.firebaseServerToken}',
        },
      ),
    );

    //
    // print("Response ==> ${result.data}");
  }
}
