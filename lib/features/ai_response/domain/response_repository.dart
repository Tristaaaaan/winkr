import 'package:winkr/features/ai_response/domain/response_model.dart';

abstract class ResponseRepository {
  Future<Response> getReponse(String traits);
}
