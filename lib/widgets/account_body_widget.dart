import 'package:flutter/material.dart';
import 'account_menu_widget.dart';
import 'account_pic_widget.dart';


class AccountBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          AccountPic(),
          SizedBox(height: 20),
          AccountMenu(
            text: "Temp Username",
            icon: "assets/icons/User Icon.svg",
            label: "YOB",
            press: () => {},
          ),
          AccountMenu(
            text: "temp@gmail.com",
            icon: "assets/icons/Email.svg",
            label: "YOB",
            press: () {},
          ),
          AccountMenu(
              text: "(123) 456-7890",
              icon: "assets/icons/Phone.svg",
              label: "YOB",
              press: () {}
          ),
          AccountMenu(
              text: "01/01/1991",
              icon: "assets/icons/Calendar.svg",
              label: "YOB",
              press: () {}
          ),
        ],
      ),
    );
  }
}