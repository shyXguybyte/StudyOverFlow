class RegisterModel {
  final String email;
  final String password;
  final String userName;
  final String phone;
  final String firstName;
  final String lastName;

  RegisterModel(
      {required this.email,
      required this.password,
      required this.userName,
      required this.phone,
      required this.firstName,
      required this.lastName});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'userName': userName,
      'phone': phone,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      email: map['email'] as String,
      password: map['password'] as String,
      userName: map['userName'] as String,
      phone: map['phone'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
    );
  }
}
