import 'package:isar/isar.dart';
import 'package:torpido/features/maintenance/domain/models/maintenance_model.dart';
import 'package:torpido/features/vehicle/domain/models/vehicle_model.dart';

class MaintenanceRepository {
  final Isar _isar;

  MaintenanceRepository(this._isar);

  // Bakım ekleme
  Future<int> addMaintenance(Maintenance maintenance) async {
    return _isar.writeTxn(() async {
      return _isar.maintenances.put(maintenance);
    });
  }

  // Bakım güncelleme
  Future<int> updateMaintenance(Maintenance maintenance) async {
    return _isar.writeTxn(() async {
      return _isar.maintenances.put(maintenance);
    });
  }

  // Bakım silme
  Future<bool> deleteMaintenance(int id) async {
    return _isar.writeTxn(() async {
      return _isar.maintenances.delete(id);
    });
  }

  // Tüm bakımları getirme
  Future<List<Maintenance>> getAllMaintenances() async {
    final maintenances = await _isar.maintenances.where().sortByDate().findAll();
    final vehicles = await _isar.vehicles.where().findAll();

    return maintenances.map((maintenance) {
      final vehicle = vehicles.firstWhere(
        (v) => v.id == maintenance.vehicleId,
        orElse: () => Vehicle(
          brand: 'Bilinmiyor',
          model: 'Bilinmiyor',
          plate: 'Bilinmiyor',
          year: 0,
        ),
      );
      return maintenance.copyWith(vehicle: vehicle);
    }).toList();
  }

  // ID'ye göre bakım getirme
  Future<Maintenance?> getMaintenanceById(int id) async {
    return _isar.maintenances.get(id);
  }

  // Araca göre bakımları getirme
  Future<List<Maintenance>> getMaintenancesByVehicle(int vehicleId) async {
    return _isar.maintenances.where()
        .filter()
        .vehicleIdEqualTo(vehicleId)
        .findAll();
  }

  // Tarih aralığına göre bakımları getirme
  Future<List<Maintenance>> getMaintenancesByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    return _isar.maintenances.where()
        .filter()
        .dateBetween(start, end)
        .findAll();
  }

  // Kilometre aralığına göre bakımları getirme
  Future<List<Maintenance>> getMaintenancesByKilometerRange(
    int start,
    int end,
  ) async {
    return _isar.maintenances.where()
        .filter()
        .kilometerBetween(start, end)
        .findAll();
  }

  // Maliyete göre bakımları getirme (en yüksek maliyetli)
  Future<List<Maintenance>> getMaintenancesByHighestCost({int limit = 10}) async {
    final maintenances = await _isar.maintenances.where().findAll();
    maintenances.sort((a, b) => b.cost.compareTo(a.cost));
    return maintenances.take(limit).toList();
  }
} 