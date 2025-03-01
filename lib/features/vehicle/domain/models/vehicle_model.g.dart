// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVehicleCollection on Isar {
  IsarCollection<Vehicle> get vehicles => this.collection();
}

const VehicleSchema = CollectionSchema(
  name: r'Vehicle',
  id: -21624847921258799,
  properties: {
    r'brand': PropertySchema(
      id: 0,
      name: r'brand',
      type: IsarType.string,
    ),
    r'color': PropertySchema(
      id: 1,
      name: r'color',
      type: IsarType.string,
    ),
    r'kilometer': PropertySchema(
      id: 2,
      name: r'kilometer',
      type: IsarType.long,
    ),
    r'lastInspectionDate': PropertySchema(
      id: 3,
      name: r'lastInspectionDate',
      type: IsarType.dateTime,
    ),
    r'lastMaintenanceDate': PropertySchema(
      id: 4,
      name: r'lastMaintenanceDate',
      type: IsarType.dateTime,
    ),
    r'lastServiceDate': PropertySchema(
      id: 5,
      name: r'lastServiceDate',
      type: IsarType.dateTime,
    ),
    r'model': PropertySchema(
      id: 6,
      name: r'model',
      type: IsarType.string,
    ),
    r'nextInspectionDate': PropertySchema(
      id: 7,
      name: r'nextInspectionDate',
      type: IsarType.dateTime,
    ),
    r'nextMaintenanceDate': PropertySchema(
      id: 8,
      name: r'nextMaintenanceDate',
      type: IsarType.dateTime,
    ),
    r'nextServiceDate': PropertySchema(
      id: 9,
      name: r'nextServiceDate',
      type: IsarType.dateTime,
    ),
    r'plate': PropertySchema(
      id: 10,
      name: r'plate',
      type: IsarType.string,
    ),
    r'year': PropertySchema(
      id: 11,
      name: r'year',
      type: IsarType.long,
    )
  },
  estimateSize: _vehicleEstimateSize,
  serialize: _vehicleSerialize,
  deserialize: _vehicleDeserialize,
  deserializeProp: _vehicleDeserializeProp,
  idName: r'id',
  indexes: {
    r'brand': IndexSchema(
      id: 6145529221080171523,
      name: r'brand',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'brand',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'plate': IndexSchema(
      id: -6062363338784229650,
      name: r'plate',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'plate',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _vehicleGetId,
  getLinks: _vehicleGetLinks,
  attach: _vehicleAttach,
  version: '3.1.0+1',
);

int _vehicleEstimateSize(
  Vehicle object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.brand.length * 3;
  {
    final value = object.color;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.model.length * 3;
  bytesCount += 3 + object.plate.length * 3;
  return bytesCount;
}

void _vehicleSerialize(
  Vehicle object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.brand);
  writer.writeString(offsets[1], object.color);
  writer.writeLong(offsets[2], object.kilometer);
  writer.writeDateTime(offsets[3], object.lastInspectionDate);
  writer.writeDateTime(offsets[4], object.lastMaintenanceDate);
  writer.writeDateTime(offsets[5], object.lastServiceDate);
  writer.writeString(offsets[6], object.model);
  writer.writeDateTime(offsets[7], object.nextInspectionDate);
  writer.writeDateTime(offsets[8], object.nextMaintenanceDate);
  writer.writeDateTime(offsets[9], object.nextServiceDate);
  writer.writeString(offsets[10], object.plate);
  writer.writeLong(offsets[11], object.year);
}

Vehicle _vehicleDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Vehicle(
    brand: reader.readString(offsets[0]),
    color: reader.readStringOrNull(offsets[1]),
    id: id,
    kilometer: reader.readLongOrNull(offsets[2]),
    lastInspectionDate: reader.readDateTimeOrNull(offsets[3]),
    lastMaintenanceDate: reader.readDateTimeOrNull(offsets[4]),
    lastServiceDate: reader.readDateTimeOrNull(offsets[5]),
    model: reader.readString(offsets[6]),
    nextInspectionDate: reader.readDateTimeOrNull(offsets[7]),
    nextMaintenanceDate: reader.readDateTimeOrNull(offsets[8]),
    nextServiceDate: reader.readDateTimeOrNull(offsets[9]),
    plate: reader.readString(offsets[10]),
    year: reader.readLong(offsets[11]),
  );
  return object;
}

P _vehicleDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 9:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _vehicleGetId(Vehicle object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _vehicleGetLinks(Vehicle object) {
  return [];
}

void _vehicleAttach(IsarCollection<dynamic> col, Id id, Vehicle object) {
  object.id = id;
}

extension VehicleByIndex on IsarCollection<Vehicle> {
  Future<Vehicle?> getByPlate(String plate) {
    return getByIndex(r'plate', [plate]);
  }

  Vehicle? getByPlateSync(String plate) {
    return getByIndexSync(r'plate', [plate]);
  }

  Future<bool> deleteByPlate(String plate) {
    return deleteByIndex(r'plate', [plate]);
  }

  bool deleteByPlateSync(String plate) {
    return deleteByIndexSync(r'plate', [plate]);
  }

  Future<List<Vehicle?>> getAllByPlate(List<String> plateValues) {
    final values = plateValues.map((e) => [e]).toList();
    return getAllByIndex(r'plate', values);
  }

  List<Vehicle?> getAllByPlateSync(List<String> plateValues) {
    final values = plateValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'plate', values);
  }

  Future<int> deleteAllByPlate(List<String> plateValues) {
    final values = plateValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'plate', values);
  }

  int deleteAllByPlateSync(List<String> plateValues) {
    final values = plateValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'plate', values);
  }

  Future<Id> putByPlate(Vehicle object) {
    return putByIndex(r'plate', object);
  }

  Id putByPlateSync(Vehicle object, {bool saveLinks = true}) {
    return putByIndexSync(r'plate', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByPlate(List<Vehicle> objects) {
    return putAllByIndex(r'plate', objects);
  }

  List<Id> putAllByPlateSync(List<Vehicle> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'plate', objects, saveLinks: saveLinks);
  }
}

extension VehicleQueryWhereSort on QueryBuilder<Vehicle, Vehicle, QWhere> {
  QueryBuilder<Vehicle, Vehicle, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhere> anyBrand() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'brand'),
      );
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhere> anyPlate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'plate'),
      );
    });
  }
}

