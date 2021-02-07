import 'package:cnc_flutter_app/screens/account_screen.dart';
import 'package:cnc_flutter_app/screens/preferences_screen.dart';
import 'package:cnc_flutter_app/widgets/profile_menu_widget.dart';
import 'package:cnc_flutter_app/widgets/profile_pic_widget.dart';
import 'package:flutter/material.dart';


class Body extends StatelessWidget {
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
              icon: "assets/icons/User Icon.svg",
              press: () {
                // Navigate to the PreferencePage
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AccountPage(),
                ));}
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {
                // Navigate to the PreferencePage
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PreferencePage(),
                ));}
          ),
          // ProfileMenu(
          //   text: "Help Center",
          //   icon: "assets/icons/Camera Icon.svg",
          //   press: () {},
          // ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}