import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torpido/core/services/isar_service.dart';
import 'package:torpido/features/inspection/data/repositories/inspection_repository.dart';
import 'package:torpido/features/maintenance/data/repositories/maintenance_repository.dart';
import 'package:torpido/features/vehicle/data/repositories/vehicle_repository.dart';
import 'package:torpido/features/expertise/data/repositories/expertise_repository.dart';
import 'package:torpido/features/vehicle/data/repositories/vehicle_insight_repository.dart';
import 'package:torpido/features/vehicle/domain/repositories/vehicle_test_repository.dart';
import 'package:torpido/features/vehicle/data/repositories/vehicle_test_repository_impl.dart';

final isarServiceProvider = Provider<IsarService>((ref) => IsarService());

final vehicleRepositoryProvider = FutureProvider<VehicleRepository>((ref) async {
  final isar = await ref.watch(isarServiceProvider).db;
  return VehicleRepository(isar);
});

final maintenanceRepositoryProvider = FutureProvider<MaintenanceRepository>((ref) async {
  final isar = await ref.watch(isarServiceProvider).db;
  return MaintenanceRepository(isar);
});

final inspectionRepositoryProvider = FutureProvider<InspectionRepository>((ref) async {
  final isar = await ref.watch(isarServiceProvider).db;
  return InspectionRepository(isar);
});

final expertiseRepositoryProvider = FutureProvider<ExpertiseRepository>((ref) async {
  final isar = await ref.watch(isarServiceProvider).db;
  return ExpertiseRepository(isar);
});

final vehicleInsightRepositoryProvider = FutureProvider<VehicleInsightRepository>((ref) async {
  final isar = await ref.watch(isarServiceProvider).db;
  return VehicleInsightRepository(isar);
});

final vehicleTestRepositoryProvider = FutureProvider<VehicleTestRepository>((ref) async {
  final isar = await ref.watch(isarServiceProvider).db;
  return VehicleTestRepositoryImpl(isar);
}); 