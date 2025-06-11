class SendConnectionsModel {
  final Receiver? sender;
  final Receiver? receiver;
  final String? status;
  final DateTime? createdAt;
  final int? id;

  SendConnectionsModel({
    this.sender,
    this.receiver,
    this.status,
    this.createdAt,
    this.id,
  });

  SendConnectionsModel copyWith({
    Receiver? sender,
    Receiver? receiver,
    String? status,
    DateTime? createdAt,
    int? id,
  }) =>
      SendConnectionsModel(
        sender: sender ?? this.sender,
        receiver: receiver ?? this.receiver,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory SendConnectionsModel.fromJson(Map<String, dynamic> json) =>
      SendConnectionsModel(
        sender:
            json["sender"] == null ? null : Receiver.fromJson(json["sender"]),
        receiver: json["receiver"] == null
            ? null
            : Receiver.fromJson(json["receiver"]),
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "sender": sender?.toJson(),
        "receiver": receiver?.toJson(),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "id": id,
      };
}

class Receiver {
  final int? id;
  final String? email;
  final String? name;
  final String? password;
  final String? role;
  final String? uniqueName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic profileImageUrl;
  final String? token;
  final String? username;
  final List<dynamic>? authorities;
  final bool? enabled;
  final bool? accountNonExpired;
  final bool? accountNonLocked;
  final bool? credentialsNonExpired;

  Receiver({
    this.id,
    this.email,
    this.name,
    this.password,
    this.role,
    this.uniqueName,
    this.createdAt,
    this.updatedAt,
    this.profileImageUrl,
    this.token,
    this.username,
    this.authorities,
    this.enabled,
    this.accountNonExpired,
    this.accountNonLocked,
    this.credentialsNonExpired,
  });

  Receiver copyWith({
    int? id,
    String? email,
    String? name,
    String? password,
    String? role,
    String? uniqueName,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic profileImageUrl,
    String? token,
    String? username,
    List<dynamic>? authorities,
    bool? enabled,
    bool? accountNonExpired,
    bool? accountNonLocked,
    bool? credentialsNonExpired,
  }) =>
      Receiver(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        password: password ?? this.password,
        role: role ?? this.role,
        uniqueName: uniqueName ?? this.uniqueName,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        profileImageUrl: profileImageUrl ?? this.profileImageUrl,
        token: token ?? this.token,
        username: username ?? this.username,
        authorities: authorities ?? this.authorities,
        enabled: enabled ?? this.enabled,
        accountNonExpired: accountNonExpired ?? this.accountNonExpired,
        accountNonLocked: accountNonLocked ?? this.accountNonLocked,
        credentialsNonExpired:
            credentialsNonExpired ?? this.credentialsNonExpired,
      );

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        password: json["password"],
        role: json["role"],
        uniqueName: json["uniqueName"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        profileImageUrl: json["profileImageUrl"],
        token: json["token"],
        username: json["username"],
        authorities: json["authorities"] == null
            ? []
            : List<dynamic>.from(json["authorities"]!.map((x) => x)),
        enabled: json["enabled"],
        accountNonExpired: json["accountNonExpired"],
        accountNonLocked: json["accountNonLocked"],
        credentialsNonExpired: json["credentialsNonExpired"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "password": password,
        "role": role,
        "uniqueName": uniqueName,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "profileImageUrl": profileImageUrl,
        "token": token,
        "username": username,
        "authorities": authorities == null
            ? []
            : List<dynamic>.from(authorities!.map((x) => x)),
        "enabled": enabled,
        "accountNonExpired": accountNonExpired,
        "accountNonLocked": accountNonLocked,
        "credentialsNonExpired": credentialsNonExpired,
      };
}
