import 'package:isar/isar.dart';
import 'package:torpido/features/vehicle/domain/models/vehicle_model.dart';

part 'inspection_model.g.dart';

@Collection()
class Inspection {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  final String vehicleId;

  final String type;
  final double cost;

  @Index(type: IndexType.value)
  final DateTime date;

  final String notes;

  @Index(type: IndexType.value)
  final DateTime expiryDate;

  final int? kilometer;
  final bool isPassed;

  @ignore
  final Vehicle? vehicle;

  Inspection({
    required this.vehicleId,
    required this.type,
    required this.cost,
    required this.date,
    required this.notes,
    required this.expiryDate,
    this.kilometer,
    this.isPassed = true,
    this.vehicle,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicleId': vehicleId,
      'type': type,
      'cost': cost,
      'date': date.toIso8601String(),
      'notes': notes,
      'expiryDate': expiryDate.toIso8601String(),
      'kilometer': kilometer,
      'isPassed': isPassed,
    };
  }

  factory Inspection.fromJson(Map<String, dynamic> json) {
    return Inspection(
      vehicleId: json['vehicleId'] as String,
      type: json['type'] as String,
      cost: json['cost'] as double,
      date: DateTime.parse(json['date'] as String),
      notes: json['notes'] as String,
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      kilometer: json['kilometer'] as int?,
      isPassed: json['isPassed'] as bool? ?? true,
    );
  }

  Inspection copyWith({
    String? vehicleId,
    String? type,
    double? cost,
    DateTime? date,
    String? notes,
    DateTime? expiryDate,
    int? kilometer,
    bool? isPassed,
    Vehicle? vehicle,
  }) {
    return Inspection(
      vehicleId: vehicleId ?? this.vehicleId,
      type: type ?? this.type,
      cost: cost ?? this.cost,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      expiryDate: expiryDate ?? this.expiryDate,
      kilometer: kilometer ?? this.kilometer,
      isPassed: isPassed ?? this.isPassed,
      vehicle: vehicle ?? this.vehicle,
    );
  }
} 