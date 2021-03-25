import 'package:cnc_flutter_app/screens/details_screen_strepper.dart';
import 'package:cnc_flutter_app/screens/login_screen.dart';
import 'package:cnc_flutter_app/screens/profile/notification_settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/profile/account_screen.dart';
import '../screens/preferences_screen.dart';
import 'profile_menu_widget.dart';
import 'profile_pic_widget.dart';

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
              text: "My Account",
              icon: "./assets/icons/User Icon.svg",
              press: () {
                // Navigate to the PreferencePage
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AccountScreen(),
                ));
              }),
          ProfileMenu(
              text: "Personal Details",
              icon: "assets/icons/Accessibility New.svg",
              press: () {
                // Navigate to the DetailsScreen
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsScreen(),
                ));
              }),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {
              // Navigate to the DetailsScreen
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NotificationSettings(),
              ));
            },
          ),
          ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {
                // Navigate to the PreferencePage
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PreferenceScreen(),
                ));
              }),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              var prefs = await SharedPreferences.getInstance();
              prefs?.clear();
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) =>
                      false);
            },
          ),
        ],
      ),
    );
  }
}
