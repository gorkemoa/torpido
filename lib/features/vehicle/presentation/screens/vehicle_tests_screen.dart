import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torpido/core/providers/repository_providers.dart';
import 'package:torpido/features/vehicle/domain/models/predefined_vehicle_test.dart';
import 'package:torpido/features/vehicle/domain/models/vehicle_model.dart';
import 'package:torpido/features/vehicle/presentation/controllers/vehicle_test_controller.dart';
import 'package:intl/intl.dart';

import '../../domain/models/test_result.dart';

class VehicleTestsScreen extends ConsumerStatefulWidget {
  final Vehicle vehicle;

  const VehicleTestsScreen({
    super.key,
    required this.vehicle,
  });

  @override
  ConsumerState<VehicleTestsScreen> createState() => _VehicleTestsScreenState();
}

class _VehicleTestsScreenState extends ConsumerState<VehicleTestsScreen> {
  late final List<PredefinedVehicleTest> _predefinedTests;
  final Map<String, bool> _testResults = {};
  final Map<String, String> _testNotes = {};
  final Map<String, bool> _expandedCategories = {};

  @override
  void initState() {
    super.initState();
    final controller = ref.read(vehicleTestControllerProvider);
    _predefinedTests = controller.getPredefinedTests();
    
    // Kategorileri genişletilmiş olarak başlat
    final categories = controller.getTestsByCategory(_predefinedTests);
    for (var category in categories.keys) {
      _expandedCategories[category] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(vehicleTestControllerProvider);
    final categories = controller.getTestsByCategory(_predefinedTests);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Araç Kontrolü'),
        actions: [
          TextButton(
            onPressed: _testResults.isEmpty ? null : _submitTests,
            child: const Text('Kaydet'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Aracınızın durumunu değerlendirmek için aşağıdaki soruları yanıtlayın.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              ...categories.entries.map((entry) => _buildCategoryCard(entry.key, entry.value)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String category, List<PredefinedVehicleTest> tests) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: _expandedCategories[category] ?? false,
          onExpansionChanged: (expanded) {
            setState(() {
              _expandedCategories[category] = expanded;
            });
          },
          title: Text(
            category,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          children: tests.map((test) => _buildTestTile(test)).toList(),
        ),
      ),
    );
  }

  Widget _buildTestTile(PredefinedVehicleTest test) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      test.question,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (test.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        test.description!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Switch(
                value: _testResults[test.name] ?? false,
                onChanged: (value) {
                  setState(() {
                    _testResults[test.name] = value;
                  });
                },
              ),
            ],
          ),
          if (_testResults[test.name] == true) ...[
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Notunuzu ekleyin (isteğe bağlı)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                _testNotes[test.name] = value;
              },
            ),
          ],
          const Divider(),
        ],
      ),
    );
  }

  Future<void> _submitTests() async {
    final tests = _testResults.entries.map((entry) {
      final predefinedTest = _predefinedTests.firstWhere((test) => test.name == entry.key);
      return TestResult(
        vehicleId: widget.vehicle.id.toString(),
        name: entry.key,
        type: predefinedTest.type.name,
        isPassed: !entry.value, // true = sorun yok, false = sorun var
        notes: _testNotes[entry.key],
        date: DateTime.now(),
      );
    }).toList();

    try {
      final controller = ref.read(vehicleTestControllerProvider);
      await controller.submitTests(widget.vehicle.id.toString(), tests);
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bir hata oluştu: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
} 