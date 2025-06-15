import 'package:winkr/features/ai_response/domain/response_model.dart';
import 'package:winkr/features/ai_response/domain/response_repository.dart';

class ResponseUseCase {
  final ResponseRepository repository;

  ResponseUseCase(this.repository);

  Future<Response?> execute(String traits) async {
    return await repository.getReponse(traits);
  }
}
