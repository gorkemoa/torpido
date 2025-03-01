// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_insight_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVehicleInsightCollection on Isar {
  IsarCollection<VehicleInsight> get vehicleInsights => this.collection();
}

const VehicleInsightSchema = CollectionSchema(
  name: r'VehicleInsight',
  id: 1722995038831662651,
  properties: {
    r'content': PropertySchema(
      id: 0,
      name: r'content',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'vehicleBrand': PropertySchema(
      id: 2,
      name: r'vehicleBrand',
      type: IsarType.string,
    ),
    r'vehicleId': PropertySchema(
      id: 3,
      name: r'vehicleId',
      type: IsarType.long,
    ),
    r'vehicleModel': PropertySchema(
      id: 4,
      name: r'vehicleModel',
      type: IsarType.string,
    ),
    r'vehiclePlate': PropertySchema(
      id: 5,
      name: r'vehiclePlate',
      type: IsarType.string,
    )
  },
  estimateSize: _vehicleInsightEstimateSize,
  serialize: _vehicleInsightSerialize,
  deserialize: _vehicleInsightDeserialize,
  deserializeProp: _vehicleInsightDeserializeProp,
  idName: r'id',
  indexes: {
    r'vehicleId': IndexSchema(
      id: 2011968157433523416,
      name: r'vehicleId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'vehicleId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _vehicleInsightGetId,
  getLinks: _vehicleInsightGetLinks,
  attach: _vehicleInsightAttach,
  version: '3.1.0+1',
);

int _vehicleInsightEstimateSize(
  VehicleInsight object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.content.length * 3;
  bytesCount += 3 + object.vehicleBrand.length * 3;
  bytesCount += 3 + object.vehicleModel.length * 3;
  bytesCount += 3 + object.vehiclePlate.length * 3;
  return bytesCount;
}

void _vehicleInsightSerialize(
  VehicleInsight object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.content);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.vehicleBrand);
  writer.writeLong(offsets[3], object.vehicleId);
  writer.writeString(offsets[4], object.vehicleModel);
  writer.writeString(offsets[5], object.vehiclePlate);
}

VehicleInsight _vehicleInsightDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VehicleInsight(
    content: reader.readString(offsets[0]),
    createdAt: reader.readDateTime(offsets[1]),
    vehicleBrand: reader.readString(offsets[2]),
    vehicleId: reader.readLong(offsets[3]),
    vehicleModel: reader.readString(offsets[4]),
    vehiclePlate: reader.readString(offsets[5]),
  );
  object.id = id;
  return object;
}

P _vehicleInsightDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _vehicleInsightGetId(VehicleInsight object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _vehicleInsightGetLinks(VehicleInsight object) {
  return [];
}

void _vehicleInsightAttach(
    IsarCollection<dynamic> col, Id id, VehicleInsight object) {
  object.id = id;
}

extension VehicleInsightQueryWhereSort
    on QueryBuilder<VehicleInsight, VehicleInsight, QWhere> {
  QueryBuilder<VehicleInsight, VehicleInsight, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterWhere> anyVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'vehicleId'),
      );
    });
  }
}

