import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Icon'),
          Container(
            padding: const EdgeInsets.all(26.0),
            margin: const EdgeInsets.symmetric(
              horizontal: 48.0,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              color: Color.fromRGBO(30, 73, 152, 1),
            ),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
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
