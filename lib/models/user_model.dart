import 'package:flutter/material.dart';

class UserModel{

  String email;
  String password;
  int id;

  UserModel(String email, String password){
    this.email = email;
    this.password = password;
  }

  UserModel.emptyConstructor();

  UserModel createUserInstance() {
    UserModel user = UserModel.emptyConstructor();
    return user;
  }

}