class UserApp {
  int userId;
  String userName;
  String userEmail;
  String? password;
  String ville;
  String phone;

  UserApp({
    this.password,
    required this.phone,
    required this.userEmail,
    required this.userId,
    required this.userName,
    required this.ville,
  });

  // to Map

  Map<String, dynamic> toMap() => {
        'user_id': userId,
        'name': userName,
        'phone': phone,
        'email': userEmail,
        'password': password,
        'ville': ville,
      };

  // from Map

  factory UserApp.fromMap(data) => UserApp(
        userEmail: data['email'],
        userId: data['user_id'],
        phone: data['phone'],
        userName: data['name'],
        ville: data['ville'],
        password: data['password'],
      );
}