extension VehicleQueryWhere on QueryBuilder<Vehicle, Vehicle, QWhereClause> {
  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> brandEqualTo(String brand) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'brand',
        value: [brand],
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> brandNotEqualTo(
      String brand) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'brand',
              lower: [],
              upper: [brand],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'brand',
              lower: [brand],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'brand',
              lower: [brand],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'brand',
              lower: [],
              upper: [brand],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> brandGreaterThan(
    String brand, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'brand',
        lower: [brand],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> brandLessThan(
    String brand, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'brand',
        lower: [],
        upper: [brand],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> brandBetween(
    String lowerBrand,
    String upperBrand, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'brand',
        lower: [lowerBrand],
        includeLower: includeLower,
        upper: [upperBrand],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> brandStartsWith(
      String BrandPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'brand',
        lower: [BrandPrefix],
        upper: ['$BrandPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> brandIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'brand',
        value: [''],
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> brandIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'brand',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'brand',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'brand',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'brand',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> plateEqualTo(String plate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'plate',
        value: [plate],
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> plateNotEqualTo(
      String plate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'plate',
              lower: [],
              upper: [plate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'plate',
              lower: [plate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'plate',
              lower: [plate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'plate',
              lower: [],
              upper: [plate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> plateGreaterThan(
    String plate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'plate',
        lower: [plate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> plateLessThan(
    String plate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'plate',
        lower: [],
        upper: [plate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> plateBetween(
    String lowerPlate,
    String upperPlate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'plate',
        lower: [lowerPlate],
        includeLower: includeLower,
        upper: [upperPlate],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> plateStartsWith(
      String PlatePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'plate',
        lower: [PlatePrefix],
        upper: ['$PlatePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> plateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'plate',
        value: [''],
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterWhereClause> plateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'plate',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'plate',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'plate',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'plate',
              upper: [''],
            ));
      }
    });
  }
}

extension VehicleQueryFilter
    on QueryBuilder<Vehicle, Vehicle, QFilterCondition> {
  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> brandEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> brandGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> brandLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> brandBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'brand',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> brandStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> brandEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> brandContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'brand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> brandMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'brand',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> brandIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brand',
        value: '',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> brandIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'brand',
        value: '',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> colorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> colorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> colorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> colorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> colorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> colorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'color',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> colorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> colorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> colorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> colorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'color',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> colorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> colorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> kilometerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'kilometer',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> kilometerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'kilometer',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> kilometerEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kilometer',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> kilometerGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kilometer',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> kilometerLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kilometer',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> kilometerBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kilometer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      lastInspectionDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastInspectionDate',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      lastInspectionDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastInspectionDate',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      lastInspectionDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastInspectionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      lastInspectionDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastInspectionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      lastInspectionDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastInspectionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      lastInspectionDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastInspectionDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      lastMaintenanceDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastMaintenanceDate',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      lastMaintenanceDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastMaintenanceDate',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      lastMaintenanceDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMaintenanceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      lastMaintenanceDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastMaintenanceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      lastMaintenanceDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastMaintenanceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      lastMaintenanceDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastMaintenanceDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      lastServiceDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastServiceDate',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      lastServiceDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastServiceDate',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> lastServiceDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastServiceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      lastServiceDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastServiceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> lastServiceDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastServiceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> lastServiceDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastServiceDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> modelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> modelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> modelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> modelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'model',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> modelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> modelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> modelContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> modelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'model',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> modelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'model',
        value: '',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> modelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'model',
        value: '',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      nextInspectionDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nextInspectionDate',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      nextInspectionDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nextInspectionDate',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      nextInspectionDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextInspectionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      nextInspectionDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextInspectionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      nextInspectionDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextInspectionDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      nextInspectionDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextInspectionDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      nextMaintenanceDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nextMaintenanceDate',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      nextMaintenanceDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nextMaintenanceDate',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      nextMaintenanceDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextMaintenanceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      nextMaintenanceDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextMaintenanceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      nextMaintenanceDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextMaintenanceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      nextMaintenanceDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextMaintenanceDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      nextServiceDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nextServiceDate',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      nextServiceDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nextServiceDate',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> nextServiceDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextServiceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition>
      nextServiceDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextServiceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> nextServiceDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextServiceDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> nextServiceDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextServiceDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> plateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> plateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> plateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> plateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> plateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'plate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> plateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'plate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> plateContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'plate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> plateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'plate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> plateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plate',
        value: '',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> plateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'plate',
        value: '',
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> yearEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'year',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> yearGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'year',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> yearLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'year',
        value: value,
      ));
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterFilterCondition> yearBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'year',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension VehicleQueryObject
    on QueryBuilder<Vehicle, Vehicle, QFilterCondition> {}

extension VehicleQueryLinks
    on QueryBuilder<Vehicle, Vehicle, QFilterCondition> {}

extension VehicleQuerySortBy on QueryBuilder<Vehicle, Vehicle, QSortBy> {
  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByBrand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByBrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByKilometer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilometer', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByKilometerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilometer', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByLastInspectionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastInspectionDate', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByLastInspectionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastInspectionDate', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByLastMaintenanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMaintenanceDate', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByLastMaintenanceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMaintenanceDate', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByLastServiceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastServiceDate', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByLastServiceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastServiceDate', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByNextInspectionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextInspectionDate', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByNextInspectionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextInspectionDate', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByNextMaintenanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextMaintenanceDate', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByNextMaintenanceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextMaintenanceDate', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByNextServiceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextServiceDate', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByNextServiceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextServiceDate', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByPlate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plate', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByPlateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plate', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> sortByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension VehicleQuerySortThenBy
    on QueryBuilder<Vehicle, Vehicle, QSortThenBy> {
  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByBrand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByBrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brand', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByKilometer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilometer', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByKilometerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilometer', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByLastInspectionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastInspectionDate', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByLastInspectionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastInspectionDate', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByLastMaintenanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMaintenanceDate', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByLastMaintenanceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMaintenanceDate', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByLastServiceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastServiceDate', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByLastServiceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastServiceDate', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByNextInspectionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextInspectionDate', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByNextInspectionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextInspectionDate', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByNextMaintenanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextMaintenanceDate', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByNextMaintenanceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextMaintenanceDate', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByNextServiceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextServiceDate', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByNextServiceDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextServiceDate', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByPlate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plate', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByPlateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plate', Sort.desc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.asc);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QAfterSortBy> thenByYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'year', Sort.desc);
    });
  }
}

extension VehicleQueryWhereDistinct
    on QueryBuilder<Vehicle, Vehicle, QDistinct> {
  QueryBuilder<Vehicle, Vehicle, QDistinct> distinctByBrand(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'brand', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QDistinct> distinctByColor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QDistinct> distinctByKilometer() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kilometer');
    });
  }

  QueryBuilder<Vehicle, Vehicle, QDistinct> distinctByLastInspectionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastInspectionDate');
    });
  }

  QueryBuilder<Vehicle, Vehicle, QDistinct> distinctByLastMaintenanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastMaintenanceDate');
    });
  }

  QueryBuilder<Vehicle, Vehicle, QDistinct> distinctByLastServiceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastServiceDate');
    });
  }

  QueryBuilder<Vehicle, Vehicle, QDistinct> distinctByModel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'model', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QDistinct> distinctByNextInspectionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextInspectionDate');
    });
  }

  QueryBuilder<Vehicle, Vehicle, QDistinct> distinctByNextMaintenanceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextMaintenanceDate');
    });
  }

  QueryBuilder<Vehicle, Vehicle, QDistinct> distinctByNextServiceDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextServiceDate');
    });
  }

  QueryBuilder<Vehicle, Vehicle, QDistinct> distinctByPlate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vehicle, Vehicle, QDistinct> distinctByYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'year');
    });
  }
}

