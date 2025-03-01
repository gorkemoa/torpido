import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:torpido/features/maintenance/domain/models/maintenance_model.dart';
import 'package:torpido/features/inspection/domain/models/inspection_model.dart';
import 'package:torpido/features/vehicle/domain/models/vehicle_model.dart';
import 'package:torpido/features/vehicle/domain/models/vehicle_insight_model.dart';
import 'package:torpido/features/vehicle/domain/models/test_result.dart';
import 'package:torpido/features/vehicle/domain/models/predefined_vehicle_test.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      
      if (Isar.instanceNames.isEmpty) {
        return await Isar.open(
          [
            VehicleSchema,
            MaintenanceSchema,
            InspectionSchema,
            VehicleInsightSchema,
            TestResultSchema,
            PredefinedVehicleTestSchema,
          ],
          directory: dir.path,
          inspector: true,
        );
      }

      return Future.value(Isar.getInstance());
    } catch (e) {
      // Eğer dizin oluşturulamazsa, geçici dizini kullan
      final dir = await getTemporaryDirectory();
      
      if (Isar.instanceNames.isEmpty) {
        return await Isar.open(
          [
            VehicleSchema,
            MaintenanceSchema,
            InspectionSchema,
            VehicleInsightSchema,
            TestResultSchema,
            PredefinedVehicleTestSchema,
          ],
          directory: dir.path,
          inspector: true,
        );
      }

      return Future.value(Isar.getInstance());
    }
  }
} 