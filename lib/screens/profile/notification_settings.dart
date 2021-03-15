import 'package:cnc_flutter_app/widgets/account_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationSettings extends StatefulWidget {
  @override
  _NotificationSettings createState() => _NotificationSettings();
}

class _NotificationSettings extends State<NotificationSettings> {
  FlutterLocalNotificationsPlugin localNotificationsPlugin;
  DateTime dailyTime = DateTime.now();
  DateTime weeklyTime = DateTime.now();
  SharedPreferences sharedPreferences;
  final TextEditingController dailyTimeCtl = new TextEditingController();
  final TextEditingController weeklyTimeCtl = new TextEditingController();
  bool enableNotifications = false;
  bool enableDailyNotifications = false;
  bool enableWeeklyNotifications = false;
  String dropDownDay = 'Sunday';
  List<String> _days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];
  String hour = '';
  String minute = '';
  String tod = '';

  @override
  void initState() {
    super.initState();
    var androidInitialize = new AndroidInitializationSettings('ic_launcher');
    // var androidInitialize = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialize = new IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    localNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    localNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();

    if (dailyTime.hour == 12) {
      hour = dailyTime.hour.toString();
      tod = 'PM';
    } else if (dailyTime.hour > 12) {
      hour = (dailyTime.hour - 12).toString();
      tod = 'PM';
    } else {
      hour = dailyTime.hour.toString();
      if (dailyTime.hour == 0) {
        hour = '12';
      }
      tod = 'AM';
    }
    if (dailyTime.minute < 10) {
      minute = '0' + dailyTime.minute.toString();
    } else {
      minute = dailyTime.minute.toString();
    }
    initSharedPreferences();
  }

  void setDailyText() {
    if (dailyTime.hour == 12) {
      hour = dailyTime.hour.toString();
      tod = 'PM';
    } else if (dailyTime.hour > 12) {
      hour = (dailyTime.hour - 12).toString();
      tod = 'PM';
    } else {
      hour = dailyTime.hour.toString();
      if (dailyTime.hour == 0) {
        hour = '12';
      }
      tod = 'AM';
    }
    if (dailyTime.minute < 10) {
      minute = '0' + dailyTime.minute.toString();
    } else {
      minute = dailyTime.minute.toString();
    }

    dailyTimeCtl.text = hour + ':' + minute + ' ' + tod;
  }

  void setWeeklyText() {
    if (weeklyTime.hour == 12) {
      hour = weeklyTime.hour.toString();
      tod = 'PM';
    } else if (weeklyTime.hour > 12) {
      hour = (weeklyTime.hour - 12).toString();
      tod = 'PM';
    } else {
      hour = weeklyTime.hour.toString();
      if (weeklyTime.hour == 0) {
        hour = '12';
      }
      tod = 'AM';
    }
    if (weeklyTime.minute < 10) {
      minute = '0' + weeklyTime.minute.toString();
    } else {
      minute = weeklyTime.minute.toString();
    }

    weeklyTimeCtl.text = hour + ':' + minute + ' ' + tod;
  }

  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String storedDaily = sharedPreferences.get('dailyTime');
    String storedWeekly = sharedPreferences.get('weeklyTime');
    if (storedDaily != null) {
      enableNotifications = true;
      enableDailyNotifications = true;
      print(storedDaily);
      String storedHour = storedDaily.split(':')[0];
      String storedMinute = storedDaily.split(':')[1];
      dailyTime = new DateTime(dailyTime.year, dailyTime.month, dailyTime.day,
          int.parse(storedHour), int.parse(storedMinute));
    }

    if (storedWeekly != null) {
      enableNotifications = true;
      enableWeeklyNotifications = true;
      print(storedWeekly);
      String storedDay = sharedPreferences.get('weeklyDay');
      String storedHour = storedWeekly.split(':')[0];
      String storedMinute = storedWeekly.split(':')[1];
      print(storedDay);
      dropDownDay = storedDay;
      weeklyTime = new DateTime(
          weeklyTime.year,
          weeklyTime.month,
          _days.indexOf(storedDay) + 1,
          int.parse(storedHour),
          int.parse(storedMinute));
    }
    setDailyText();
    setWeeklyText();
    setState(() {});
  }

  _pickDailyTime() async {
    TimeOfDay t = await showTimePicker(
        context: context,
        initialTime:
            new TimeOfDay(hour: dailyTime.hour, minute: dailyTime.minute),
        initialEntryMode: TimePickerEntryMode.input,
        helpText: 'Time of Meal'
        // cancelText: 'testing'
        );
    if (t != null)
      setState(() {
        String hour = '';
        String minute = '';
        String tod = '';
        if (t.hour == 12) {
          hour = t.hour.toString();
          tod = 'PM';
        } else if (t.hour > 12) {
          hour = (t.hour - 12).toString();
          tod = 'PM';
        } else {
          hour = t.hour.toString();
          if (t.hour == 0) {
            hour = '12';
          }
          tod = 'AM';
        }
        if (t.minute < 10) {
          minute = '0' + t.minute.toString();
        } else {
          minute = t.minute.toString();
        }

        dailyTimeCtl.text = hour + ':' + minute + ' ' + tod;
        dailyTime = new DateTime(
            dailyTime.year, dailyTime.month, dailyTime.day, t.hour, t.minute);
      });
  }

  _pickWeeklyTime() async {
    TimeOfDay t = await showTimePicker(
        context: context,
        initialTime:
            new TimeOfDay(hour: weeklyTime.hour, minute: weeklyTime.minute),
        initialEntryMode: TimePickerEntryMode.input,
        helpText: 'Time of Meal');
    if (t != null)
      setState(() {
        String hour = '';
        String minute = '';
        String tod = '';
        if (t.hour == 12) {
          hour = t.hour.toString();
          tod = 'PM';
        } else if (t.hour > 12) {
          hour = (t.hour - 12).toString();
          tod = 'PM';
        } else {
          hour = t.hour.toString();
          if (t.hour == 0) {
            hour = '12';
          }
          tod = 'AM';
        }
        if (t.minute < 10) {
          minute = '0' + t.minute.toString();
        } else {
          minute = t.minute.toString();
        }

        weeklyTimeCtl.text = hour + ':' + minute + ' ' + tod;
        weeklyTime = new DateTime(weeklyTime.year, weeklyTime.month,
            weeklyTime.day, t.hour, t.minute);
      });
  }

  void scheduleDailyNotifications() async {
    var time = Time(dailyTime.hour, dailyTime.minute, 0);
    var body =
        'Scheduled for ' + time.hour.toString() + ':' + time.minute.toString();

    var androidDetails = new AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription",
        importance: Importance.high);
    var iOSDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await localNotificationsPlugin.showDailyAtTime(
        0, 'Daily Notification', body, time, generalNotificationDetails);
    sharedPreferences.remove('dailyTime');
    sharedPreferences.setString(
        'dailyTime', time.hour.toString() + ':' + time.minute.toString());
  }

  void scheduleWeeklyNotification() async {
    var time = Time(weeklyTime.hour, weeklyTime.minute, 0);
    var day = Day(_days.indexOf(dropDownDay) + 1);
    var body = 'Scheduled for ' +
        _days[day.value - 1] +
        ' ' +
        time.hour.toString() +
        ':' +
        time.minute.toString();

    var androidDetails = new AndroidNotificationDetails(
        "channelId", "channelName", "channelDescription",
        importance: Importance.high);
    var iOSDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await localNotificationsPlugin.showWeeklyAtDayAndTime(
        1, 'Weekly Notification', body, day, time, generalNotificationDetails);
    sharedPreferences.remove('weeklyTime');
    sharedPreferences.remove('weeklyDay');
    sharedPreferences.setString('weeklyDay', _days[day.value - 1]);
    sharedPreferences.setString(
        'weeklyTime', time.hour.toString() + ':' + time.minute.toString());
  }

  void clearDailyNotifications() async {
    sharedPreferences.remove('dailyTime');
    await localNotificationsPlugin.cancel(0);
  }

  void clearWeeklyNotifications() async {
    sharedPreferences.remove('weeklyDay');
    sharedPreferences.remove('weeklyTime');
    await localNotificationsPlugin.cancel(1);
  }

  void clearAllNotifications() async {
    sharedPreferences.remove('dailyTime');
    sharedPreferences.remove('weeklyDay');
    sharedPreferences.remove('weeklyTime');
    await localNotificationsPlugin.cancelAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Symptoms'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SwitchListTile(
            title: Text('Enable Notifications'),
            value: enableNotifications,
            onChanged: (bool value) {
              setState(() {
                enableNotifications = !enableNotifications;
                if (!enableNotifications) {
                  enableDailyNotifications = false;
                  enableWeeklyNotifications = false;
                }
              });
            },
          ),
          if (enableNotifications) ...[
            SwitchListTile(
              title: Text('Daily'),
              value: enableDailyNotifications,
              onChanged: (bool value) {
                setState(() {
                  enableDailyNotifications = !enableDailyNotifications;
                });
              },
            ),
            if (enableDailyNotifications) ...[
              GestureDetector(
                onTap: _pickDailyTime,
                child: Container(
                  width: 175,
                  child: TextFormField(
                    enabled: false,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    controller: dailyTimeCtl,
                    decoration: InputDecoration(
                      // border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 3, top: 5),
                      hintText: "Enter time",
                      isDense: true,
                    ),
                    onChanged: (text) {},
                  ),
                ),
              ),
            ],
            SwitchListTile(
              title: Text('Weekly'),
              value: enableWeeklyNotifications,
              onChanged: (bool value) {
                setState(() {
                  enableWeeklyNotifications = !enableWeeklyNotifications;
                });
              },
            ),
            if (enableWeeklyNotifications) ...[
              DropdownButtonFormField(
                isExpanded: true,
                decoration: InputDecoration(
                    labelText: 'Day',
                    border: OutlineInputBorder(),
                    hintText: "Day"),
                value: dropDownDay,
                validator: (value) => value == null ? 'Field Required' : null,
                onChanged: (String Value) {
                  setState(() {
                    dropDownDay = Value;
                  });
                },
                items: _days
                    .map((day) =>
                        DropdownMenuItem(value: day, child: Text("$day")))
                    .toList(),
              ),
              GestureDetector(
                onTap: _pickWeeklyTime,
                child: Container(
                  width: 175,
                  child: TextFormField(
                    enabled: false,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    controller: weeklyTimeCtl,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3, top: 5),
                      hintText: "Enter time",
                      isDense: true,
                    ),
                    onChanged: (text) {},
                  ),
                ),
              ),
            ],
          ],
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('Save'),
                    onPressed: () {
                      if (enableNotifications) {
                        if (enableDailyNotifications) {
                          scheduleDailyNotifications();
                        } else {
                          clearDailyNotifications();
                        }
                        if (enableWeeklyNotifications) {
                          scheduleWeeklyNotification();
                        } else {
                          clearWeeklyNotifications();
                        }
                      } else {
                        clearAllNotifications();
                      }

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.blue,
                          content: Text('Saved')));
                      // Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