extension VehicleQueryProperty
    on QueryBuilder<Vehicle, Vehicle, QQueryProperty> {
  QueryBuilder<Vehicle, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Vehicle, String, QQueryOperations> brandProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'brand');
    });
  }

  QueryBuilder<Vehicle, String?, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<Vehicle, int?, QQueryOperations> kilometerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kilometer');
    });
  }

  QueryBuilder<Vehicle, DateTime?, QQueryOperations>
      lastInspectionDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastInspectionDate');
    });
  }

  QueryBuilder<Vehicle, DateTime?, QQueryOperations>
      lastMaintenanceDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastMaintenanceDate');
    });
  }

  QueryBuilder<Vehicle, DateTime?, QQueryOperations> lastServiceDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastServiceDate');
    });
  }

  QueryBuilder<Vehicle, String, QQueryOperations> modelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'model');
    });
  }

  QueryBuilder<Vehicle, DateTime?, QQueryOperations>
      nextInspectionDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextInspectionDate');
    });
  }

  QueryBuilder<Vehicle, DateTime?, QQueryOperations>
      nextMaintenanceDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextMaintenanceDate');
    });
  }

  QueryBuilder<Vehicle, DateTime?, QQueryOperations> nextServiceDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextServiceDate');
    });
  }

  QueryBuilder<Vehicle, String, QQueryOperations> plateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plate');
    });
  }

  QueryBuilder<Vehicle, int, QQueryOperations> yearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'year');
    });
  }
}
