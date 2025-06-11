class AppUser {
  final bool? success;
  final String? message;
  final AppUserData? appUserData;

  AppUser({
    this.success,
    this.message,
    this.appUserData,
  });

  // Factory constructor to create AppUser instance from JSON
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      success: json['success'],
      message: json['message'],
      appUserData: json['response'] != null
          ? AppUserData.fromJson(json['response'])
          : null,
    );
  }

  // Method to convert AppUser instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'response': appUserData?.toJson(),
    };
  }



  // CopyWith method to create a new AppUser with modified values
  AppUser copyWith({
    bool? success,
    String? message,
    AppUserData? appUserData,
  }) {
    return AppUser(
      success: success ?? this.success,
      message: message ?? this.message,
      appUserData: appUserData ?? this.appUserData,
    );
  }
}

class AppUserData {
  final int? id;
  final String? email;
  final String? name;
  final String? password;
  final String? role;
  final String? profileImageUrl;
  final String? uniqueName;
  final String? token;
  final String? username;
  final String? createdAt;
  final String? updatedAt;

  AppUserData({
    this.id,
    this.email,
    this.name,
    this.password,
    this.role,
    this.profileImageUrl,
    this.uniqueName,
    this.token,
    this.username,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor to create AppUserData instance from JSON
  factory AppUserData.fromJson(Map<String, dynamic> json) {
    return AppUserData(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      password: json['password'],
      role: json['role'],
      profileImageUrl: json['profileImageUrl'],
      uniqueName: json['uniqueName'],
      token: json['token'],
      username: json['username'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  // Method to convert AppUserData instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'password': password,
      'role': role,
      'profileImageUrl': profileImageUrl,
      'uniqueName': uniqueName,
      'token': token,
      'username': username,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // CopyWith method to create a new AppUserData with modified values
  AppUserData copyWith({
    int? id,
    String? email,
    String? name,
    String? password,
    String? role,
    String? profileImageUrl,
    String? uniqueName,
    String? token,
    String? username,
    String? createdAt,
    String? updatedAt,
  }) {
    return AppUserData(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      role: role ?? this.role,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      uniqueName: uniqueName ?? this.uniqueName,
      token: token ?? this.token,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
