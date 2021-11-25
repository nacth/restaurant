import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/provider/preferences_provider.dart';
import 'package:restaurant/provider/scheduling_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SchedulingProvider(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<PreferencesProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  SizedBox(height: 30),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                      SizedBox(width: 12.0),
                      Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Material(
                    child: ListTile(
                      title: Text('Dark Theme'),
                      trailing: Switch.adaptive(
                        value: provider.isDarkTheme,
                        onChanged: (value) {
                          provider.enableDarkTheme(value);
                        },
                      ),
                    ),
                  ),
                  Material(
                    child: ListTile(
                      title: Text('Scheduling Reminder'),
                      trailing: Consumer<SchedulingProvider>(
                        builder: (context, scheduled, _) {
                          return Switch.adaptive(
                            value: provider.isDailyReminderActive,
                            onChanged: (value) async {
                              scheduled.scheduledReminder(value);
                              provider.enableDailyReminder(value);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
