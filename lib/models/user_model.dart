class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String address;
  // final String apartmentNumber;
  final String position;
  // final String avatar;


  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.address,
    // required this.apartmentNumber,
    required this.position,
    // required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      address: json['address'],
      // apartmentNumber: json['apartmentNumber'],
      position: json['position'],
      // avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'address': address,
      // 'apartmentNumber': apartmentNumber,
      'position': position,
      // 'avatar': avatar,
    };
  }
}
