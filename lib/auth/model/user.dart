class User {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String profession;

  User({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profession,
    required this.password,
  });

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        phoneNumber = json['phoneNumber'],
        profession = json['profession'],
        password = json['password'];
  
  Map<String, String> toJson() => {
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'profession': profession,
        'password': password
      };
}
