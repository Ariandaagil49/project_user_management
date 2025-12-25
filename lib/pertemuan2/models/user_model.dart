class UserModel {
  final String id;
  final String name;
  final String email;
  final String address;
  final String phoneNumber;
  final String city;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.city,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['id'] ?? '',
      email: json['id'] ?? '',
      address: json['id'] ?? '',
      phoneNumber: json['id'] ?? '',
      city: json['id'] ?? '',
    );
  }
}
