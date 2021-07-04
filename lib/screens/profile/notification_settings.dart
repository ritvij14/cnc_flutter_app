import 'package:flutter/material.dart';
import 'package:cnc_flutter_app/settings/preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

class NotificationSettings extends StatefulWidget {
  @override
  _NotificationSettings createState() => _NotificationSettings();
}

class _NotificationSettings extends State<NotificationSettings> {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  DateTime dailyTime = DateTime.now();
  DateTime weeklyTime = DateTime.now();
  late SharedPreferences sharedPreferences;
  final TextEditingController dailyTimeCtl = new TextEditingController();
  final TextEditingController weeklyTimeCtl = new TextEditingController();
  bool enableNotifications = false;
  bool enableDailyNotifications = false;
  bool enableWeeklyNotifications = false;
  bool enableNotificationsStart = false;
  bool enableDailyNotificationsStart = false;
  bool enableWeeklyNotificationsStart = false;
  String dropDownDay = 'Sunday';
  late String appTheme;
  bool wasChanged = false;
  List<String> _days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  @override
  void initState() {
    super.initState();
    // var androidInitialize = new AndroidInitializationSettings('ic_launcher');
    var androidInitialize =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialize = new IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    localNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    localNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
    initSharedPreferences();
  }

  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? storedDaily = sharedPreferences.getString('dailyTime');
    String? storedWeekly = sharedPreferences.getString('weeklyTime');
    appTheme = Preferences.getTheme().toString();
    if (storedDaily != null) {
      enableNotifications = true;
      enableDailyNotifications = true;
      enableNotificationsStart = true;
      enableDailyNotificationsStart = true;
      String storedHour = storedDaily.split(':')[0];
      String storedMinute = storedDaily.split(':')[1];
      dailyTime = new DateTime(dailyTime.year, dailyTime.month, dailyTime.day,
          int.parse(storedHour), int.parse(storedMinute));
    }

    if (storedWeekly != null) {
      enableNotifications = true;
      enableWeeklyNotifications = true;
      enableNotificationsStart = true;
      enableWeeklyNotificationsStart = true;
      String storedDay = sharedPreferences.getString('weeklyDay')!;
      String storedHour = storedWeekly.split(':')[0];
      String storedMinute = storedWeekly.split(':')[1];
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

  void setDailyText() {
    String hour;
    String minute;
    String tod;
    hour = dailyTime.hour == 0
        ? '12'
        : dailyTime.hour <= 12
            ? dailyTime.hour.toString()
            : (dailyTime.hour - 12).toString();
    tod = dailyTime.hour < 12 ? 'AM' : 'PM';
    minute = dailyTime.minute.toString().padLeft(2, '0');

    dailyTimeCtl.text = hour + ':' + minute + ' ' + tod;
  }

  void setWeeklyText() {
    String hour;
    String minute;
    String tod;
    hour = weeklyTime.hour == 0
        ? '12'
        : weeklyTime.hour <= 12
            ? weeklyTime.hour.toString()
            : (weeklyTime.hour - 12).toString();
    tod = weeklyTime.hour < 12 ? 'AM' : 'PM';
    minute = weeklyTime.minute.toString().padLeft(2, '0');

    weeklyTimeCtl.text = hour + ':' + minute + ' ' + tod;
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "CANCEL",
        style: TextStyle(color: Colors.grey),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget confirmButton = FlatButton(
      child: Text("CONFIRM", style: TextStyle(color: Colors.white)),
      color: Theme.of(context).buttonColor,
      onPressed: () {
        Navigator.of(context).pop();
        closePage();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cancel update"),
      content: Text(
          "Are you sure you want to cancel this edit? Your changes will not be saved."),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void closePage() {
    Navigator.of(context).pop();
  }

  _pickDailyTime() async {
    TimeOfDay? t = await showTimePicker(
        context: context,
        initialTime:
            new TimeOfDay(hour: dailyTime.hour, minute: dailyTime.minute),
        builder: (context, child) {
          return appTheme == "AppTheme.Default"
              ? Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(
                      // change the border color
                      primary: Theme.of(context).primaryColor,
                      // change the text color
                      onSurface: Theme.of(context).shadowColor,
                    ),
                    // button colors
                    buttonTheme: ButtonThemeData(
                      colorScheme: ColorScheme.light(
                        primary: Theme.of(context).buttonColor,
                      ),
                    ),
                  ),
                  child: child!,
                )
              : Theme(
                  data: ThemeData.dark().copyWith(
                    colorScheme: ColorScheme.dark(
                      // change the border color
                      primary: Theme.of(context).highlightColor,
                      // change the text color
                      onSurface: Theme.of(context).highlightColor,
                    ),
                    // button colors
                    buttonTheme: ButtonThemeData(
                      colorScheme: ColorScheme.light(
                        primary: Theme.of(context).buttonColor,
                      ),
                    ),
                  ),
                  child: child!,
                );
        },
        initialEntryMode: TimePickerEntryMode.dial,
        helpText: 'Notification Time');
    if (t != null) {
      setState(() {
        var hour = t.hour == 0
            ? 12
            : t.hour <= 12
                ? t.hour
                : t.hour - 12;
        var tod = t.hour < 12 ? 'AM' : 'PM';
        dailyTimeCtl.text = hour.toString() +
            ':' +
            t.minute.toString().padLeft(2, '0') +
            ' ' +
            tod;
        dailyTime = new DateTime(
            dailyTime.year, dailyTime.month, dailyTime.day, t.hour, t.minute);
      });
    }
  }

  _pickWeeklyTime() async {
    TimeOfDay? t = await showTimePicker(
        context: context,
        initialTime:
            new TimeOfDay(hour: weeklyTime.hour, minute: weeklyTime.minute),
        builder: (context, child) {
          return appTheme == "AppTheme.Default"
              ? Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(
                      // change the border color
                      primary: Theme.of(context).primaryColor,
                      // change the text color
                      onSurface: Theme.of(context).shadowColor,
                    ),
                    // button colors
                    buttonTheme: ButtonThemeData(
                      colorScheme: ColorScheme.light(
                        primary: Theme.of(context).buttonColor,
                      ),
                    ),
                  ),
                  child: child!,
                )
              : Theme(
                  data: ThemeData.dark().copyWith(
                    colorScheme: ColorScheme.dark(
                      // change the border color
                      primary: Theme.of(context).highlightColor,
                      // change the text color
                      onSurface: Theme.of(context).highlightColor,
                    ),
                    // button colors
                    buttonTheme: ButtonThemeData(
                      colorScheme: ColorScheme.light(
                        primary: Theme.of(context).buttonColor,
                      ),
                    ),
                  ),
                  child: child!,
                );
        },
        initialEntryMode: TimePickerEntryMode.dial,
        helpText: 'Notification Time');
    if (t != null) {
      setState(() {
        var hour = t.hour == 0
            ? 12
            : t.hour <= 12
                ? t.hour
                : t.hour - 12;
        var tod = t.hour < 12 ? 'AM' : 'PM';
        weeklyTimeCtl.text = hour.toString() +
            ':' +
            t.minute.toString().padLeft(2, '0') +
            ' ' +
            tod;
        weeklyTime = new DateTime(weeklyTime.year, weeklyTime.month,
            weeklyTime.day, t.hour, t.minute);
      });
    }
  }

