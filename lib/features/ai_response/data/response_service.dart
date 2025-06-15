import 'package:winkr/features/ai_response/domain/response_model.dart';

import '../domain/response_repository.dart';
import 'response_mock_data.dart';

class ResponseService implements ResponseRepository {
  @override
  Future<Response> getReponse(String traits) async {
    await Future.delayed(Duration(seconds: 5));

    final match = groupedDatingBios.firstWhere(
      (group) => traits.toLowerCase().contains(
        _getKeywordFromIntro(group['intro'] as String),
      ),
      orElse: () => groupedDatingBios.first,
    );

    final bios = match['bios'] as List<dynamic>;

    return Response(
      intro: match['intro'] as String,
      bioOne: bios[0]['text'],
      bioTwo: bios[1]['text'],
      bioThree: bios[2]['text'],
    );
  }

  // Helper to find keywords to match
  String _getKeywordFromIntro(String intro) {
    if (intro.contains('bookworm')) return 'bookworm';
    if (intro.contains('Adventurous')) return 'adventurous';
    return '';
  }
}
