import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torpido/core/providers/repository_providers.dart';
import 'package:torpido/features/maintenance/domain/models/maintenance_model.dart';
import 'package:torpido/features/vehicle/domain/models/vehicle_model.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehiclesAsync = ref.watch(vehicleRepositoryProvider);
    final maintenancesAsync = ref.watch(maintenanceRepositoryProvider);

    return vehiclesAsync.when(
      data: (vehicleRepository) => maintenancesAsync.when(
        data: (maintenanceRepository) => FutureBuilder<List<dynamic>>(
          future: Future.wait([
            vehicleRepository.getAllVehicles(),
            maintenanceRepository.getAllMaintenances(),
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Hata: ${snapshot.error}'));
            }

            final vehicles = snapshot.data?[0] as List<Vehicle>? ?? [];
            final maintenances = snapshot.data?[1] as List<Maintenance>? ?? [];

            if (vehicles.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.assignment_outlined,
                      size: 64,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Henüz araç eklenmemiş',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Rapor görüntülemek için önce araç ekleyin',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }

            final totalCost = maintenances.fold<double>(
              0,
              (sum, maintenance) => sum + maintenance.cost,
            );

            final vehicleCosts = <String, double>{};
            for (final maintenance in maintenances) {
              final vehicle = vehicles.firstWhere(
                (v) => v.id == maintenance.vehicleId,
              );
              final key = '${vehicle.brand} ${vehicle.model}';
              vehicleCosts[key] = (vehicleCosts[key] ?? 0) + maintenance.cost;
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Genel Bakış',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow(
                          'Toplam Araç:',
                          vehicles.length.toString(),
                          context,
                        ),
                        _buildInfoRow(
                          'Toplam Bakım:',
                          maintenances.length.toString(),
                          context,
                        ),
                        _buildInfoRow(
                          'Toplam Maliyet:',
                          '${totalCost.toStringAsFixed(2)} ₺',
                          context,
                          isHighlighted: true,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Araç Bazlı Maliyetler',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        ...vehicleCosts.entries.map(
                          (entry) => _buildInfoRow(
                            '${entry.key}:',
                            '${entry.value.toStringAsFixed(2)} ₺',
                            context,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Hata: $error')),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Hata: $error')),
    );
  }

  Widget _buildInfoRow(String label, String value, BuildContext context,
      {bool isHighlighted = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isHighlighted
                  ? Theme.of(context).colorScheme.primary
                  : null,
              fontWeight: isHighlighted ? FontWeight.bold : null,
            ),
          ),
        ],
      ),
    );
  }
} 