extension VehicleInsightQueryWhere
    on QueryBuilder<VehicleInsight, VehicleInsight, QWhereClause> {
  QueryBuilder<VehicleInsight, VehicleInsight, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterWhereClause> idBetween(
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

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterWhereClause>
      vehicleIdEqualTo(int vehicleId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'vehicleId',
        value: [vehicleId],
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterWhereClause>
      vehicleIdNotEqualTo(int vehicleId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'vehicleId',
              lower: [],
              upper: [vehicleId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'vehicleId',
              lower: [vehicleId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'vehicleId',
              lower: [vehicleId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'vehicleId',
              lower: [],
              upper: [vehicleId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterWhereClause>
      vehicleIdGreaterThan(
    int vehicleId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'vehicleId',
        lower: [vehicleId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterWhereClause>
      vehicleIdLessThan(
    int vehicleId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'vehicleId',
        lower: [],
        upper: [vehicleId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterWhereClause>
      vehicleIdBetween(
    int lowerVehicleId,
    int upperVehicleId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'vehicleId',
        lower: [lowerVehicleId],
        includeLower: includeLower,
        upper: [upperVehicleId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension VehicleInsightQueryFilter
    on QueryBuilder<VehicleInsight, VehicleInsight, QFilterCondition> {
  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      contentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      contentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      contentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      contentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'content',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      contentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      contentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'content',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition> idBetween(
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

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleBrandEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleBrand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleBrandGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vehicleBrand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleBrandLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vehicleBrand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleBrandBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vehicleBrand',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleBrandStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vehicleBrand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleBrandEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vehicleBrand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleBrandContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vehicleBrand',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleBrandMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vehicleBrand',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleBrandIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleBrand',
        value: '',
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleBrandIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vehicleBrand',
        value: '',
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleId',
        value: value,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vehicleId',
        value: value,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vehicleId',
        value: value,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vehicleId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleModelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleModel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleModelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vehicleModel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleModelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vehicleModel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleModelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vehicleModel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleModelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vehicleModel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleModelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vehicleModel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleModelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vehicleModel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleModelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vehicleModel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleModelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleModel',
        value: '',
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehicleModelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vehicleModel',
        value: '',
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehiclePlateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehiclePlate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehiclePlateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vehiclePlate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehiclePlateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vehiclePlate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehiclePlateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vehiclePlate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehiclePlateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vehiclePlate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehiclePlateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vehiclePlate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehiclePlateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vehiclePlate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehiclePlateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vehiclePlate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehiclePlateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehiclePlate',
        value: '',
      ));
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterFilterCondition>
      vehiclePlateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vehiclePlate',
        value: '',
      ));
    });
  }
}

extension VehicleInsightQueryObject
    on QueryBuilder<VehicleInsight, VehicleInsight, QFilterCondition> {}

extension VehicleInsightQueryLinks
    on QueryBuilder<VehicleInsight, VehicleInsight, QFilterCondition> {}

extension VehicleInsightQuerySortBy
    on QueryBuilder<VehicleInsight, VehicleInsight, QSortBy> {
  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy> sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy>
      sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy>
      sortByVehicleBrand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleBrand', Sort.asc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy>
      sortByVehicleBrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleBrand', Sort.desc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy> sortByVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.asc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy>
      sortByVehicleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.desc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy>
      sortByVehicleModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleModel', Sort.asc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy>
      sortByVehicleModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleModel', Sort.desc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy>
      sortByVehiclePlate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehiclePlate', Sort.asc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy>
      sortByVehiclePlateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehiclePlate', Sort.desc);
    });
  }
}

extension VehicleInsightQuerySortThenBy
    on QueryBuilder<VehicleInsight, VehicleInsight, QSortThenBy> {
  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy> thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy>
      thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy>
      thenByVehicleBrand() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleBrand', Sort.asc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy>
      thenByVehicleBrandDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleBrand', Sort.desc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy> thenByVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.asc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy>
      thenByVehicleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.desc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy>
      thenByVehicleModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleModel', Sort.asc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy>
      thenByVehicleModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleModel', Sort.desc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy>
      thenByVehiclePlate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehiclePlate', Sort.asc);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QAfterSortBy>
      thenByVehiclePlateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehiclePlate', Sort.desc);
    });
  }
}

extension VehicleInsightQueryWhereDistinct
    on QueryBuilder<VehicleInsight, VehicleInsight, QDistinct> {
  QueryBuilder<VehicleInsight, VehicleInsight, QDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QDistinct>
      distinctByVehicleBrand({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicleBrand', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QDistinct>
      distinctByVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicleId');
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QDistinct>
      distinctByVehicleModel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicleModel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VehicleInsight, VehicleInsight, QDistinct>
      distinctByVehiclePlate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehiclePlate', caseSensitive: caseSensitive);
    });
  }
}

extension VehicleInsightQueryProperty
    on QueryBuilder<VehicleInsight, VehicleInsight, QQueryProperty> {
  QueryBuilder<VehicleInsight, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<VehicleInsight, String, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<VehicleInsight, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<VehicleInsight, String, QQueryOperations>
      vehicleBrandProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicleBrand');
    });
  }

  QueryBuilder<VehicleInsight, int, QQueryOperations> vehicleIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicleId');
    });
  }

  QueryBuilder<VehicleInsight, String, QQueryOperations>
      vehicleModelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicleModel');
    });
  }

  QueryBuilder<VehicleInsight, String, QQueryOperations>
      vehiclePlateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehiclePlate');
    });
  }
}
