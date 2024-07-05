class UserModel {
  final int? id; 
  final String email;
  final String name;
  final String password;

  UserModel({
    this.id,
    required this.email,
    required this.name,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      password: map['password'],
    );
  }

 
}
