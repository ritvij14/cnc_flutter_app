import 'package:cnc_flutter_app/widgets/account_body_widget.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  // static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: AccountBody(),
    );
  }
}
