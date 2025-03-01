import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:torpido/core/providers/repository_providers.dart';
import 'package:torpido/features/vehicle/domain/models/vehicle_model.dart';
import 'package:torpido/features/maintenance/domain/models/maintenance_model.dart';
import 'package:torpido/features/inspection/domain/models/inspection_model.dart';
import 'package:torpido/features/vehicle/domain/models/vehicle_insight_model.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

import '../../features/vehicle/domain/models/predefined_vehicle_test.dart';

class AIService {
  final String _apiKey;
  final Ref _ref;
  String? _cachedInsights;
  DateTime? _lastInsightsTime;
  static const _cacheTimeout = Duration(minutes: 30);

  AIService(this._apiKey, this._ref);

  static const _baseUrl = 'https://api.openai.com/v1/chat/completions';

  // Her araç için ayrı önbellekleme
  static final Map<int, String> _vehicleInsights = {};
  static final Map<int, String> _vehicleAnalysis = {};

  Future<String> getVehicleInsights(Vehicle vehicle, List<Maintenance> maintenances, List<Inspection> inspections) async {
    if (_cachedInsights != null && _lastInsightsTime != null) {
      final difference = DateTime.now().difference(_lastInsightsTime!);
      if (difference < _cacheTimeout) {
        return _cachedInsights!;
      }
    }

    final vehicleMaintenances = maintenances.where((m) => m.vehicleId == vehicle.id).toList();
    final vehicleInspections = inspections.where((i) => i.vehicleId == vehicle.id).toList();

    final prompt = '''
Araç Bilgileri:
- Marka: ${vehicle.brand}
- Model: ${vehicle.model}
- Yıl: ${vehicle.year}
- Plaka: ${vehicle.plate}

Bakım Geçmişi:
${vehicleMaintenances.map((m) => '- Tarih: ${DateFormat('dd.MM.yyyy').format(m.date)}, Km: ${m.kilometer}, Maliyet: ${m.cost}₺, Not: ${m.description}').join('\n')}

Muayene Geçmişi:
${vehicleInspections.map((i) => '- Tarih: ${DateFormat('dd.MM.yyyy').format(i.date)}, Maliyet: ${i.cost}₺, Not: ${i.notes}').join('\n')}

Lütfen aşağıdaki konularda detaylı öneriler ver:

1. Bakım Önerileri:
   - Bir sonraki bakım için tahmini zaman ve kilometre
   - Dikkat edilmesi gereken özel durumlar
   - Mevsimsel bakım tavsiyeleri
   - Araç yaşına özel bakım önerileri

2. Muayene Durumu:
   - Bir sonraki muayene için hazırlık önerileri
   - Dikkat edilmesi gereken teknik konular
   - Yasal gereklilikler ve değişiklikler

3. Maliyet Optimizasyonu:
   - Bakım maliyetlerini düşürmek için öneriler
   - Yakıt tasarrufu için tavsiyeler
   - Uzun vadeli tasarruf stratejileri

4. Güvenlik Tavsiyeleri:
   - Araç yaşı ve kullanımına özel güvenlik kontrolleri
   - Mevsimsel güvenlik önlemleri
   - Kritik parçaların durumu ve kontrol periyotları

5. Performans İyileştirme:
   - Araç performansını optimize etme önerileri
   - Yakıt verimliliğini artırma yöntemleri
   - Sürüş alışkanlıkları ve etkileri

Her başlık için lütfen detaylı ve uygulanabilir öneriler ver. Öneriler araç yaşı, kullanım durumu ve bakım geçmişine özel olmalı.
''';

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo-16k',
          'messages': [
            {
              'role': 'system',
              'content': 'Sen bir araç bakım ve servis uzmanısın. Verilen bilgilere göre detaylı ve profesyonel öneriler sunuyorsun. Lütfen Türkçe karakterleri (ç, ş, ı, ğ, ö, ü, İ) doğru kullanmaya özen göster.',
            },
            {
              'role': 'user',
              'content': prompt,
            },
          ],
          'temperature': 0.7,
          'max_tokens': 4000,
          'top_p': 1,
          'frequency_penalty': 0,
          'presence_penalty': 0,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        _cachedInsights = data['choices'][0]['message']['content'];
        _lastInsightsTime = DateTime.now();
        return _cachedInsights!;
      } else {
        throw Exception('API isteği başarısız oldu: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('AI önerileri alınamadı: $e');
    }
  }

