import 'package:isar/isar.dart';

part 'test_result.g.dart';

@collection
class TestResult {
  Id id = Isar.autoIncrement;

  @Index()
  String? vehicleId;

  @Index()
  String? name;
  
  @Index()
  String? type;
  
  String? measurementValue;
  String? notes;
  bool? isPassed;
  
  @Index()
  DateTime? date;

  TestResult({
    this.vehicleId,
    this.name,
    this.type,
    this.measurementValue,
    this.notes,
    this.isPassed,
    this.date,
  });
} 