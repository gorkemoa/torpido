import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torpido/core/providers/repository_providers.dart';
import 'package:torpido/core/providers/service_providers.dart';
import 'package:torpido/features/inspection/domain/models/inspection_model.dart';
import 'package:torpido/features/maintenance/domain/models/maintenance_model.dart';
import 'package:torpido/features/vehicle/domain/models/vehicle_model.dart';
import 'package:torpido/features/vehicle/domain/models/test_result.dart';
import 'package:torpido/features/vehicle/domain/models/vehicle_insight_model.dart';
import 'package:torpido/features/vehicle/presentation/screens/vehicle_insights_screen.dart';
import 'package:torpido/features/vehicle/presentation/screens/vehicle_tests_screen.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

class VehicleDetailScreen extends ConsumerStatefulWidget {
  final Vehicle vehicle;

  const VehicleDetailScreen({
    super.key,
    required this.vehicle,
  });

  @override
  ConsumerState<VehicleDetailScreen> createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends ConsumerState<VehicleDetailScreen> with SingleTickerProviderStateMixin {
  Vehicle? _currentVehicle;
  List<Maintenance> _maintenances = [];
  List<Inspection> _inspections = [];
  late TabController _tabController;
  final currencyFormat = NumberFormat.currency(locale: 'tr_TR', symbol: '₺', decimalDigits: 0);
  final selectedMaintenanceType = ValueNotifier<String>('Motor Yağı Değişimi');
  final selectedInspectionType = ValueNotifier<String>('TÜVTÜRK Araç Muayenesi');

  // Bakım türleri
  final maintenanceTypes = [
    'Motor Yağı Değişimi',
    'Yağ Filtresi Değişimi',
    'Hava Filtresi Değişimi',
    'Polen Filtresi Değişimi',
    'Fren Bakımı',
    'Balata Değişimi',
    'Lastik Değişimi',
    'Akü Değişimi',
    'Genel Bakım',
    'Diğer',
  ];

  // Muayene türleri
  final inspectionTypes = [
    'TÜVTÜRK Araç Muayenesi',
    'TÜVTÜRK Tadilat Muayenesi',
    'TÜVTÜRK Egzoz Muayenesi',
    'LPG/CNG Sızdırmazlık',
    'LPG/CNG Montaj',
    'Ağır Hasar Sonrası',
    'Sigorta Ekspertiz',
    'İkinci El Ekspertiz',
    'Diğer',
  ];

  @override
  void initState() {
    super.initState();
    _currentVehicle = widget.vehicle;
    _tabController = TabController(length: 4, vsync: this);
    initializeDateFormatting('tr_TR', null);
    _loadInitialData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    try {
      final maintenanceRepo = await ref.read(maintenanceRepositoryProvider.future);
      final inspectionRepo = await ref.read(inspectionRepositoryProvider.future);
      final vehicleRepo = await ref.read(vehicleRepositoryProvider.future);

      final vehicles = await vehicleRepo.getAllVehicles();
      final vehicle = vehicles.firstWhere((v) => v.id == widget.vehicle.id);
      final maintenances = await maintenanceRepo.getAllMaintenances();
      final inspections = await inspectionRepo.getAllInspections();

      if (mounted) {
        setState(() {
          _currentVehicle = vehicle;
          _maintenances = maintenances;
          _inspections = inspections;
        });
      }
    } catch (e) {
      debugPrint('Veri yükleme hatası: $e');
    }
  }

  Future<void> _refreshData() async {
    await _loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    final vehicle = _currentVehicle ?? widget.vehicle;
    
    final lastMaintenance = _maintenances
        .where((m) => m.vehicleId == vehicle.id)
        .fold<DateTime?>(
          null,
          (prev, curr) => prev == null || curr.date.isAfter(prev) ? curr.date : prev,
        );

    final lastInspection = _inspections
        .where((i) => i.vehicleId == vehicle.id)
        .fold<DateTime?>(
          null,
          (prev, curr) => prev == null || curr.date.isAfter(prev) ? curr.date : prev,
        );

    final nextInspection = _inspections
        .where((i) => i.vehicleId == vehicle.id)
        .fold<DateTime?>(
          null,
          (prev, curr) => prev == null ||
                  (curr.expiryDate != null &&
                      curr.expiryDate.isAfter(DateTime.now()) &&
                      (prev == null ||
                          prev.isBefore(curr.expiryDate) ||
                          prev.isBefore(DateTime.now())))
              ? curr.expiryDate
              : prev,
        );

    // Toplam bakım maliyeti
    final totalMaintenanceCost = _maintenances
        .where((m) => m.vehicleId == vehicle.id)
        .fold<double>(0, (sum, m) => sum + m.cost);

    // Toplam muayene maliyeti
    final totalInspectionCost = _inspections
        .where((i) => i.vehicleId == vehicle.id)
        .fold<double>(0, (sum, i) => sum + i.cost);

    // Son 6 aydaki bakımlar
    final recentMaintenances = _maintenances
        .where((m) => m.vehicleId == vehicle.id)
        .where((m) => m.date.isAfter(DateTime.now().subtract(const Duration(days: 180))))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.history),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VehicleInsightsScreen(vehicle: vehicle),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.add_task_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VehicleTestsScreen(vehicle: vehicle),
                    ),
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                vehicle.plate,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 16,
                      bottom: 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${vehicle.brand} ${vehicle.model}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              vehicle.year.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 16,
                      bottom: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.surface,
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).viewInsets.bottom,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'İşlem Seçin',
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                            child: Icon(Icons.build_outlined, color: Theme.of(context).colorScheme.primary),
                                          ),
                                          title: Text(
                                            'Bakım Ekle',
                                            style: TextStyle(
                                              color: Theme.of(context).colorScheme.onSurface,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor: Colors.transparent,
                                              builder: (context) => Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).colorScheme.surface,
                                                  borderRadius: const BorderRadius.vertical(
                                                    top: Radius.circular(20),
                                                  ),
                                                ),
                                                padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context).viewInsets.bottom,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16),
                                                  child: _buildQuickMaintenanceForm(context, vehicle),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                            child: Icon(Icons.assignment_outlined, color: Theme.of(context).colorScheme.primary),
                                          ),
                                          title: Text(
                                            'Muayene Ekle',
                                            style: TextStyle(
                                              color: Theme.of(context).colorScheme.onSurface,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor: Colors.transparent,
                                              builder: (context) => Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).colorScheme.surface,
                                                  borderRadius: const BorderRadius.vertical(
                                                    top: Radius.circular(20),
                                                  ),
                                                ),
                                                padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context).viewInsets.bottom,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16),
                                                  child: _buildQuickInspectionForm(context, vehicle),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                            child: Icon(Icons.analytics_outlined, color: Theme.of(context).colorScheme.primary),
                                          ),
                                          title: Text(
                                            'AI Analizi',
                                            style: TextStyle(
                                              color: Theme.of(context).colorScheme.onSurface,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          onTap: () async {
                                            Navigator.pop(context);
                                            await _showAIInsights();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.add_circle_outline,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'İşlem Ekle',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'Toplam Bakım',
                          currencyFormat.format(totalMaintenanceCost),
                          Icons.build_outlined,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'Toplam Muayene',
                          currencyFormat.format(totalInspectionCost),
                          Icons.assignment_outlined,
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildAIInsightsCard(),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Theme.of(context).colorScheme.primary,
              tabs: const [
                Tab(text: 'Genel Bilgiler'),
                Tab(text: 'Bakımlar'),
                Tab(text: 'Muayeneler'),
                Tab(text: 'Test Sonuçları'),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 300,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildGeneralInfoTab(context, vehicle, lastMaintenance, lastInspection, nextInspection, totalMaintenanceCost, totalInspectionCost),
                  _buildMaintenanceTab(context, recentMaintenances),
                  _buildInspectionTab(context, _inspections.where((i) => i.vehicleId == vehicle.id.toString()).toList()),
                  _buildTestResultsTab(context, vehicle),
                ],
              ),
            ),
          ),
        ],
      ),
    
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralInfoTab(
    BuildContext context,
    Vehicle vehicle,
    DateTime? lastMaintenance,
    DateTime? lastInspection,
    DateTime? nextInspection,
    double totalMaintenanceCost,
    double totalInspectionCost,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (vehicle.kilometer != null)
                    _buildInfoRow(
                      context,
                      'Kilometre',
                      '${NumberFormat('#,###').format(vehicle.kilometer)} km',
                      Icons.speed,
                    ),
                  if (vehicle.color != null)
                    _buildInfoRow(
                      context,
                      'Renk',
                      vehicle.color!,
                      Icons.palette_outlined,
                    ),
                  if (lastMaintenance != null)
                    _buildInfoRow(
                      context,
                      'Son Bakım',
                      _formatDate(lastMaintenance),
                      Icons.build_outlined,
                    ),
                  if (lastInspection != null)
                    _buildInfoRow(
                      context,
                      'Son Muayene',
                      _formatDate(lastInspection),
                      Icons.assignment_outlined,
                    ),
                  if (nextInspection != null)
                    _buildInfoRow(
                      context,
                      'Sonraki Muayene',
                      _formatDate(nextInspection),
                      Icons.event_outlined,
                      isWarning: _isDateClose(nextInspection),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenanceTab(BuildContext context, List<Maintenance> maintenances) {
    if (maintenances.isEmpty) {
      return const Center(
        child: Text('Henüz bakım kaydı bulunmuyor'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: maintenances.map((maintenance) => Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      maintenance.description,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      currencyFormat.format(maintenance.cost),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 4),
                    Text(_formatDate(maintenance.date)),
                    const SizedBox(width: 16),
                    const Icon(Icons.speed, size: 16),
                    const SizedBox(width: 4),
                    Text('${NumberFormat('#,###').format(maintenance.kilometer)} km'),
                  ],
                ),
              ],
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildInspectionTab(BuildContext context, List<Inspection> inspections) {
    if (inspections.isEmpty) {
      return const Center(
        child: Text('Henüz muayene kaydı bulunmuyor'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: inspections.map((inspection) => Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        inspection.type,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      currencyFormat.format(inspection.cost),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 4),
                    Text(_formatDate(inspection.date)),
                    if (inspection.expiryDate != null) ...[
                      const SizedBox(width: 16),
                      const Icon(Icons.event, size: 16),
                      const SizedBox(width: 4),
                      Text('Geçerlilik: ${_formatDate(inspection.expiryDate!)}'),
                    ],
                  ],
                ),
                if (inspection.notes?.isNotEmpty == true) ...[
                  const SizedBox(height: 8),
                  Text(inspection.notes!),
                ],
              ],
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    bool isWarning = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isWarning
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: isWarning
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.onSurface,
                    fontWeight: isWarning ? FontWeight.bold : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd.MM.yyyy').format(date);
  }

  bool _isDateClose(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;
    return difference <= 30 && difference >= 0;
  }

  Widget _buildQuickMaintenanceForm(BuildContext context, Vehicle vehicle) {
    final costController = TextEditingController();
    final currentKmController = TextEditingController(text: vehicle.kilometer?.toString());
    final noteController = TextEditingController(text: 'Rutin Bakım');
    final customTypeController = TextEditingController();
    final nextServiceDate = ValueNotifier<DateTime?>(null);
    final maintenanceDate = ValueNotifier<DateTime>(DateTime.now());
    final showCustomType = ValueNotifier<bool>(false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hızlı Bakım Ekle',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder(
          valueListenable: maintenanceDate,
          builder: (context, date, _) => InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                maintenanceDate.value = picked;
              }
            },
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Bakım Tarihi',
                prefixIcon: const Icon(Icons.calendar_today),
                suffixIcon: TextButton(
                  onPressed: () {
                    maintenanceDate.value = DateTime.now();
                  },
                  child: const Text('Bugün'),
                ),
                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
              child: Text(_formatDate(date)),
            ),
          ),
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder(
          valueListenable: selectedMaintenanceType,
          builder: (context, value, _) => DropdownButtonFormField<String>(
            value: value,
            decoration: const InputDecoration(
              labelText: 'Bakım Türü',
              prefixIcon: Icon(Icons.build_circle),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            items: [
              for (final type in maintenanceTypes)
                DropdownMenuItem(
                  value: type,
                  child: Text(type),
                ),
            ],
            onChanged: (value) {
              if (value != null) {
                selectedMaintenanceType.value = value;
                showCustomType.value = value == 'Diğer';
                if (value == 'Diğer') {
                  noteController.text = '';
                } else {
                  noteController.text = value;
                  customTypeController.text = '';
                }
                nextServiceDate.value = DateTime.now().add(const Duration(days: 180));
              }
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: showCustomType,
          builder: (context, show, _) => show
              ? Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: TextField(
                    controller: customTypeController,
                    decoration: const InputDecoration(
                      labelText: 'Bakım Türünü Yazın',
                      prefixIcon: Icon(Icons.edit),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    onChanged: (value) {
                      noteController.text = value;
                    },
                  ),
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(height: 12),
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
                prefixIcon: Icon(Icons.event),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
              child: Text(
                date != null ? _formatDate(date) : 'Tarih Seçin',
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: costController,
          decoration: const InputDecoration(
            labelText: 'Maliyet (₺)',
            prefixIcon: Icon(Icons.attach_money),
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          ),
          keyboardType: TextInputType.number,
          autofocus: true,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: currentKmController,
          decoration: const InputDecoration(
            labelText: 'Şu anki KM',
            prefixIcon: Icon(Icons.speed),
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: noteController,
          decoration: const InputDecoration(
            labelText: 'Not',
            prefixIcon: Icon(Icons.note),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              final cost = double.tryParse(costController.text);
              final currentKm = int.tryParse(currentKmController.text);

              if (cost != null && currentKm != null) {
                final maintenance = Maintenance(
                  vehicleId: vehicle.id,
                  cost: cost,
                  description: noteController.text,
                  date: maintenanceDate.value,
                  kilometer: currentKm,
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
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text('Hayır'),
                          ),
                          TextButton(
                            onPressed: () {
                              final event = Event(
                                title: 'Araç Bakımı - ${vehicle.plate}',
                                description: noteController.text,
                                location: '',
                                startDate: nextServiceDate.value!,
                                endDate: nextServiceDate.value!.add(const Duration(hours: 1)),
                                allDay: true,
                              );
                              Add2Calendar.addEvent2Cal(event);
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Kaydet'),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickInspectionForm(BuildContext context, Vehicle vehicle) {
    final costController = TextEditingController();
    final currentKmController = TextEditingController(text: vehicle.kilometer?.toString());
    final noteController = TextEditingController(text: 'TÜVTÜRK Araç Muayenesi');
    final customTypeController = TextEditingController();
    final nextInspectionDate = ValueNotifier<DateTime>(
      DateTime.now().add(Duration(days: vehicle.year < 2016 ? 365 : 730)),
    );
    final inspectionDate = ValueNotifier<DateTime>(DateTime.now());
    final showCustomType = ValueNotifier<bool>(false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hızlı Muayene Ekle',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder(
          valueListenable: inspectionDate,
          builder: (context, date, _) => InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                inspectionDate.value = picked;
              }
            },
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Muayene Tarihi',
                prefixIcon: const Icon(Icons.calendar_today),
                suffixIcon: TextButton(
                  onPressed: () {
                    inspectionDate.value = DateTime.now();
                  },
                  child: const Text('Bugün'),
                ),
                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
              child: Text(_formatDate(date)),
            ),
          ),
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder(
          valueListenable: selectedInspectionType,
          builder: (context, value, _) => DropdownButtonFormField<String>(
            value: value,
            decoration: const InputDecoration(
              labelText: 'Muayene Türü',
              prefixIcon: Icon(Icons.assignment_turned_in),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            items: inspectionTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
            onChanged: (value) {
              if (value != null) {
                selectedInspectionType.value = value;
                showCustomType.value = value == 'Diğer';
                if (value == 'Diğer') {
                  noteController.text = '';
                } else {
                  noteController.text = value;
                  customTypeController.text = '';
                }
                
                if (value.startsWith('TÜVTÜRK')) {
                  nextInspectionDate.value = DateTime.now().add(
                    Duration(days: vehicle.year < 2016 ? 365 : 730),
                  );
                } else if (value.contains('LPG')) {
                  nextInspectionDate.value = DateTime.now().add(const Duration(days: 365));
                } else {
                  nextInspectionDate.value = DateTime.now().add(const Duration(days: 30));
                }
              }
            },
          ),
        ),
        ValueListenableBuilder(
          valueListenable: showCustomType,
          builder: (context, show, _) => show
              ? Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: TextField(
                    controller: customTypeController,
                    decoration: const InputDecoration(
                      labelText: 'Muayene Türünü Yazın',
                      prefixIcon: Icon(Icons.edit),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    onChanged: (value) {
                      noteController.text = value;
                    },
                  ),
                )
              : const SizedBox.shrink(),
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder(
          valueListenable: nextInspectionDate,
          builder: (context, date, _) => InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                nextInspectionDate.value = picked;
              }
            },
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Sonraki Muayene Tarihi',
                prefixIcon: Icon(Icons.event),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
              child: Text(
                date != null ? _formatDate(date) : 'Tarih Seçin',
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: costController,
          decoration: const InputDecoration(
            labelText: 'Maliyet (₺)',
            prefixIcon: Icon(Icons.attach_money),
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          ),
          keyboardType: TextInputType.number,
          autofocus: true,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: currentKmController,
          decoration: const InputDecoration(
            labelText: 'Şu anki KM',
            prefixIcon: Icon(Icons.speed),
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: noteController,
          decoration: const InputDecoration(
            labelText: 'Not',
            prefixIcon: Icon(Icons.note),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              final cost = double.tryParse(costController.text);
              final currentKm = int.tryParse(currentKmController.text);

              if (cost != null && currentKm != null) {
                final inspection = Inspection(
                  type: selectedInspectionType.value,
                  vehicleId: vehicle.id.toString(),
                  cost: cost,
                  date: inspectionDate.value,
                  isPassed: true,
                  expiryDate: nextInspectionDate.value,
                  notes: noteController.text,
                );
                final repository = await ref.read(inspectionRepositoryProvider.future);
                await repository.addInspection(inspection);
                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Takvime Ekle'),
                      content: const Text('Sonraki muayene tarihini telefonunuzun takvimine eklemek ister misiniz?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text('Hayır'),
                        ),
                        TextButton(
                          onPressed: () {
                            final event = Event(
                              title: 'Araç Muayenesi - ${vehicle.plate}',
                              description: noteController.text,
                              location: '',
                              startDate: nextInspectionDate.value,
                              endDate: nextInspectionDate.value.add(const Duration(hours: 1)),
                              allDay: true,
                            );
                            Add2Calendar.addEvent2Cal(event);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text('Evet'),
                        ),
                      ],
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Kaydet'),
          ),
        ),
      ],
    );
  }

  Widget _buildAIInsightsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () async {
            await _showAIInsights();
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Akıllı Öneriler',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '${widget.vehicle.brand} ${widget.vehicle.model} için kişiselleştirilmiş bakım, muayene ve maliyet önerileri almak için tıklayın.',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.touch_app,
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Detaylar için tıklayın',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAIInsights() async {
    try {
      // Bakım ve muayene verilerini al
      final maintenanceRepo = await ref.read(maintenanceRepositoryProvider.future);
      final inspectionRepo = await ref.read(inspectionRepositoryProvider.future);
      final maintenances = await maintenanceRepo.getAllMaintenances();
      final inspections = await inspectionRepo.getAllInspections();

      // Son öneriyi kontrol et
      final insightRepository = await ref.read(vehicleInsightRepositoryProvider.future);
      final lastInsights = await insightRepository.getInsightsByVehicleId(widget.vehicle.id);
      
      if (lastInsights.isNotEmpty) {
        final lastInsight = lastInsights.first;
        final lastMaintenanceDate = _maintenances
            .where((m) => m.vehicleId == widget.vehicle.id)
            .fold<DateTime?>(
              null,
              (prev, curr) => prev == null || curr.date.isAfter(prev) ? curr.date : prev,
            );
        final lastInspectionDate = _inspections
            .where((i) => i.vehicleId == widget.vehicle.id)
            .fold<DateTime?>(
              null,
              (prev, curr) => prev == null || curr.date.isAfter(prev) ? curr.date : prev,
            );

        // Son öneri sonrası yeni bakım veya muayene yapılmış mı kontrol et
        final hasNewData = (lastMaintenanceDate != null && lastMaintenanceDate.isAfter(lastInsight.createdAt)) ||
            (lastInspectionDate != null && lastInspectionDate.isAfter(lastInsight.createdAt));

        if (!hasNewData) {
          if (!context.mounted) return;
          
          // Değişiklik yoksa kullanıcıya sor
          final shouldContinue = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Yeni Öneri Al'),
              content: const Text('Son öneriden sonra herhangi bir değişiklik yapılmamış. Yine de yeni öneri almak ister misiniz?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Hayır'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Evet'),
                ),
              ],
            ),
          );

          if (shouldContinue != true) return;
        }
      }

      if (!context.mounted) return;

      // Yükleniyor dialogu göster
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // AI önerilerini al
      final aiService = ref.watch(aiServiceProvider);
      final insights = await aiService.getVehicleInsights(
        widget.vehicle,
        maintenances,
        inspections,
      );

      // Önerileri kaydet
      await insightRepository.addInsight(
        VehicleInsight(
          vehicleId: widget.vehicle.id,
          content: insights,
          createdAt: DateTime.now(),
          vehicleBrand: widget.vehicle.brand,
          vehicleModel: widget.vehicle.model,
          vehiclePlate: widget.vehicle.plate,
        ),
      );

      if (!context.mounted) return;

      // Yükleniyor dialogunu kapat
      Navigator.pop(context);

      // AI önerilerini göster
      await showDialog(
        context: context,
        builder: (context) => Dialog(
          key: UniqueKey(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${widget.vehicle.brand} ${widget.vehicle.model} için Öneriler',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.history),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VehicleInsightsScreen(vehicle: widget.vehicle),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Text(
                      insights,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Tamam'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      // Yükleniyor dialogunu kapat
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      // Hata mesajını göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Öneriler alınırken bir hata oluştu: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildTestResultsTab(BuildContext context, Vehicle vehicle) {
    return FutureBuilder(
      future: ref.read(vehicleTestRepositoryProvider.future),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Bir hata oluştu',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        final repository = snapshot.data!;
        return FutureBuilder<List<TestResult>>(
          future: repository.getTestsByVehicleId(vehicle.id.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Bir hata oluştu',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            final tests = snapshot.data ?? [];

            if (tests.isEmpty) {
              return _EmptyTestResults(vehicle: vehicle);
            }

            // Testleri tarihe göre grupla ve sırala
            final groupedTests = <DateTime, List<TestResult>>{};
            for (var test in tests) {
              if (test.date != null) {
                final date = DateTime(
                  test.date!.year,
                  test.date!.month,
                  test.date!.day,
                );
                groupedTests.putIfAbsent(date, () => []).add(test);
              }
            }

            final sortedDates = groupedTests.keys.toList()
              ..sort((a, b) => b.compareTo(a));

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildOverallStatus(context, tests),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: sortedDates.length,
                    itemBuilder: (context, index) {
                      final date = sortedDates[index];
                      final testsForDate = groupedTests[date]!;
                      return _TestResultDateGroup(
                        date: date,
                        tests: testsForDate,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildOverallStatus(BuildContext context, List<TestResult> tests) {
    final totalTests = tests.length;
    final goodCondition = tests.where((test) => test.isPassed == true).length;
    final needsAttention = totalTests - goodCondition;
    final overallScore = (goodCondition / totalTests * 100).round();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              overallScore >= 70 
                  ? Colors.green.withOpacity(0.1)
                  : const Color.fromARGB(143, 0, 0, 0),
              const Color.fromARGB(143, 0, 0, 0),
            ],

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (overallScore >= 70 ? Colors.green : const Color.fromARGB(255, 167, 228, 173)).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      overallScore >= 70 ? Icons.check_circle : Icons.warning,
                      color: overallScore >= 70 ? Colors.green : const Color.fromARGB(255, 147, 185, 142),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Araç Sağlığı',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildStatusBox(
                      context,
                      '$overallScore%',
                      'Genel Durum',
                      overallScore >= 70 ? Colors.green : const Color.fromARGB(255, 153, 221, 221),
                      Icons.speed,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatusBox(
                      context,
                      goodCondition.toString(),
                      'İyi',
                      Colors.green,
                      Icons.check_circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatusBox(
                      context,
                      needsAttention.toString(),
                      'Kontrol',
                      const Color.fromARGB(255, 141, 123, 96),
                      Icons.warning,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBox(
    BuildContext context,
    String value,
    String label,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _TestResultListItem extends StatelessWidget {
  final TestResult test;

  const _TestResultListItem({
    Key? key,
    required this.test,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = test.isPassed == true ? 'İyi' : 'Kontrol Edilmeli';
    final statusColor = test.isPassed == true 
        ? const Color(0xFF8BC34A) 
        : const Color(0xFF90A4AE);

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: statusColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Icon(
          test.isPassed == true ? Icons.check_circle : Icons.info_outline,
          color: statusColor,
          size: 24,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                test.name ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        subtitle: test.notes?.isNotEmpty == true
            ? Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  test.notes!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

class _TestResultDateGroup extends StatelessWidget {
  final DateTime date;
  final List<TestResult> tests;

  const _TestResultDateGroup({
    Key? key,
    required this.date,
    required this.tests,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalTests = tests.length;
    final goodCondition = tests.where((test) => test.isPassed == true).length;
    final needsAttention = totalTests - goodCondition;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today, 
                    size: 16,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat('dd MMMM yyyy', 'tr_TR').format(date),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildStatusIndicator(
                      context,
                      'İyi Durumda',
                      goodCondition,
                      const Color(0xFF8BC34A),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatusIndicator(
                      context,
                      'Dikkat Edilmeli',
                      needsAttention,
                      const Color(0xFF90A4AE),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tests.length,
          itemBuilder: (context, index) => _TestResultListItem(test: tests[index]),
        ),
      ],
    );
  }

  Widget _buildStatusIndicator(
    BuildContext context,
    String label,
    int count,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.1), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyTestResults extends StatelessWidget {
  final Vehicle vehicle;

  const _EmptyTestResults({
    Key? key,
    required this.vehicle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_car,
            size: 56,
            color: primaryColor.withOpacity(0.7),
          ),
          const SizedBox(height: 20),
          Text(
            'Aracınızı Kontrol Edelim',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Aracınızın durumunu birkaç basit soru ile\ndeğerlendirelim ve size özel öneriler alalım',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VehicleTestsScreen(vehicle: vehicle),
                ),
              );
            },
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Kontrol Başlat'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: BorderSide(color: primaryColor.withOpacity(0.5)),
              foregroundColor: primaryColor,
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}