class UserModel {
  late String email;
  late String password;
  late int id;

  UserModel(this.email, this.password) {
    this.email = email;
    this.password = password;
  }

  UserModel.emptyConstructor();

  UserModel createUserInstance() {
    UserModel user = UserModel.emptyConstructor();
    return user;
  }
}
