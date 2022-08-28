import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('ic_notif');

    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        icon: "ic_notif",
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initscheduled = false}) async {
    final android = AndroidInitializationSettings('ic_notif');
    final ios = IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: ios);
    await _notifications.initialize(
      settings,
      onSelectNotification: (payload) async {
        onNotifications.add(payload);
      },
    );
    tz.initializeDatabase([]);
  }

  static Future showNotifications({
    int id = 0,
    String? title,
    String? body,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
      );

  static Future showtimedNotifications({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime time,
  }) async {
    print(tz.TZDateTime.from(time, tz.local));
    print("Called");

    return _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(time, tz.local),
      await _notificationDetails(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
