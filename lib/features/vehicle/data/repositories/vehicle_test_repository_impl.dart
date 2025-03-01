import 'package:isar/isar.dart';
import 'package:torpido/features/vehicle/domain/models/test_result.dart';
import 'package:torpido/features/vehicle/domain/repositories/vehicle_test_repository.dart';

class VehicleTestRepositoryImpl implements VehicleTestRepository {
  @override
  final Isar isar;

  VehicleTestRepositoryImpl(this.isar);

  @override
  Future<void> addTestResults(String vehicleId, List<TestResult> tests) async {
    await isar.writeTxn(() async {
      for (var test in tests) {
        test.vehicleId = vehicleId;
        test.date = DateTime.now();
        await isar.testResults.put(test);
      }
    });
  }

  @override
  Future<void> addTestResult(TestResult result) async {
    await isar.writeTxn(() async {
      await isar.testResults.put(result);
    });
  }

  @override
  Future<List<TestResult>> getTestsByVehicleId(String vehicleId) async {
    return isar.testResults
        .where()
        .vehicleIdEqualTo(vehicleId)
        .sortByDateDesc()
        .findAll();
  }

  @override
  Future<List<TestResult>> getTestResults(String vehicleId) async {
    return isar.testResults
        .where()
        .vehicleIdEqualTo(vehicleId)
        .sortByDateDesc()
        .findAll();
  }

  @override
  Future<void> deleteTestResult(int testId) async {
    await isar.writeTxn(() async {
      await isar.testResults.delete(testId);
    });
  }

  @override
  Future<void> updateTestResult(TestResult test) async {
    await isar.writeTxn(() async {
      await isar.testResults.put(test);
    });
  }

  @override
  Future<List<TestResult>> getAllTestResults() async {
    return isar.testResults.where().sortByDateDesc().findAll();
  }

  @override
  Future<List<TestResult>> getLatestTestResults(String vehicleId, {int limit = 10}) async {
    return isar.testResults
        .where()
        .vehicleIdEqualTo(vehicleId)
        .sortByDateDesc()
        .limit(limit)
        .findAll();
  }

  @override
  Future<void> saveTestResults(String vehicleId, List<TestResult> results) async {
    await isar.writeTxn(() async {
      for (var result in results) {
        result.vehicleId = vehicleId;
        result.date = DateTime.now();
        await isar.testResults.put(result);
      }
    });
  }

  @override
  Future<String> compareTestResults(String vehicleId) async {
    final latestTests = await getLatestTestResults(vehicleId);
    if (latestTests.isEmpty) return 'Henüz test sonucu bulunmuyor.';

    final previousTests = await getTestsByVehicleId(vehicleId);
    if (previousTests.length <= latestTests.length) {
      return 'Karşılaştırma için yeterli test sonucu bulunmuyor.';
    }

    final comparison = StringBuffer();
    comparison.writeln('Test Sonuçları Karşılaştırması:');
    comparison.writeln('--------------------------------');

    for (var i = 0; i < latestTests.length; i++) {
      final latest = latestTests[i];
      final previous = previousTests.firstWhere(
        (test) => test.name == latest.name && test.date != null && latest.date != null && test.date!.isBefore(latest.date!),
        orElse: () => latest,
      );

      if (latest.isPassed != null && previous.isPassed != null && latest.isPassed != previous.isPassed) {
        comparison.writeln('${latest.name}:');
        comparison.writeln('  Önceki: ${previous.isPassed! ? 'Sorun Yok' : 'Sorun Var'}');
        comparison.writeln('  Şimdi: ${latest.isPassed! ? 'Sorun Yok' : 'Sorun Var'}');
        if (latest.notes != null) {
          comparison.writeln('  Not: ${latest.notes}');
        }
        comparison.writeln('');
      }
    }

    return comparison.toString();
  }
} 