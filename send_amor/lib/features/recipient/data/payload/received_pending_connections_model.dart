class ReceivedPendingConnectionListModel {
  List<ConnectionContent>? content;
  Pageable? pageable;
  bool? last;
  int? totalPages;
  int? totalElements;
  bool? first;
  int? size;
  int? number;
  Sort? sort;
  int? numberOfElements;
  bool? empty;

  ReceivedPendingConnectionListModel({
    this.content,
    this.pageable,
    this.last,
    this.totalPages,
    this.totalElements,
    this.first,
    this.size,
    this.number,
    this.sort,
    this.numberOfElements,
    this.empty,
  });

  factory ReceivedPendingConnectionListModel.fromJson(
      Map<String, dynamic> json) {
    return ReceivedPendingConnectionListModel(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => ConnectionContent.fromJson(e))
          .toList(),
      pageable:
          json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null,
      last: json['last'],
      totalPages: json['totalPages'],
      totalElements: json['totalElements'],
      first: json['first'],
      size: json['size'],
      number: json['number'],
      sort: json['sort'] != null ? Sort.fromJson(json['sort']) : null,
      numberOfElements: json['numberOfElements'],
      empty: json['empty'],
    );
  }
}

class ConnectionContent {
  User? sender;
  User? receiver;
  String? status;
  String? createdAt;
  int? id;

  ConnectionContent(
      {this.sender, this.receiver, this.status, this.createdAt, this.id});

  factory ConnectionContent.fromJson(Map<String, dynamic> json) {
    return ConnectionContent(
      sender: json['sender'] != null ? User.fromJson(json['sender']) : null,
      receiver:
          json['receiver'] != null ? User.fromJson(json['receiver']) : null,
      status: json['status'],
      createdAt: json['createdAt'],
      id: json['id'],
    );
  }
}

class User {
  int? id;
  String? email;
  String? name;
  String? password;
  String? role;
  String? uniqueName;
  String? createdAt;
  String? updatedAt;
  String? profileImageUrl;
  String? token;
  String? username;
  List<dynamic>? authorities;
  bool? enabled;
  bool? accountNonExpired;
  bool? accountNonLocked;
  bool? credentialsNonExpired;

  User({
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      password: json['password'],
      role: json['role'],
      uniqueName: json['uniqueName'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      profileImageUrl: json['profileImageUrl'],
      token: json['token'],
      username: json['username'],
      authorities: json['authorities'] as List<dynamic>?,
      enabled: json['enabled'],
      accountNonExpired: json['accountNonExpired'],
      accountNonLocked: json['accountNonLocked'],
      credentialsNonExpired: json['credentialsNonExpired'],
    );
  }
}

class Pageable {
  int? pageNumber;
  int? pageSize;
  Sort? sort;
  int? offset;
  bool? paged;
  bool? unpaged;

  Pageable({
    this.pageNumber,
    this.pageSize,
    this.sort,
    this.offset,
    this.paged,
    this.unpaged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) {
    return Pageable(
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      sort: json['sort'] != null ? Sort.fromJson(json['sort']) : null,
      offset: json['offset'],
      paged: json['paged'],
      unpaged: json['unpaged'],
    );
  }
}

class Sort {
  bool? empty;
  bool? sorted;
  bool? unsorted;

  Sort({this.empty, this.sorted, this.unsorted});

  factory Sort.fromJson(Map<String, dynamic> json) {
    return Sort(
      empty: json['empty'],
      sorted: json['sorted'],
      unsorted: json['unsorted'],
    );
  }
}
