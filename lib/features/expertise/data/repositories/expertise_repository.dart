import 'package:isar/isar.dart';
import 'package:torpido/features/expertise/domain/models/expertise_model.dart';

class ExpertiseRepository {
  final Isar _isar;

  ExpertiseRepository(this._isar);

  // Expertiz ekleme
  Future<int> addExpertise(Expertise expertise) async {
    return _isar.writeTxn(() async {
      return _isar.expertises.put(expertise);
    });
  }

  // Expertiz güncelleme
  Future<int> updateExpertise(Expertise expertise) async {
    return _isar.writeTxn(() async {
      return _isar.expertises.put(expertise);
    });
  }

  // Expertiz silme
  Future<bool> deleteExpertise(int id) async {
    return _isar.writeTxn(() async {
      return _isar.expertises.delete(id);
    });
  }

  // Tüm expertizleri getirme
  Future<List<Expertise>> getAllExpertises() async {
    return _isar.expertises.where().findAll();
  }

  // ID'ye göre expertiz getirme
  Future<Expertise?> getExpertiseById(int id) async {
    return _isar.expertises.get(id);
  }

  // Araca göre expertizleri getirme
  Future<List<Expertise>> getExpertisesByVehicle(int vehicleId) async {
    return _isar.expertises.where()
        .filter()
        .vehicleIdEqualTo(vehicleId)
        .findAll();
  }

  // Tarih aralığına göre expertizleri getirme
  Future<List<Expertise>> getExpertisesByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    return _isar.expertises.where()
        .filter()
        .dateBetween(start, end)
        .findAll();
  }

  // Merkeze göre expertizleri getirme
  Future<List<Expertise>> getExpertisesByCenter(String center) async {
    return _isar.expertises.where()
        .filter()
        .centerEqualTo(center)
        .findAll();
  }

  // Maliyete göre expertizleri getirme (en yüksek maliyetli)
 
} 