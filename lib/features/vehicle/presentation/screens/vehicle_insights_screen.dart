import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torpido/core/providers/repository_providers.dart';
import 'package:torpido/features/vehicle/domain/models/vehicle_insight_model.dart';
import 'package:torpido/features/vehicle/domain/models/vehicle_model.dart';
import 'package:intl/intl.dart';

class VehicleInsightsScreen extends ConsumerStatefulWidget {
  final Vehicle? vehicle;

  const VehicleInsightsScreen({
    super.key,
    this.vehicle,
  });

  @override
  ConsumerState<VehicleInsightsScreen> createState() => _VehicleInsightsScreenState();
}

class _VehicleInsightsScreenState extends ConsumerState<VehicleInsightsScreen> {
  final dateFormat = DateFormat('dd.MM.yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vehicle != null 
          ? '${widget.vehicle!.brand} ${widget.vehicle!.model} Önerileri'
          : 'Tüm Öneriler'
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final repositoryAsyncValue = ref.watch(vehicleInsightRepositoryProvider);
          
          return repositoryAsyncValue.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(
              child: Text('Bir hata oluştu: $error'),
            ),
            data: (repository) => FutureBuilder<List<VehicleInsight>>(
              future: widget.vehicle != null
                ? repository.getInsightsByVehicleId(widget.vehicle!.id)
                : repository.getAllInsights(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Bir hata oluştu: ${snapshot.error}'),
                  );
                }

                final insights = snapshot.data ?? [];

                if (insights.isEmpty) {
                  return const Center(
                    child: Text('Henüz hiç öneri bulunmuyor.'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: insights.length,
                  itemBuilder: (context, index) {
                    final insight = insights[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${insight.vehicleBrand} ${insight.vehicleModel}'),
                                  Text(
                                    insight.vehiclePlate,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      dateFormat.format(insight.createdAt),
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(insight.content),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Kapat'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.auto_awesome,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${insight.vehicleBrand} ${insight.vehicleModel}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          insight.vehiclePlate,
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    dateFormat.format(insight.createdAt),
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                insight.content,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
} 