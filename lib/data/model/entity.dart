import '/common_libraries.dart';

class Nullable<T> {
  final T value;
  const Nullable.value(this.value);
}

enum CrudView {
  list,
  detail,
  create,
  update;

  bool get isList => this == CrudView.list;

  bool get isDetail => this == CrudView.detail;

  bool get isCreate => this == CrudView.create;

  bool get isUpdate => this == CrudView.update;

  @override
  String toString() {
    return isList
        ? 'Add'
        : isCreate
            ? 'Create'
            : isUpdate
                ? 'Update'
                : 'Show list';
  }
}

class SortOrder extends Equatable {
  final String id;
  final int order;

  const SortOrder({required this.id, required this.order});

  @override
  List<Object?> get props => [
        id,
        order,
      ];

  SortOrder copyWith({
    String? id,
    int? order,
  }) {
    return SortOrder(
      id: id ?? this.id,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'order': order,
    };
  }
}

class EntityHeader extends Equatable {
  final String name;
  final String title;
  final bool isHidden;
  const EntityHeader({
    required this.name,
    required this.title,
    required this.isHidden,
  });

  @override
  List<Object?> get props => [
        name,
        title,
        isHidden,
      ];

  factory EntityHeader.fromMap(Map<String, dynamic> map) {
    return EntityHeader(
      name: map['name'] as String,
      title: map['title'] as String,
      isHidden: map['isHidden'] as bool,
    );
  }

  factory EntityHeader.fromJson(String source) => EntityHeader.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FilteredEntity extends Equatable {
  final String id;
  final bool deleted;
  final String createdOn;
  final String createdBy;
  final String? lastModifiedOn;
  final String? lastModifiedByUserName;
  final String createdById;
  const FilteredEntity({
    this.id = '',
    this.deleted = false,
    this.createdOn = '',
    this.createdBy = '',
    this.createdById = emptyGuid,
    this.lastModifiedOn = '',
    this.lastModifiedByUserName = '',
  });

  @override
  List<Object?> get props => [
        id,
        deleted,
        createdOn,
        createdBy,
        createdById,
        lastModifiedOn,
        lastModifiedByUserName,
      ];

  // FilteredEntity.fromMap(Map<String, dynamic> map)
  //     : id = map['id'] ?? '',
  //       deleted = map['deleted'] ?? false,
  //       createdOn = map['created_On'] != null
  //           ? FormatDate(
  //                   format: 'MM/dd/yyyy', dateString: map['created_On'] ?? '')
  //               .formatDate
  //           : '--',
  //       createdBy = map['created_By'] ?? '',
  //       createdById = map['created_By'] ?? emptyGuid,
  //       lastModifiedOn = map['last_Modified_On'] != null
  //           ? FormatDate(
  //                   format: 'MM/dd/yyyy',
  //                   dateString: map['last_Modified_On'] ?? '')
  //               .formatDate
  //           : '--',
  //       lastModifiedByUserName = map['last_Modified_By'] ?? '';

  factory FilteredEntity.fromMap(Map<String, dynamic> map) {
    return FilteredEntity(
      id: map['id'] ?? '',
      deleted: map['deleted'] ?? false,
      createdOn: map['created_On'] != null ? FormatDate(format: 'MM/dd/yyyy', dateString: map['created_On'] ?? '').formatDate : '--',
      createdBy: map['created_By'] ?? '',
      createdById: map['created_By_Id'] ?? emptyGuid,
      lastModifiedOn: map['last_Modified_On'] != null ? FormatDate(format: 'MM/dd/yyyy', dateString: map['last_Modified_On'] ?? '').formatDate : '--',
      lastModifiedByUserName: map['last_Updated_By'] ?? '',
    );
  }

  factory FilteredEntity.fromJson(String source) => FilteredEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}

// EntityHeader.fromMap(Map<String, dynamic> map)
//       : isHidden = map['isHidden'],
//         name = map['name'],
//         title = map['title'];

// class FilteredEntityData extends Equatable {
//   final List<EntityHeader> headers;
//   final List<FilteredEntity> data;
//   final int totalRows;
//   const FilteredEntityData({
//     required this.headers,
//     required this.data,
//     required this.totalRows,
//   });

//   @override
//   List<Object?> get props => [
//         headers,
//         data,
//       ];

//   factory FilteredEntityData.fromMap(Map<String, dynamic> map) {
//     return FilteredEntityData(
//       headers: List<EntityHeader>.from(
//         (map['headers']).map<EntityHeader>(
//           (x) => EntityHeader.fromMap(x),
//         ),
//       ),
//       totalRows: map['totalRows'] ?? 0,
//       data: List.from(
//         (map['data']).map(
//           (x) => FilteredEntity.fromMap(x),
//         ),
//       ),
//     );
//   }

//   factory FilteredEntityData.fromJson(String source) =>
//       FilteredEntityData.fromMap(json.decode(source) as Map<String, dynamic>);
// }

// standadized model, which other models inherit
class Entity extends Equatable {
  final List<EntityHeader> headers;
  final dynamic? id;
  final String? name;
  final String? deactivationDate;
  final String? deactivationUserName;
  final bool active;
  final String? createdOn;
  final String? createdByUserName;
  final String? lastModifiedByUserName;
  final String? lastModifiedOn;
  final List<String> columns;
  final bool deleted;

