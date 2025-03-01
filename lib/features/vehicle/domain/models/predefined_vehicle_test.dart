import 'package:isar/isar.dart';

part 'predefined_vehicle_test.g.dart';

enum TestType {
  boolean,
  measurement
}

@collection
class PredefinedVehicleTest {
  Id id = Isar.autoIncrement;
  
  @Index()
  late String name;
  
  late String question;
  
  String? description;
  
  @enumerated
  late TestType type;

  late int daysInterval;
  late int kilometerInterval;
  String? expectedValues;
  String? technicalDetails;

   PredefinedVehicleTest({
    required this.name,
    required this.question,
    this.description,
    required this.type,
    required this.daysInterval,
    required this.kilometerInterval,
    this.expectedValues,
    this.technicalDetails,
  });

  static List<PredefinedVehicleTest> getDefaultTests() {
    return [
      // Motor ve Performans
      PredefinedVehicleTest(
        name: 'Motor Yağı',
        question: 'Motor yağı seviyesi normal mi?',
        description: 'Motor yağı seviyesini kontrol edin. Yağ çubuğundaki seviye minimum ve maksimum çizgileri arasında olmalıdır.',
        type: TestType.boolean,
        daysInterval: 30,
        kilometerInterval: 1000,
        expectedValues: 'Minimum ve maksimum çizgileri arasında',
        technicalDetails: 'Motor soğukken ve düz zeminde ölçüm yapın',
      ),
      PredefinedVehicleTest(
        name: 'Motor Sesi',
        question: 'Motor düzgün ve normal sesle çalışıyor mu?',
        description: 'Motoru çalıştırın ve anormal ses olup olmadığını dinleyin.',
        type: TestType.boolean,
        daysInterval: 7,
        kilometerInterval: 500,
      ),

      // Frenler
      PredefinedVehicleTest(
        name: 'Fren Pedalı',
        question: 'Fren pedalı normal sertlikte mi?',
        description: 'Fren pedalına basın ve sertliğini kontrol edin. Pedal çok yumuşak veya sert olmamalıdır.',
        type: TestType.boolean,
        daysInterval: 7,
        kilometerInterval: 500,
      ),
      PredefinedVehicleTest(
        name: 'Fren Hidroliği',
        question: 'Fren hidrolik seviyesi normal mi?',
        description: 'Fren hidrolik deposundaki seviyeyi kontrol edin.',
        type: TestType.boolean,
        daysInterval: 30,
        kilometerInterval: 1000,
        expectedValues: 'MIN ve MAX çizgileri arasında',
      ),

      // Lastikler
      PredefinedVehicleTest(
        name: 'Lastik Basıncı',
        question: 'Lastik basınçları normal mi?',
        description: 'Tüm lastiklerin basıncını kontrol edin.',
        type: TestType.boolean,
        daysInterval: 14,
        kilometerInterval: 1000,
        expectedValues: 'Araç kılavuzunda belirtilen değerler',
      ),
      PredefinedVehicleTest(
        name: 'Lastik Diş Derinliği',
        question: 'Lastik diş derinliği yeterli mi?',
        description: 'Tüm lastiklerin diş derinliğini kontrol edin.',
        type: TestType.boolean,
        daysInterval: 30,
        kilometerInterval: 2000,
        expectedValues: 'Minimum 1.6 mm',
        technicalDetails: 'Diş derinliği ölçer ile ölçün',
      ),

      // Direksiyon
      PredefinedVehicleTest(
        name: 'Direksiyon Boşluğu',
        question: 'Direksiyonda anormal boşluk var mı?',
        description: 'Direksiyon simidini hafifçe sağa sola çevirin ve boşluk kontrolü yapın.',
        type: TestType.boolean,
        daysInterval: 30,
        kilometerInterval: 2000,
      ),
      PredefinedVehicleTest(
        name: 'Direksiyon Hidroliği',
        question: 'Hidrolik direksiyon yağı seviyesi normal mi?',
        description: 'Hidrolik direksiyon yağı deposundaki seviyeyi kontrol edin.',
        type: TestType.boolean,
        daysInterval: 30,
        kilometerInterval: 2000,
        expectedValues: 'MIN ve MAX çizgileri arasında',
      ),

      // Genel Durum
      PredefinedVehicleTest(
        name: 'Silecek Suyu',
        question: 'Silecek suyu seviyesi yeterli mi?',
        description: 'Silecek suyu deposundaki seviyeyi kontrol edin.',
        type: TestType.boolean,
        daysInterval: 14,
        kilometerInterval: 1000,
      ),
      PredefinedVehicleTest(
        name: 'Aydınlatmalar',
        question: 'Tüm aydınlatmalar çalışıyor mu?',
        description: 'Far, stop, sinyal ve diğer lambaları kontrol edin.',
        type: TestType.boolean,
        daysInterval: 7,
        kilometerInterval: 500,
      ),
    ];
  }
} 
