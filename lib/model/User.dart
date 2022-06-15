class User {
  final String username;
  final String password;

  User(this.username, this.password);

  Map toJSON() => {'username': username, 'password': password};
}
