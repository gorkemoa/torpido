import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:torpido/core/providers/repository_providers.dart';
import 'package:torpido/features/inspection/domain/models/inspection_model.dart';
import 'package:torpido/features/maintenance/domain/models/maintenance_model.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<dynamic> _selectedEvents = [];
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    final maintenancesAsync = ref.watch(maintenanceRepositoryProvider);
    final inspectionsAsync = ref.watch(inspectionRepositoryProvider);

    return maintenancesAsync.when(
      data: (maintenanceRepository) => inspectionsAsync.when(
        data: (inspectionRepository) => FutureBuilder<List<dynamic>>(
          future: Future.wait([
            maintenanceRepository.getAllMaintenances(),
            inspectionRepository.getAllInspections(),
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Hata: ${snapshot.error}'));
            }

            final maintenances = snapshot.data?[0] as List<Maintenance>? ?? [];
            final inspections = snapshot.data?[1] as List<Inspection>? ?? [];

            final events = _getEvents(maintenances, inspections);

            return Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  eventLoader: (day) => events[day] ?? [],
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: CalendarStyle(
                    markersMaxCount: 1,
                    markerDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      _selectedEvents = events[selectedDay] ?? [];
                    });
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _selectedEvents.length,
                    itemBuilder: (context, index) {
                      final event = _selectedEvents[index];
                      if (event is Maintenance) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              child: const Icon(
                                Icons.build,
                                color: Colors.white,
                              ),
                            ),
                            title: const Text(
                              'Bakım',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(event.description),
                                const SizedBox(height: 4),
                                Text(
                                  '${event.cost.toStringAsFixed(2)} ₺',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (event is Inspection) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              child: const Icon(
                                Icons.assignment,
                                color: Colors.white,
                              ),
                            ),
                            title: const Text(
                              'Muayene',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(event.notes ?? ''),
                                const SizedBox(height: 4),
                                Text(
                                  '${event.cost.toStringAsFixed(2)} ₺',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return null;
                    },
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

  Map<DateTime, List<dynamic>> _getEvents(
    List<Maintenance> maintenances,
    List<Inspection> inspections,
  ) {
    final events = <DateTime, List<dynamic>>{};

    for (final maintenance in maintenances) {
      final date = DateTime(
        maintenance.date.year,
        maintenance.date.month,
        maintenance.date.day,
      );
      events[date] = [...(events[date] ?? []), maintenance];
    }

    for (final inspection in inspections) {
      final date = DateTime(
        inspection.date.year,
        inspection.date.month,
        inspection.date.day,
      );
      events[date] = [...(events[date] ?? []), inspection];
    }

    return events;
  }
} 