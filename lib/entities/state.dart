class AppState {
  int id;
  String email;
  String token;

  AppState({
    this.id,
    this.email,
    this.token,
  });

  AppState.empty();

  AppState.fromDatabase(Map<String, dynamic> map) {
    id = map['id'];
    email = map['email'];
    token = map['token'];
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'email': email, 'token': token};
  }
}
