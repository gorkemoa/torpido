import 'package:isar/isar.dart';
import 'package:torpido/features/inspection/domain/models/inspection_model.dart';

class InspectionRepository {
  final Isar _isar;

  InspectionRepository(this._isar);

  // Muayene ekleme
  Future<int> addInspection(Inspection inspection) async {
    return _isar.writeTxn(() async {
      return _isar.inspections.put(inspection);
    });
  }

  // Muayene güncelleme
  Future<int> updateInspection(Inspection inspection) async {
    return _isar.writeTxn(() async {
      return _isar.inspections.put(inspection);
    });
  }

  // Muayene silme
  Future<bool> deleteInspection(int id) async {
    return _isar.writeTxn(() async {
      return _isar.inspections.delete(id);
    });
  }

  // Tüm muayeneleri getirme
  Future<List<Inspection>> getAllInspections() async {
    return _isar.inspections.where().findAll();
  }

  // ID'ye göre muayene getirme
  Future<Inspection?> getInspectionById(int id) async {
    return _isar.inspections.get(id);
  }

  // Araca göre muayeneleri getirme
  Future<List<Inspection>> getInspectionsByVehicle(int vehicleId) async {
    return _isar.inspections.where()
        .filter()
        .vehicleIdEqualTo(vehicleId.toString())
        .findAll();
  }

  // Tarih aralığına göre muayeneleri getirme
  Future<List<Inspection>> getInspectionsByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    return _isar.inspections.where()
        .filter()
        .dateBetween(start, end)
        .findAll();
  }

  // Geçerlilik süresi dolmak üzere olan muayeneleri getirme
  Future<List<Inspection>> getUpcomingExpiryInspections() async {
    final now = DateTime.now();
    final thirtyDaysLater = now.add(const Duration(days: 30));
    return _isar.inspections.where()
        .filter()
        .expiryDateBetween(now, thirtyDaysLater)
        .findAll();
  }

  // Geçerlilik süresi dolmuş muayeneleri getirme
  Future<List<Inspection>> getExpiredInspections() async {
    final now = DateTime.now();
    return _isar.inspections.where()
        .filter()
        .expiryDateLessThan(now)
        .findAll();
  }

  // Başarısız muayeneleri getirme
  Future<List<Inspection>> getFailedInspections() async {
    return _isar.inspections.where()
        .filter()
        .isPassedEqualTo(false)
        .findAll();
  }
} 