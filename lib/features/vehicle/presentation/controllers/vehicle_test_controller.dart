import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torpido/features/vehicle/domain/models/predefined_vehicle_test.dart';
import 'package:torpido/features/vehicle/domain/models/test_result.dart';
import 'package:torpido/core/providers/repository_providers.dart';

final vehicleTestControllerProvider = Provider<VehicleTestController>((ref) {
  return VehicleTestController(ref);
});

class VehicleTestController {
  final Ref _ref;

  VehicleTestController(this._ref);

  List<PredefinedVehicleTest> getPredefinedTests() {
    return PredefinedVehicleTest.getDefaultTests();
  }

  Map<String, List<PredefinedVehicleTest>> getTestsByCategory(List<PredefinedVehicleTest> tests) {
    final categories = {
      'Motor ve Performans': tests.where((test) => test.name.contains('Motor')).toList(),
      'Frenler': tests.where((test) => test.name.contains('Fren')).toList(),
      'Lastikler': tests.where((test) => test.name.contains('Lastik')).toList(),
      'Direksiyon': tests.where((test) => test.name.contains('Direksiyon')).toList(),
      'Genel Durum': tests.where((test) => 
        !test.name.contains('Motor') && 
        !test.name.contains('Fren') && 
        !test.name.contains('Lastik') && 
        !test.name.contains('Direksiyon')
      ).toList(),
    };
    return categories;
  }

  Future<void> submitTests(String vehicleId, List<TestResult> tests) async {
    final repository = await _ref.read(vehicleTestRepositoryProvider.future);
    await repository.addTestResults(vehicleId, tests);
  }

  Future<List<TestResult>> getTestResults(String vehicleId) async {
    final repository = await _ref.read(vehicleTestRepositoryProvider.future);
    return repository.getTestsByVehicleId(vehicleId);
  }

  Future<void> deleteTestResult(String vehicleId, int testId) async {
    final repository = await _ref.read(vehicleTestRepositoryProvider.future);
    await repository.deleteTestResult(testId);
  }

  Future<void> updateTestResult(TestResult test) async {
    final repository = await _ref.read(vehicleTestRepositoryProvider.future);
    await repository.updateTestResult(test);
  }
} 
