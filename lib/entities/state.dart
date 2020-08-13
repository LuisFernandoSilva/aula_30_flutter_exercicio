class AppState {
  int id;

  String email;
  String token;
  String name;
  AppState({
    this.id,
    this.email,
    this.token,
    this.name,
  });

  AppState.empty();

  AppState.fromDatabase(Map<String, dynamic> map) {
    id = map['id'];
    email = map['email'];
    token = map['token'];
    name = map['name'];
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'email': email, 'token': token, 'name': name};
  }
}
