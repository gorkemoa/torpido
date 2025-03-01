import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:torpido/core/services/ai_service.dart';
import 'package:torpido/core/services/isar_service.dart';

part 'service_providers.g.dart';

@riverpod
AIService aiService(AiServiceRef ref) {
  final apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
  return AIService(apiKey, ref);
}

final isarServiceProvider = Provider((ref) => IsarService()); 