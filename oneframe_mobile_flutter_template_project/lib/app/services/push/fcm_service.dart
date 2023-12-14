import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'fcm_channel_constants.dart';
import 'fcm_options.dart';

class FCMService {
  FCMService._();

  static Future<void> initFcm() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await _setupFcmNotificationSettings();
      FirebaseMessaging.onMessage.listen(_fcmForegroundHandler);
      FirebaseMessaging.onBackgroundMessage(_fcmBackgroundHandler);
    } catch (error) {}
  }

  static Future<void> _setupFcmNotificationSettings() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );
  }

  static Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  @pragma('vm:entry-point')
  static Future<void> _fcmBackgroundHandler(RemoteMessage message) async {
    _showFlutterNotification(message);
  }

  static Future<void> _fcmForegroundHandler(RemoteMessage message) async {
    _showFlutterNotification(message);
  }

  static void _showFlutterNotification(RemoteMessage message) {
    var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
            android: AndroidNotificationDetails(
              FCMChannelConstants.androidChannelId,
              FCMChannelConstants.androidChannelName,
              channelDescription: FCMChannelConstants.androidChannelDescription,
              icon: FCMChannelConstants.androidIcon,
            ),
            iOS: DarwinNotificationDetails(
                threadIdentifier: FCMChannelConstants.iosThreadIdentifier)),
      );
    }
  }
}