  Future<String> analyzeVehicle(Vehicle vehicle, {bool forceRefresh = false}) async {
    // Önbellekte varsa ve yenileme istenmemişse önbellekten döndür
    if (!forceRefresh && _vehicleAnalysis.containsKey(vehicle.id)) {
      return _vehicleAnalysis[vehicle.id]!;
    }

    final tests = PredefinedVehicleTest.getDefaultTests();
    final testsByCategory = groupBy(tests, (test) => test.name.split(' ')[0]);

    final prompt = '''
${vehicle.brand} ${vehicle.model} ${vehicle.year} model araç için aşağıdaki kontrol noktalarına göre detaylı analiz ve öneriler:

${testsByCategory.entries.map((entry) => '''
${entry.key} Kontrolleri:
${entry.value.map((test) => '- ${test.name}: ${test.description ?? ''} (Her ${test.daysInterval} günde bir veya ${test.kilometerInterval} km\'de bir kontrol)').join('\n')}
''').join('\n')}

Lütfen yukarıdaki kontrol noktalarını dikkate alarak:
1. Araç yaşı ve kilometresine göre öncelikli kontrol edilmesi gereken noktalar
2. Mevsimsel olarak dikkat edilmesi gereken kontroller
3. Güvenlik açısından kritik kontroller
4. Maliyet optimizasyonu için öneriler
5. Uzun vadeli bakım planlaması

konularında öneriler sun.''';

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'system',
              'content': 'Sen bir Türk araç uzmanısın. Lütfen Türkçe karakterleri (ç, ş, ı, ğ, ö, ü, İ) doğru kullanmaya özen göster.',
            },
            {
              'role': 'user',
              'content': prompt,
            }
          ],
          'temperature': 0.7,
          'max_tokens': 1000,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final analysis = data['choices'][0]['message']['content'];
        _vehicleAnalysis[vehicle.id] = analysis;
        return analysis;
      } else {
        throw Exception('API yanıt vermedi: ${response.statusCode}');
      }
    } catch (e) {
      return 'AI analizi alınamadı. Lütfen daha sonra tekrar deneyin.';
    }
  }

  Future<VehicleInsight> analyzeTestResults(String vehicleId, String comparison) async {
    final vehicleRepository = await _ref.read(vehicleRepositoryProvider.future);
    final vehicle = await vehicleRepository.getVehicleById(int.parse(vehicleId));
    
    if (vehicle == null) {
      throw Exception('Araç bulunamadı');
    }

    final prompt = '''
${vehicle.brand} ${vehicle.model} ${vehicle.year} model araç için test sonuçları karşılaştırması:

$comparison

Lütfen yukarıdaki test sonuçlarını analiz ederek:
1. Önemli değişiklikleri vurgula
2. Potansiyel sorunları tespit et
3. Öncelikli bakım önerilerinde bulun
4. Maliyet optimizasyonu için tavsiyelerde bulun
5. Uzun vadeli bakım planlaması için önerilerde bulun

Özellikle dikkat edilmesi gereken noktalar:
- Ölçüm değerlerindeki anormal değişimler
- Başarısız testler ve nedenleri
- Acil müdahale gerektiren durumlar
- Periyodik bakım zamanlaması
''';

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'system',
              'content': 'Sen bir araç test ve bakım uzmanısın. Verilen test sonuçlarını analiz ederek detaylı öneriler sunuyorsun.',
            },
            {
              'role': 'user',
              'content': prompt,
            }
          ],
          'temperature': 0.7,
          'max_tokens': 1000,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final analysis = data['choices'][0]['message']['content'];
        
        return VehicleInsight(
          vehicleId: int.parse(vehicleId),
          content: analysis,
          createdAt: DateTime.now(),
          vehicleBrand: vehicle.brand,
          vehicleModel: vehicle.model,
          vehiclePlate: vehicle.plate,
        );
      } else {
        throw Exception('API yanıt vermedi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('AI analizi alınamadı: $e');
    }
  }

  // Belirli bir aracın önbelleğini temizle
  void clearVehicleCache(int vehicleId) {
    _vehicleInsights.remove(vehicleId);
    _vehicleAnalysis.remove(vehicleId);
  }

  // Tüm önbelleği temizle
  void clearAllCache() {
    _vehicleInsights.clear();
    _vehicleAnalysis.clear();
  }
} 