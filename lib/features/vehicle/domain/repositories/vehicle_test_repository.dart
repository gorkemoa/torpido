import 'package:isar/isar.dart';
import 'package:torpido/features/vehicle/domain/models/test_result.dart';

abstract class VehicleTestRepository {
  @ignore
  final Isar isar;

  VehicleTestRepository(this.isar);

  Future<void> addTestResults(String vehicleId, List<TestResult> tests);
  Future<void> addTestResult(TestResult result);
  Future<List<TestResult>> getTestsByVehicleId(String vehicleId);
  Future<List<TestResult>> getTestResults(String vehicleId);
  Future<void> deleteTestResult(int testId);
  Future<void> updateTestResult(TestResult test);
  Future<List<TestResult>> getAllTestResults();
  Future<List<TestResult>> getLatestTestResults(String vehicleId, {int limit = 10});
  Future<String> compareTestResults(String vehicleId);
  Future<void> saveTestResults(String vehicleId, List<TestResult> results);
} 