import 'package:isar/isar.dart';

part 'vehicle_model.g.dart';

@Collection()
class Vehicle {
  Vehicle({
    this.id = Isar.autoIncrement,
    required this.brand,
    required this.model,
    required this.plate,
    required this.year,
    this.color,
    this.kilometer,
    this.lastMaintenanceDate,
    this.nextMaintenanceDate,
    this.lastInspectionDate,
    this.nextInspectionDate,
    this.nextServiceDate,
    this.lastServiceDate,
  });

  Id id;
  
  @Index(type: IndexType.value)
  final String brand;
  
  final String model;
  
  @Index(type: IndexType.value, unique: true, replace: true)
  final String plate;
  
  final int year;
  final String? color;
  final int? kilometer;
  final DateTime? lastMaintenanceDate;
  final DateTime? nextMaintenanceDate;
  final DateTime? lastInspectionDate;
  final DateTime? nextInspectionDate;
  final DateTime? nextServiceDate;
  final DateTime? lastServiceDate;

  Vehicle copyWith({
    Id? id,
    String? brand,
    String? model,
    String? plate,
    int? year,
    String? color,
    int? kilometer,
    DateTime? lastMaintenanceDate,
    DateTime? nextMaintenanceDate,
    DateTime? lastInspectionDate,
    DateTime? nextInspectionDate,
    DateTime? nextServiceDate,
    DateTime? lastServiceDate,
  }) {
    return Vehicle(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      plate: plate ?? this.plate,
      year: year ?? this.year,
      color: color ?? this.color,
      kilometer: kilometer ?? this.kilometer,
      lastMaintenanceDate: lastMaintenanceDate ?? this.lastMaintenanceDate,
      nextMaintenanceDate: nextMaintenanceDate ?? this.nextMaintenanceDate,
      lastInspectionDate: lastInspectionDate ?? this.lastInspectionDate,
      nextInspectionDate: nextInspectionDate ?? this.nextInspectionDate,
      nextServiceDate: nextServiceDate ?? this.nextServiceDate,
      lastServiceDate: lastServiceDate ?? this.lastServiceDate,
    );
  }
} 