import 'package:isar/isar.dart';

part 'expertise_model.g.dart';

@Collection()
class Expertise {
  Expertise({
    this.id = Isar.autoIncrement,
    required this.vehicleId,
    required this.date,
    required this.center,
    required this.cost,
    required this.report,
    this.notes,
    this.images,
  });

  Id id;
  
  @Index(type: IndexType.value)
  final int vehicleId;
  
  @Index(type: IndexType.value)
  final DateTime date;
  
  @Index(type: IndexType.value)
  final String center;
  
  @Index(type: IndexType.value)
  final double cost;
  final String report; // JSON string olarak saklayacağız
  final String? notes;
  final List<String>? images;

  Expertise copyWith({
    Id? id,
    int? vehicleId,
    DateTime? date,
    String? center,
    double? cost,
    String? report,
    String? notes,
    List<String>? images,
  }) {
    return Expertise(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      date: date ?? this.date,
      center: center ?? this.center,
      cost: cost ?? this.cost,
      report: report ?? this.report,
      notes: notes ?? this.notes,
      images: images ?? this.images,
    );
  }
} 