  void scheduleDailyNotifications() async {
    var time = Time(dailyTime.hour, dailyTime.minute, 0);
    var hour = dailyTime.hour == 0
        ? 12
        : dailyTime.hour <= 12
            ? dailyTime.hour
            : dailyTime.hour - 12;
    var tod = dailyTime.hour < 12 ? 'AM' : 'PM';
    var body = 'Scheduled for ' +
        hour.toString() +
        ':' +
        time.minute.toString().padLeft(2, '0') +
        ' ' +
        tod;

    var androidDetails = new AndroidNotificationDetails(
        "dailyChannelId", "dailyChannelName", "dailyChannelDescription",
        importance: Importance.max);
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
    var hour = weeklyTime.hour == 0
        ? 12
        : weeklyTime.hour <= 12
            ? weeklyTime.hour
            : weeklyTime.hour - 12;
    var day = Day(_days.indexOf(dropDownDay) + 1);
    var tod = weeklyTime.hour < 12 ? 'AM' : 'PM';
    var body = 'Scheduled for ' +
        _days[day.value - 1] +
        ' at ' +
        hour.toString() +
        ':' +
        time.minute.toString().padLeft(2, '0') +
        ' ' +
        tod;

    var androidDetails = new AndroidNotificationDetails(
        "weeklyChannelId", "weeklyChannelName", "weeklyChannelDescription",
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Settings saved!'),
          // content: SingleChildScrollView(
          //   child: ListBody(
          //     children: <Widget>[
          //       Text('This is a demo alert dialog.'),
          //       Text('Would you like to approve of this message?'),
          //     ],
          //   ),
          // ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (wasChanged) {
              showAlertDialog(context);
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        title: Text(
          'Notification Settings',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: Expanded(
                child: Column(
                  children: [
                    SwitchListTile(
                      title: Text('Enable Notifications',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Receive reminders about tracking'),
                      value: enableNotifications,
                      onChanged: (bool value) {
                        setState(() {
                          enableNotifications = !enableNotifications;
                          if (!enableNotifications) {
                            enableDailyNotifications = false;
                            enableWeeklyNotifications = false;
                          }
                          if (enableNotifications != enableNotificationsStart) {
                            wasChanged = true;
                          } else {
                            if (enableDailyNotifications !=
                                    enableDailyNotificationsStart ||
                                enableWeeklyNotifications !=
                                    enableWeeklyNotificationsStart) {
                              wasChanged = true;
                            } else {
                              wasChanged = false;
                            }
                          }
                        });
                      },
                    ),
                    Divider(
                      color: Colors.grey[600],
                      thickness: 0,
                    ),
                    if (enableNotifications) ...[
                      SwitchListTile(
                        title: Text('Daily',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                            'Receive a daily reminder at a specified time'),
                        value: enableDailyNotifications,
                        onChanged: (bool value) {
                          setState(() {
                            enableDailyNotifications =
                                !enableDailyNotifications;
                            if (enableNotifications !=
                                enableNotificationsStart) {
                              wasChanged = true;
                            } else {
                              if (enableDailyNotifications !=
                                      enableDailyNotificationsStart ||
                                  enableWeeklyNotifications !=
                                      enableWeeklyNotificationsStart) {
                                wasChanged = true;
                              } else {
                                wasChanged = false;
                              }
                            }
                          });
                        },
                      ),
                      if (enableDailyNotifications) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: _pickDailyTime,
                              child: Container(
                                width: 175,
                                child: TextFormField(
                                  enabled: false,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                  controller: dailyTimeCtl,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.only(bottom: 0, top: 5),
                                    hintText: "Enter time",
                                    isDense: true,
                                  ),
                                  onChanged: (text) {
                                    wasChanged = true;
                                  },
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: _pickDailyTime,
                              child: Icon(
                                Icons.edit,
                                size: 20,
                                // color: Theme.of(context)
                                //     .highlightColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                      Divider(
                        color: Colors.grey[600],
                        thickness: 0,
                      ),
                      SwitchListTile(
                        title: Text('Weekly',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                            'Receive a weekly reminder on a specified day'),
                        value: enableWeeklyNotifications,
                        onChanged: (bool value) {
                          setState(() {
                            enableWeeklyNotifications =
                                !enableWeeklyNotifications;
                            if (enableNotifications !=
                                enableNotificationsStart) {
                              wasChanged = true;
                            } else {
                              if (enableDailyNotifications !=
                                      enableDailyNotificationsStart ||
                                  enableWeeklyNotifications !=
                                      enableWeeklyNotificationsStart) {
                                wasChanged = true;
                              } else {
                                wasChanged = false;
                              }
                            }
                          });
                        },
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      if (enableWeeklyNotifications) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 0, left: 15, right: 0)),
                            Expanded(
                              child: DropdownButtonFormField(
                                // isExpanded: true,
                                decoration: InputDecoration(
                                    labelText: 'Day',
                                    border: OutlineInputBorder(),
                                    hintText: "Day"),
                                value: dropDownDay,
                                validator: (value) =>
                                    value == null ? 'Field Required' : null,
                                onChanged: (String? value) {
                                  if (value != null)
                                    setState(() {
                                      dropDownDay = value;
                                      wasChanged = true;
                                    });
                                },
                                items: _days
                                    .map((day) => DropdownMenuItem(
                                        value: day, child: Text("$day")))
                                    .toList(),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: _pickWeeklyTime,
                                  child: Container(
                                    width: 175,
                                    child: TextFormField(
                                      enabled: false,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                      controller: weeklyTimeCtl,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(bottom: 0, top: 5),
                                        hintText: "Enter time",
                                        isDense: true,
                                      ),
                                      onChanged: (text) {
                                        wasChanged = true;
                                      },
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _pickWeeklyTime,
                                  child: Icon(
                                    Icons.edit,
                                    size: 20,
                                    // color: Theme.of(context)
                                    //     .highlightColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(5)),
                      ],
                    ],
                    if (enableNotifications) ...[
                      Divider(
                        color: Colors.grey[600],
                        thickness: 0,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                FlatButton(
                  // padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text('CANCEL', style: TextStyle(color: Colors.grey)),
                  onPressed: () {
                    if (wasChanged) {
                      showAlertDialog(context);
                    } else {
                      Navigator.pop(context, null);
                    }
                  },
                ),
                if (enableNotifications != enableDailyNotificationsStart ||
                    enableDailyNotifications != enableDailyNotificationsStart ||
                    enableWeeklyNotifications !=
                        enableWeeklyNotificationsStart) ...[
                  FlatButton(
                    color: Theme.of(context).buttonColor,
                    // padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'UPDATE',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
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
                      enableDailyNotificationsStart = enableNotifications;
                      enableDailyNotificationsStart = enableDailyNotifications;
                      enableWeeklyNotificationsStart =
                          enableWeeklyNotifications;
                      _showMyDialog();
                      wasChanged = false;
                    },
                  )
                ],
                if (enableNotifications == enableDailyNotificationsStart &&
                    enableDailyNotifications == enableDailyNotificationsStart &&
                    enableWeeklyNotifications ==
                        enableWeeklyNotificationsStart) ...[
                  FlatButton(
                      color: Colors.grey,
                      // padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'UPDATE',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () => {})
                ]
              ]),
            ),
            Padding(padding: EdgeInsets.all(50))
          ],
        ),
      ),
    );
  }
}
