import 'dart:async';

import 'package:mysql1/mysql1.dart';

class Mysql{



  var settings = new ConnectionSettings(host: '10.0.2.2', port: 3306, user: 'root', password: 'root', db: 'health_app');

  get userId => null;

  Future<MySqlConnection> getConnection() async {
    // var conn = await MySqlConnection.connect(settings);
    // print(conn);
    return await MySqlConnection.connect(settings);


  }



  Future<bool> containsUserEmail(String name) async {
    print('here');
    var conn = await MySqlConnection.connect(settings);
    String sql = 'SELECT user_email FROM user WHERE user_email = ' + name;
    var results = await conn.query(sql);
    print(results);
    return true;
  }
}


