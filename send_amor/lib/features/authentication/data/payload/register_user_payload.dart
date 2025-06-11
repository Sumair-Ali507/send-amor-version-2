class RegisterUserPayload {
  final String? email;
  final String? name;
  final String? password;
  final String? role;
  final String? uniqueName;
  final String? phone;
  final String? country;
  final String? countryCode;
  final String? dateOfBirth;
  final String? address;
  final String? profileImageUrl;
  final String? fcmToken;

  RegisterUserPayload({
    this.email,
    this.name,
    this.password,
    this.role,
    this.uniqueName,
    this.phone,
    this.country,
    this.countryCode,
    this.dateOfBirth,
    this.address,
    this.profileImageUrl,
    this.fcmToken,
  });

  factory RegisterUserPayload.fromJson(Map<String, dynamic> json) {
    return RegisterUserPayload(
      email: json['email'] as String?,
      name: json['name'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String?,
      uniqueName: json['uniqueName'] as String?,
      phone: json['phone'] as String?,
      country: json['country'] as String?,
      countryCode: json['countryCode'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      address: json['address'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      fcmToken: json['fcmToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'password': password,
      'role': role,
      'uniqueName': uniqueName,
      'phone': phone,
      'country': country,
      'countryCode': countryCode,
      'dateOfBirth': dateOfBirth,
      'address': address,
      'profileImageUrl': profileImageUrl,
      'fcmToken': fcmToken,
    };
  }
}