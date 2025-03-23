import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotiService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // Khởi tạo thông báo
  Future<void> initNotification() async {
    if (_isInitialized) return; // Ngăn chặn khởi tạo lại
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    // Cấu hình cho Android
    const AndroidInitializationSettings initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Cấu hình cho iOS
    const DarwinInitializationSettings initSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    // Kết hợp cài đặt
    const InitializationSettings initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    // Khởi tạo plugin thông báo
    await notificationsPlugin.initialize(initSettings);
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id', // ID của kênh thông báo
        'Daily Notifications', // Tên kênh
        channelDescription: 'Daily Notification Channel', // Mô tả kênh
        importance: Importance.max, // Độ quan trọng cao nhất
        priority: Priority.high, // Độ ưu tiên cao
      ),
      iOS: DarwinNotificationDetails(), // Hỗ trợ iOS
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(), // Gọi hàm notificationDetails() đã định nghĩa trước đó
    );
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required int year,
    required int month,
    required int day,
    required int hour,
    required int minute,
  }) async {
    // Tạo thời gian đặt lịch trong ngày với giờ và phút cụ thể
    var scheduledDate = tz.TZDateTime(tz.local, year, month, day, hour, minute);

    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      NotificationDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  cancelNoti({required int id}) async {
    await notificationsPlugin.cancel(id);
  }
}
