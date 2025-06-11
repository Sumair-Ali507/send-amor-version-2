class SearchUsers {
  final List<SearchList>? searchList;
  final Pageable? pageable;
  final bool? last;
  final int? totalPages;
  final int? totalElements;
  final bool? first;
  final int? size;
  final int? number;
  final Sort? sort;
  final int? numberOfElements;
  final bool? empty;

  SearchUsers({
    this.searchList,
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

  SearchUsers copyWith({
    List<SearchList>? content,
    Pageable? pageable,
    bool? last,
    int? totalPages,
    int? totalElements,
    bool? first,
    int? size,
    int? number,
    Sort? sort,
    int? numberOfElements,
    bool? empty,
  }) =>
      SearchUsers(
        searchList: content ?? searchList,
        pageable: pageable ?? this.pageable,
        last: last ?? this.last,
        totalPages: totalPages ?? this.totalPages,
        totalElements: totalElements ?? this.totalElements,
        first: first ?? this.first,
        size: size ?? this.size,
        number: number ?? this.number,
        sort: sort ?? this.sort,
        numberOfElements: numberOfElements ?? this.numberOfElements,
        empty: empty ?? this.empty,
      );

  factory SearchUsers.fromJson(Map<String, dynamic> json) => SearchUsers(
        searchList: json["content"] == null
            ? []
            : List<SearchList>.from(
                json["content"]!.map((x) => SearchList.fromJson(x))),
        pageable: json["pageable"] == null
            ? null
            : Pageable.fromJson(json["pageable"]),
        last: json["last"],
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        first: json["first"],
        size: json["size"],
        number: json["number"],
        sort: json["sort"] == null ? null : Sort.fromJson(json["sort"]),
        numberOfElements: json["numberOfElements"],
        empty: json["empty"],
      );

  Map<String, dynamic> toJson() => {
        "content": searchList == null
            ? []
            : List<dynamic>.from(searchList!.map((x) => x.toJson())),
        "pageable": pageable?.toJson(),
        "last": last,
        "totalPages": totalPages,
        "totalElements": totalElements,
        "first": first,
        "size": size,
        "number": number,
        "sort": sort?.toJson(),
        "numberOfElements": numberOfElements,
        "empty": empty,
      };
}

class SearchList {
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

  SearchList({
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

  SearchList copyWith({
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
      SearchList(
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

  factory SearchList.fromJson(Map<String, dynamic> json) => SearchList(
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

class Pageable {
  final int? pageNumber;
  final int? pageSize;
  final Sort? sort;
  final int? offset;
  final bool? paged;
  final bool? unpaged;

  Pageable({
    this.pageNumber,
    this.pageSize,
    this.sort,
    this.offset,
    this.paged,
    this.unpaged,
  });

  Pageable copyWith({
    int? pageNumber,
    int? pageSize,
    Sort? sort,
    int? offset,
    bool? paged,
    bool? unpaged,
  }) =>
      Pageable(
        pageNumber: pageNumber ?? this.pageNumber,
        pageSize: pageSize ?? this.pageSize,
        sort: sort ?? this.sort,
        offset: offset ?? this.offset,
        paged: paged ?? this.paged,
        unpaged: unpaged ?? this.unpaged,
      );

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        sort: json["sort"] == null ? null : Sort.fromJson(json["sort"]),
        offset: json["offset"],
        paged: json["paged"],
        unpaged: json["unpaged"],
      );

  Map<String, dynamic> toJson() => {
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "sort": sort?.toJson(),
        "offset": offset,
        "paged": paged,
        "unpaged": unpaged,
      };
}

class Sort {
  final bool? empty;
  final bool? sorted;
  final bool? unsorted;

  Sort({
    this.empty,
    this.sorted,
    this.unsorted,
  });

  Sort copyWith({
    bool? empty,
    bool? sorted,
    bool? unsorted,
  }) =>
      Sort(
        empty: empty ?? this.empty,
        sorted: sorted ?? this.sorted,
        unsorted: unsorted ?? this.unsorted,
      );

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        empty: json["empty"],
        sorted: json["sorted"],
        unsorted: json["unsorted"],
      );

  Map<String, dynamic> toJson() => {
        "empty": empty,
        "sorted": sorted,
        "unsorted": unsorted,
      };
}
