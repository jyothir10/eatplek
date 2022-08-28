import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi{



  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {

    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/ic_launcher');

    print("222");
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        icon: "ic_launcher",
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future showNotifications({

    int id = 0,
    String? title,
    String? body,
  })async =>
      _notifications.show(
          id,
          title,
          body,
          await _notificationDetails(),
      );
}