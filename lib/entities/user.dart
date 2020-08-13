class User {
  int id;
  String email;
  String name;
  String password;
  
  User({
    this.id,
    this.email,
    this.name,
    this.password,
  });

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    email = map['email'];
    name = map['name'];
    password = map['password'];
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'email': email, 'name': name, 'password': password};
  }
}
