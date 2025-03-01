import 'package:isar/isar.dart';
import 'package:torpido/features/vehicle/domain/models/vehicle_insight_model.dart';

class VehicleInsightRepository {
  final Isar isar;

  VehicleInsightRepository(this.isar);

  Future<void> addInsight(VehicleInsight insight) async {
    await isar.writeTxn(() async {
      await isar.vehicleInsights.put(insight);
    });
  }

  Future<List<VehicleInsight>> getInsightsByVehicleId(int vehicleId) async {
    return await isar.vehicleInsights
        .where()
        .vehicleIdEqualTo(vehicleId)
        .sortByCreatedAtDesc()
        .findAll();
  }

  Future<List<VehicleInsight>> getAllInsights() async {
    return await isar.vehicleInsights
        .where()
        .sortByCreatedAtDesc()
        .findAll();
  }

  Future<void> deleteInsight(int id) async {
    await isar.writeTxn(() async {
      await isar.vehicleInsights.delete(id);
    });
  }
} 