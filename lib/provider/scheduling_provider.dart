import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant/utils/background_service.dart';
import 'package:restaurant/utils/date_time_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledReminder(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling Reminder Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Reminder Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
