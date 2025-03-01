import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torpido/core/providers/repository_providers.dart';
import 'package:torpido/features/maintenance/domain/models/maintenance_model.dart';
import 'package:torpido/features/vehicle/domain/models/vehicle_model.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

class AddMaintenanceScreen extends ConsumerWidget {
  final Vehicle vehicle;

  const AddMaintenanceScreen({
    super.key,
    required this.vehicle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final costController = TextEditingController();
    final descriptionController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final selectedDate = ValueNotifier<DateTime>(DateTime.now());
    final nextServiceDate = ValueNotifier<DateTime?>(null);

    void _addToCalendar(String description, DateTime date) {
      final Event event = Event(
        title: 'Araç Bakımı - ${vehicle.plate}',
        description: description,
        location: '',
        startDate: date,
        endDate: date.add(const Duration(hours: 1)),
        allDay: true,
        iosParams: const IOSParams(
          reminder: Duration(days: 1),
        ),
        androidParams: const AndroidParams(
          emailInvites: [],
        ),
      );
      Add2Calendar.addEvent2Cal(event);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bakım Ekle'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bakım Detayları',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    ValueListenableBuilder(
                      valueListenable: selectedDate,
                      builder: (context, date, _) => InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: date,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            selectedDate.value = picked;
                          }
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Bakım Tarihi',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          child: Text(
                            '${date.day}/${date.month}/${date.year}',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ValueListenableBuilder(
                      valueListenable: nextServiceDate,
                      builder: (context, date, _) => InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: date ?? DateTime.now().add(const Duration(days: 180)),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            nextServiceDate.value = picked;
                          }
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Sonraki Bakım Tarihi',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.event),
                          ),
                          child: Text(
                            date != null 
                                ? '${date.day}/${date.month}/${date.year}'
                                : 'Tarih Seçin',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: costController,
                      decoration: const InputDecoration(
                        labelText: 'Maliyet (₺)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Maliyet giriniz';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Geçerli bir sayı giriniz';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Açıklama',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Açıklama giriniz';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final maintenance = Maintenance(
                  vehicleId: vehicle.id,
                  cost: double.parse(costController.text),
                  description: descriptionController.text,
                  date: selectedDate.value,
                  kilometer: vehicle.kilometer ?? 0,
                  nextServiceDate: nextServiceDate.value,
                );

                final repository = await ref.read(maintenanceRepositoryProvider.future);
                await repository.addMaintenance(maintenance);

                if (nextServiceDate.value != null) {
                  if (context.mounted) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Takvime Ekle'),
                        content: const Text('Sonraki bakım tarihini telefonunuzun takvimine eklemek ister misiniz?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Hayır'),
                          ),
                          TextButton(
                            onPressed: () {
                              _addToCalendar(
                                'Araç Bakımı: ${descriptionController.text}',
                                nextServiceDate.value!,
                              );
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text('Evet'),
                          ),
                        ],
                      ),
                    );
                  }
                } else if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Kaydet'),
          ),
        ),
      ),
    );
  }
} 