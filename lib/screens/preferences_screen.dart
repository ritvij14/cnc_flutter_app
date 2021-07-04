import 'package:cnc_flutter_app/settings/preferences.dart';
import 'package:cnc_flutter_app/theme/app_themes.dart';
import 'package:cnc_flutter_app/theme/bloc/theme_bloc.dart';
import 'package:cnc_flutter_app/theme/bloc/theme_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferenceScreen extends StatefulWidget {
  @override
  _PreferenceScreen createState() => _PreferenceScreen();
}

class _PreferenceScreen extends State<PreferenceScreen> {
// class PreferenceScreen extends StatelessWidget {
  // const PreferenceScreen({Key key}) : super(key: key);
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    _getTheme();
  }

  _getTheme() async {
    String temp = Preferences.getTheme().toString();
    if (temp == "AppTheme.Default") {
      isSwitched = false;
    } else {
      isSwitched = true;
    }
  }

  _setTheme(String selectedTheme, BuildContext context) async {
    AppTheme userTheme;
    if (selectedTheme == "AppTheme.DarkMode") {
      userTheme = AppTheme.DarkMode;
    } else {
      userTheme = AppTheme.Default;
    }
    // else if(selectedTheme =="AppTheme.PinkLight") {
    //   userTheme = AppTheme.PinkLight;
    // }else if(selectedTheme =="AppTheme.PeriwinkleLight") {
    //   userTheme = AppTheme.PeriwinkleLight;
    // }else if(selectedTheme =="AppTheme.TealLight") {
    //   userTheme = AppTheme.TealLight;
    // }

    context.read<ThemeBloc>().add(ThemeEvent(appTheme: userTheme));
    Preferences.saveTheme(userTheme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Application Preferences"),
      ),
      body: Container(
        // child: Row(children: <Widget>[
        //   Text("Application Theme",
        //       // To show light text with the dark variants...
        //       style: TextStyle(color: Colors.white)),
        child: SwitchListTile(
          title: Text('Enable Dark Theme',
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Application is set to light theme by default'),
          value: isSwitched,
          onChanged: (bool value) {
            setState(() {
              isSwitched = value;
              if (!value) {
                _setTheme("AppTheme.Default", context);
              } else {
                _setTheme("AppTheme.DarkMode", context);
              }
            });
          },
        ),
        // Switch(
        //   value: isSwitched,
        //   onChanged: (value) {
        //     setState(() {
        //       isSwitched = value;
        //       if (!value) {
        //         _setTheme("AppTheme.Default", context);
        //       } else {
        //         _setTheme("AppTheme.DarkMode", context);
        //       }
        //
        //       print(isSwitched);
        //     });
        //   },
        // activeTrackColor: Colors.lightGreenAccent,
        // activeColor: Colors.green,
        // ),
        // ]),
      ),
    );
  }

//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('Application Preferences'),
//     ),
//     body: ListView.builder(
//       padding: EdgeInsets.all(8),
//       itemCount: AppTheme.values.length,
//       itemBuilder: (context, index) {
//         // Enums expose their values as a list - perfect for ListView
//         // Store the theme for the current ListView item
//         final itemAppTheme = AppTheme.values[index];
//         return Card(
//           // Style the cards with the to-be-selected theme colors
//           color:  itemAppTheme.toString() == "AppTheme.Default" ? Colors.blue[700] : Colors.black,
//           child: ListTile(
//             title: Text(
//               itemAppTheme.toString() == "AppTheme.Default" ? "Default (light)" : "Dark",
//               // To show light text with the dark variants...
//               style:   TextStyle(color: Colors.white)
//             ),
//             onTap: () {
//
//               _setTheme(itemAppTheme.toString(), context);
//             },
//           ),
//         );
//       },
//     ),
//   );
// }
}
