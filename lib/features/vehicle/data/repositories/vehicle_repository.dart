import 'package:isar/isar.dart';
import 'package:torpido/features/vehicle/domain/models/vehicle_model.dart';

class VehicleRepository {
  final Isar _isar;

  VehicleRepository(this._isar);

  // Araç ekleme
  Future<int> addVehicle(Vehicle vehicle) async {
    return _isar.writeTxn(() async {
      return _isar.vehicles.put(vehicle);
    });
  }

  // Araç güncelleme
  Future<int> updateVehicle(Vehicle vehicle) async {
    return _isar.writeTxn(() async {
      return _isar.vehicles.put(vehicle);
    });
  }

  // Araç silme
  Future<bool> deleteVehicle(int id) async {
    return _isar.writeTxn(() async {
      return _isar.vehicles.delete(id);
    });
  }

  // Tüm araçları getirme
  Future<List<Vehicle>> getAllVehicles() async {
    return _isar.vehicles.where().findAll();
  }

  // ID'ye göre araç getirme
  Future<Vehicle?> getVehicleById(int id) async {
    return _isar.vehicles.get(id);
  }

  // Plakaya göre araç getirme
  Future<Vehicle?> getVehicleByPlate(String plate) async {
    return _isar.vehicles.where()
        .filter()
        .plateEqualTo(plate)
        .findFirst();
  }

  // Markaya göre araçları getirme
  Future<List<Vehicle>> getVehiclesByBrand(String brand) async {
    return _isar.vehicles.where()
        .filter()
        .brandEqualTo(brand)
        .findAll();
  }

  // Bakım tarihi yaklaşan araçları getirme
  Future<List<Vehicle>> getVehiclesWithUpcomingMaintenance() async {
    final now = DateTime.now();
    final thirtyDaysLater = now.add(const Duration(days: 30));
    return _isar.vehicles.where()
        .filter()
        .nextMaintenanceDateBetween(now, thirtyDaysLater)
        .findAll();
  }

  // Muayene tarihi yaklaşan araçları getirme
  Future<List<Vehicle>> getVehiclesWithUpcomingInspection() async {
    final now = DateTime.now();
    final thirtyDaysLater = now.add(const Duration(days: 30));
    return _isar.vehicles.where()
        .filter()
        .nextInspectionDateBetween(now, thirtyDaysLater)
        .findAll();
  }
} 