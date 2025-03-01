import 'package:isar/isar.dart';
import 'package:torpido/features/vehicle/domain/models/vehicle_model.dart';

part 'maintenance_model.g.dart';

@collection
class Maintenance {
  Id? id;
  
  final int vehicleId;
  final double cost;
  final String description;
  final DateTime date;
  final int kilometer;
  final DateTime? nextServiceDate;
  
  @ignore
  final Vehicle? vehicle;

  Maintenance({
    this.id,
    required this.vehicleId,
    required this.cost,
    required this.description,
    required this.date,
    required this.kilometer,
    this.nextServiceDate,
    this.vehicle,
  });

  Maintenance copyWith({
    Id? id,
    int? vehicleId,
    double? cost,
    String? description,
    DateTime? date,
    int? kilometer,
    DateTime? nextServiceDate,
    Vehicle? vehicle,
  }) {
    return Maintenance(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      cost: cost ?? this.cost,
      description: description ?? this.description,
      date: date ?? this.date,
      kilometer: kilometer ?? this.kilometer,
      nextServiceDate: nextServiceDate ?? this.nextServiceDate,
      vehicle: vehicle ?? this.vehicle,
    );
  }
} 