  const Entity({
    this.columns = const [],
    this.headers = const [],
    this.id,
    this.name,
    this.deactivationDate,
    this.deactivationUserName,
    this.active = true,
    this.createdByUserName,
    this.createdOn,
    this.lastModifiedByUserName,
    this.lastModifiedOn,
    this.deleted = false,
  });

  // constructor to create entity from map
  factory Entity.fromMap(Map<String, dynamic> map) {
    return Entity(
      headers: map['headers'] != null ? List.from(map['headers']).map((e) => EntityHeader.fromMap(e)).toList() : [],
      id: map['id'],
      name: map['name'] != null ? map['name'] as String : null,
      active: map['active'] != null ? map['active'] as bool : true,
      deactivationDate: map['deactivationDate'] != null ? FormatDate(format: 'MM/dd/yyyy', dateString: map['deactivationDate']).formatDate : '',
      deactivationUserName: map['deactivationUserName'] != null ? map['deactivationUserName'] as String : '',
      createdByUserName: map['createdByUserName'] ?? '',
      createdOn: map['createdOn'] != null ? FormatDate(format: 'MM/dd/yyyy', dateString: map['createdOn'] ?? '').formatDate : '--',
      lastModifiedOn: map['lastModifiedOn'] != null ? FormatDate(format: 'MM/dd/yyyy', dateString: map['lastModifiedOn'] ?? '').formatDate : '--',
      lastModifiedByUserName: map['lastModifiedByUserName'] ?? map['updatedByUserName'] ?? '--',
    );
  }

  // return the entity object as map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'active': active,
    };
  }

  // return table details map
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{};
  }

  // return table details map
  Map<String, dynamic> sideDetailItemsToMap() {
    return tableItemsToMap();
  }

  // return side detail map
  Map<String, dynamic> detailItemsToMap() {
    if (!active && deactivationDate != null && deactivationUserName != null && deactivationDate!.isNotEmpty && deactivationUserName!.isNotEmpty) {
      return <String, dynamic>{
        'Active': active,
        'Deactivated': 'By: $deactivationUserName on $deactivationDate',
      };
    }
    return {
      'Active': active,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        deactivationDate,
        deactivationUserName,
        active,
        createdOn,
        createdByUserName,
        columns,
        deleted,
      ];
}

// response object to get the response from api, which others wil inherit it
class EntityResponse {
  final bool isSuccess;
  String message;
  final int statusCode;
  final Entity? data;
  EntityResponse({
    required this.isSuccess,
    required this.message,
    this.statusCode = 200,
    this.data,
  }) {
    message = message.replaceAll('"', '');
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isSuccess': isSuccess,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory EntityResponse.fromMap(Map<String, dynamic> map) {
    String message = (map['Message'] ?? (map['message'] ?? (map['Description'] ?? ''))).toString();
    message = message.replaceAll('"', '');
    return EntityResponse(
      statusCode: map['StatusCode'] ?? 200,
      isSuccess: map['isSuccess'] == null ? (map['Message'] ?? (map['message'] ?? '')).toString().contains('success') : map['isSuccess'] as bool,
      message: message,
      data: Entity.fromMap(map['data'] != null ? map['data'] as Map<String, dynamic> : {}),
    );
  }
  factory EntityResponse.fromString(String map) {
    return EntityResponse(
      statusCode: 200,
      isSuccess: map.contains('success'),
      message: map,
      data: null,
    );
  }
  String toJson() => json.encode(toMap());

  factory EntityResponse.fromJson(String source) => EntityResponse.fromMap(json.decode(source));

  EntityResponse copyWith({
    bool? isSuccess,
    String? message,
    Entity? data,
    int? statusCode,
  }) {
    return EntityResponse(
      statusCode: statusCode ?? this.statusCode,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

enum EntityStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == EntityStatus.loading;
  bool get isSuccess => this == EntityStatus.success;
  bool get isFailure => this == EntityStatus.failure;
}

extension BoolToEntityStatus on bool {
  EntityStatus toEntityStatusCode() {
    return this ? EntityStatus.success : EntityStatus.failure;
  }
}

///Chart sample data
class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData({
    this.x,
    this.y,
    this.xValue,
    this.yValue,
    this.secondSeriesYValue,
    this.thirdSeriesYValue,
    this.pointColor,
    this.size,
    this.text,
    this.open,
    this.close,
    this.low,
    this.high,
    this.volume,
  });

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}
