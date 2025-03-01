import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torpido/core/providers/repository_providers.dart';
import 'package:torpido/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:torpido/features/maintenance/presentation/screens/maintenances_screen.dart';
import 'package:torpido/features/service/presentation/screens/services_screen.dart';
import 'package:torpido/features/vehicle/presentation/screens/vehicle_detail_screen.dart';
import 'package:torpido/features/vehicle/presentation/screens/vehicles_screen.dart';
import 'package:torpido/features/vehicle/presentation/screens/add_vehicle_screen.dart';
import 'package:torpido/features/vehicle/presentation/screens/vehicle_tests_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  Timer? _refreshTimer;
  int _totalVehicles = 0;
  double _totalMaintenanceCost = 0;
  int _upcomingInspections = 0;
  int _selectedIndex = 0;

  List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _refreshData();
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) => _refreshData());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _screens = [
        _buildDashboard(context),
        const MaintenancesScreen(),
        const VehiclesScreen(),
        const ServicesScreen(),
      ];
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _refreshData() async {
    try {
      debugPrint('Veri yenileme başlatıldı...');
      
      final vehicleRepository = await ref.read(vehicleRepositoryProvider.future);
      final maintenanceRepository = await ref.read(maintenanceRepositoryProvider.future);
      final inspectionRepository = await ref.read(inspectionRepositoryProvider.future);

      final vehicles = await vehicleRepository.getAllVehicles();
      final maintenances = await maintenanceRepository.getAllMaintenances();
      final inspections = await inspectionRepository.getAllInspections();

      if (vehicles.isEmpty) {
        debugPrint('Araç verisi bulunamadı');
      } else {
        debugPrint('Yüklenen araç sayısı: ${vehicles.length}');
        
        for (final vehicle in vehicles) {
          debugPrint('Araç ID: ${vehicle.id}, Marka: ${vehicle.brand}, Model: ${vehicle.model}');
        }
      }

      final now = DateTime.now();
      final upcomingInspections = inspections.where((i) {
        if (i.expiryDate == null) return false;
        final daysUntilExpiry = i.expiryDate!.difference(now).inDays;
        return daysUntilExpiry >= 0 && daysUntilExpiry <= 30;
      }).length;

      if (mounted) {
        setState(() {
          _totalVehicles = vehicles.length;
          _totalMaintenanceCost = maintenances.fold(0, (sum, m) => sum + m.cost);
          _upcomingInspections = upcomingInspections;
          debugPrint('Durum güncellendi: Araç sayısı $_totalVehicles');
        });
      }
    } catch (e, stackTrace) {
      debugPrint('Veri yenileme hatası: $e');
      debugPrint('Hata detayı: $stackTrace');
      
      if (e.toString().contains('Isar')) {
        debugPrint('Veritabanı bağlantı hatası. Yeniden bağlanmaya çalışılıyor...');
        // Veritabanı bağlantısını yeniden dene
        await Future.delayed(const Duration(seconds: 2));
        await _refreshData();
      }
    }
  }

  Widget _buildDashboard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.06;
    
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: size.height * 0.04,
        ),
        children: [
          // Hoş geldiniz bölümü
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.dashboard_rounded,
                    color: colorScheme.primary,
                    size: size.width * 0.07,
                  ),
                ),
                SizedBox(width: size.width * 0.04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Torpido',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    Text(
                      'Araç bakım asistanınız',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.03),
          // İstatistik kartı
          Container(
            padding: EdgeInsets.all(size.width * 0.06),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primary,
                  colorScheme.primary.withBlue(255),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.analytics_rounded,
                      color: Colors.white.withOpacity(0.9),
                      size: size.width * 0.06,
                    ),
                    SizedBox(width: size.width * 0.03),
                    Text(
                      'Genel Bakış',
                      style: textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatItem(
                          context,
                          icon: Icons.directions_car,
                          value: _totalVehicles.toString(),
                          label: 'Araç',
                        ),
                      ),
                      VerticalDivider(
                        width: size.width * 0.04,
                        thickness: 1,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          context,
                          icon: Icons.build,
                          value: '${_totalMaintenanceCost.toStringAsFixed(0)} ₺',
                          label: 'Bakım',
                        ),
                      ),
                      VerticalDivider(
                        width: size.width * 0.04,
                        thickness: 1,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          context,
                          icon: Icons.assignment_late,
                          value: _upcomingInspections.toString(),
                          label: 'Muayene',
                          warning: _upcomingInspections > 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.03),
          // Hızlı işlemler başlığı
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Hızlı İşlemler',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          // Hızlı işlemler grid
          LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = (constraints.maxWidth - padding) / 2;
              final itemHeight = itemWidth * 0.9;
              
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: padding / 2,
                crossAxisSpacing: padding / 2,
                childAspectRatio: itemWidth / itemHeight,
                children: [
                  _buildActionCard(
                    context,
                    icon: Icons.add_circle_outline_rounded,
                    title: 'Araç Ekle',
                    subtitle: 'Yeni araç kaydı oluştur',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddVehicleScreen()),
                      );
                    },
                  ),
                  _buildActionCard(
                    context,
                    icon: Icons.list_alt_rounded,
                    title: 'Araçlarım',
                    subtitle: 'Tüm araçları görüntüle',
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                  ),
                  _buildActionCard(
                    context,
                    icon: Icons.checklist_rounded,
                    title: 'Testler',
                    subtitle: 'Araç testleri',
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Lütfen test etmek istediğiniz aracı seçin'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                  _buildActionCard(
                    context,
                    icon: Icons.build_circle_outlined,
                    title: 'Servisler',
                    subtitle: 'Servisler',
                    onTap: () {
                      setState(() {
                        _selectedIndex = 3;
                      });
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
    bool warning = false,
  }) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: warning ? Colors.orange : Colors.white.withOpacity(0.9),
          size: size.width * 0.06,
        ),
        SizedBox(height: size.height * 0.01),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.005),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          padding: EdgeInsets.all(size.width * 0.04),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(size.width * 0.03),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: colorScheme.primary,
                  size: size.width * 0.07,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: size.height * 0.005),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: 'Ana Sayfa',
          ),
          NavigationDestination(
            icon: Icon(Icons.build_outlined),
            selectedIcon: Icon(Icons.build_rounded),
            label: 'Bakımlar',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_car_outlined),
            selectedIcon: Icon(Icons.directions_car_rounded),
            label: 'Araçlar',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map_rounded),
            label: 'Servisler',
          ),
        ],
      ),
    );
  }
} 