import 'dart:math';
import 'dart:ui';
import 'dart:isolate';
import 'package:restaurant/core/network/client.dart';
import 'package:restaurant/core/network/service/restaurant_service.dart';

import '../main.dart';
import 'notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    final _client =
        ApiClient.instance(baseUrl: 'https://restaurant-api.dicoding.dev');
    var result = await RestaurantService(_client).getRestaurants();
    var length = result.restaurants?.length;
    var index = Random().nextInt(length ?? 0);
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result.restaurants?[index]);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
