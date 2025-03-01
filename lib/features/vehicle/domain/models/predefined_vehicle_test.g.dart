// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'predefined_vehicle_test.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPredefinedVehicleTestCollection on Isar {
  IsarCollection<PredefinedVehicleTest> get predefinedVehicleTests =>
      this.collection();
}

const PredefinedVehicleTestSchema = CollectionSchema(
  name: r'PredefinedVehicleTest',
  id: -479868544406895079,
  properties: {
    r'daysInterval': PropertySchema(
      id: 0,
      name: r'daysInterval',
      type: IsarType.long,
    ),
    r'description': PropertySchema(
      id: 1,
      name: r'description',
      type: IsarType.string,
    ),
    r'expectedValues': PropertySchema(
      id: 2,
      name: r'expectedValues',
      type: IsarType.string,
    ),
    r'kilometerInterval': PropertySchema(
      id: 3,
      name: r'kilometerInterval',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'question': PropertySchema(
      id: 5,
      name: r'question',
      type: IsarType.string,
    ),
    r'technicalDetails': PropertySchema(
      id: 6,
      name: r'technicalDetails',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 7,
      name: r'type',
      type: IsarType.byte,
      enumMap: _PredefinedVehicleTesttypeEnumValueMap,
    )
  },
  estimateSize: _predefinedVehicleTestEstimateSize,
  serialize: _predefinedVehicleTestSerialize,
  deserialize: _predefinedVehicleTestDeserialize,
  deserializeProp: _predefinedVehicleTestDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _predefinedVehicleTestGetId,
  getLinks: _predefinedVehicleTestGetLinks,
  attach: _predefinedVehicleTestAttach,
  version: '3.1.0+1',
);

int _predefinedVehicleTestEstimateSize(
  PredefinedVehicleTest object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.expectedValues;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.question.length * 3;
  {
    final value = object.technicalDetails;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _predefinedVehicleTestSerialize(
  PredefinedVehicleTest object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.daysInterval);
  writer.writeString(offsets[1], object.description);
  writer.writeString(offsets[2], object.expectedValues);
  writer.writeLong(offsets[3], object.kilometerInterval);
  writer.writeString(offsets[4], object.name);
  writer.writeString(offsets[5], object.question);
  writer.writeString(offsets[6], object.technicalDetails);
  writer.writeByte(offsets[7], object.type.index);
}

PredefinedVehicleTest _predefinedVehicleTestDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PredefinedVehicleTest(
    daysInterval: reader.readLong(offsets[0]),
    description: reader.readStringOrNull(offsets[1]),
    expectedValues: reader.readStringOrNull(offsets[2]),
    kilometerInterval: reader.readLong(offsets[3]),
    name: reader.readString(offsets[4]),
    question: reader.readString(offsets[5]),
    technicalDetails: reader.readStringOrNull(offsets[6]),
    type: _PredefinedVehicleTesttypeValueEnumMap[
            reader.readByteOrNull(offsets[7])] ??
        TestType.boolean,
  );
  object.id = id;
  return object;
}

P _predefinedVehicleTestDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (_PredefinedVehicleTesttypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          TestType.boolean) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PredefinedVehicleTesttypeEnumValueMap = {
  'boolean': 0,
  'measurement': 1,
};
const _PredefinedVehicleTesttypeValueEnumMap = {
  0: TestType.boolean,
  1: TestType.measurement,
};

Id _predefinedVehicleTestGetId(PredefinedVehicleTest object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _predefinedVehicleTestGetLinks(
    PredefinedVehicleTest object) {
  return [];
}

void _predefinedVehicleTestAttach(
    IsarCollection<dynamic> col, Id id, PredefinedVehicleTest object) {
  object.id = id;
}

extension PredefinedVehicleTestQueryWhereSort
    on QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QWhere> {
  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PredefinedVehicleTestQueryWhere on QueryBuilder<PredefinedVehicleTest,
    PredefinedVehicleTest, QWhereClause> {
  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterWhereClause>
      nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterWhereClause>
      nameNotEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }
}

extension PredefinedVehicleTestQueryFilter on QueryBuilder<
    PredefinedVehicleTest, PredefinedVehicleTest, QFilterCondition> {
  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> daysIntervalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'daysInterval',
        value: value,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> daysIntervalGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'daysInterval',
        value: value,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> daysIntervalLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'daysInterval',
        value: value,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> daysIntervalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'daysInterval',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
          QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
          QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> expectedValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expectedValues',
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> expectedValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expectedValues',
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> expectedValuesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expectedValues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> expectedValuesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expectedValues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> expectedValuesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expectedValues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> expectedValuesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expectedValues',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> expectedValuesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'expectedValues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> expectedValuesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'expectedValues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
          QAfterFilterCondition>
      expectedValuesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'expectedValues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
          QAfterFilterCondition>
      expectedValuesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'expectedValues',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> expectedValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expectedValues',
        value: '',
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> expectedValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'expectedValues',
        value: '',
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> kilometerIntervalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kilometerInterval',
        value: value,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> kilometerIntervalGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kilometerInterval',
        value: value,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> kilometerIntervalLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kilometerInterval',
        value: value,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> kilometerIntervalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kilometerInterval',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
          QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
          QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> questionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> questionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> questionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> questionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'question',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> questionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> questionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
          QAfterFilterCondition>
      questionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
          QAfterFilterCondition>
      questionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'question',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> questionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'question',
        value: '',
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> questionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'question',
        value: '',
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> technicalDetailsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'technicalDetails',
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> technicalDetailsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'technicalDetails',
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> technicalDetailsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'technicalDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> technicalDetailsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'technicalDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> technicalDetailsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'technicalDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> technicalDetailsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'technicalDetails',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> technicalDetailsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'technicalDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> technicalDetailsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'technicalDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
          QAfterFilterCondition>
      technicalDetailsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'technicalDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
          QAfterFilterCondition>
      technicalDetailsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'technicalDetails',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> technicalDetailsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'technicalDetails',
        value: '',
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> technicalDetailsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'technicalDetails',
        value: '',
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> typeEqualTo(TestType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> typeGreaterThan(
    TestType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> typeLessThan(
    TestType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest,
      QAfterFilterCondition> typeBetween(
    TestType lower,
    TestType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PredefinedVehicleTestQueryObject on QueryBuilder<
    PredefinedVehicleTest, PredefinedVehicleTest, QFilterCondition> {}

extension PredefinedVehicleTestQueryLinks on QueryBuilder<PredefinedVehicleTest,
    PredefinedVehicleTest, QFilterCondition> {}

extension PredefinedVehicleTestQuerySortBy
    on QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QSortBy> {
  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      sortByDaysInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysInterval', Sort.asc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      sortByDaysIntervalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysInterval', Sort.desc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      sortByExpectedValues() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedValues', Sort.asc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      sortByExpectedValuesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedValues', Sort.desc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      sortByKilometerInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilometerInterval', Sort.asc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      sortByKilometerIntervalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilometerInterval', Sort.desc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      sortByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      sortByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      sortByTechnicalDetails() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicalDetails', Sort.asc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      sortByTechnicalDetailsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicalDetails', Sort.desc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension PredefinedVehicleTestQuerySortThenBy
    on QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QSortThenBy> {
  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      thenByDaysInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysInterval', Sort.asc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      thenByDaysIntervalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysInterval', Sort.desc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      thenByExpectedValues() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedValues', Sort.asc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      thenByExpectedValuesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedValues', Sort.desc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      thenByKilometerInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilometerInterval', Sort.asc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      thenByKilometerIntervalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kilometerInterval', Sort.desc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      thenByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      thenByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      thenByTechnicalDetails() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicalDetails', Sort.asc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      thenByTechnicalDetailsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicalDetails', Sort.desc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension PredefinedVehicleTestQueryWhereDistinct
    on QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QDistinct> {
  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QDistinct>
      distinctByDaysInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'daysInterval');
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QDistinct>
      distinctByExpectedValues({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expectedValues',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QDistinct>
      distinctByKilometerInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kilometerInterval');
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QDistinct>
      distinctByQuestion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'question', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QDistinct>
      distinctByTechnicalDetails({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'technicalDetails',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PredefinedVehicleTest, PredefinedVehicleTest, QDistinct>
      distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }
}

extension PredefinedVehicleTestQueryProperty on QueryBuilder<
    PredefinedVehicleTest, PredefinedVehicleTest, QQueryProperty> {
  QueryBuilder<PredefinedVehicleTest, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PredefinedVehicleTest, int, QQueryOperations>
      daysIntervalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'daysInterval');
    });
  }

  QueryBuilder<PredefinedVehicleTest, String?, QQueryOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<PredefinedVehicleTest, String?, QQueryOperations>
      expectedValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expectedValues');
    });
  }

  QueryBuilder<PredefinedVehicleTest, int, QQueryOperations>
      kilometerIntervalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kilometerInterval');
    });
  }

  QueryBuilder<PredefinedVehicleTest, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<PredefinedVehicleTest, String, QQueryOperations>
      questionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'question');
    });
  }

  QueryBuilder<PredefinedVehicleTest, String?, QQueryOperations>
      technicalDetailsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'technicalDetails');
    });
  }

  QueryBuilder<PredefinedVehicleTest, TestType, QQueryOperations>
      typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
