import 'package:money_transfer_app/features/recipient/data/payload/pending_connections_model.dart';

class AcceptedConnectionsModel {
  final List<PendingRecipientList>? content;
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

  AcceptedConnectionsModel({
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

  AcceptedConnectionsModel copyWith({
    List<PendingRecipientList>? content,
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
      AcceptedConnectionsModel(
        content: content ?? this.content,
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

  factory AcceptedConnectionsModel.fromJson(Map<String, dynamic> json) =>
      AcceptedConnectionsModel(
        content: json["content"] == null
            ? []
            : List<PendingRecipientList>.from(json["content"]!.map((x) => x)),
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
        "content":
            content == null ? [] : List<dynamic>.from(content!.map((x) => x)),
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
