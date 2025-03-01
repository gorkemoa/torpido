import 'package:isar/isar.dart';

part 'vehicle_insight_model.g.dart';

@collection
class VehicleInsight {
  Id id = Isar.autoIncrement;
  
  @Index()
  final int vehicleId;
  
  final String content;
  final DateTime createdAt;
  final String vehicleBrand;
  final String vehicleModel;
  final String vehiclePlate;

  VehicleInsight({
    required this.vehicleId,
    required this.content,
    required this.createdAt,
    required this.vehicleBrand,
    required this.vehicleModel,
    required this.vehiclePlate,
  });
} 