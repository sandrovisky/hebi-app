import './/data/models/remote_modalities_menu_model.dart';

import './/data/http/http.dart';
import './/data/models/remote_shift_model.dart';
import './/data/repositories/repositories.dart';
import './/domain/entities/entities.dart';
import './/domain/helpers/helpers.dart';
import './/domain/repositories/repositories.dart';

class CreateJbRepository with IBaseRepository implements ICreateJbRepository {
  final IHttpClient httpClient;

  CreateJbRepository({required this.httpClient});

  @override
  Future<List<ShiftEntity>> getOpens() async {
    try {
      final httpResponse = await httpClient.request(
        url: '/v2/android/get-open-shifts/',
        method: 'get',
      );

      final mapShifts = httpResponse['shifts'] as List;

      return mapShifts
          .map((map) => RemoteShiftModel.fromMap(map).toEntity())
          .toList();
    } on Http401Error catch (error) {
      throw handle401Error(error);
    } on HttpError catch (_) {
      throw DomainError.unexpected;
    }
  }

  @override
  Future<List<ModalityEntity>> fetchGames() async {
    try {
      final httpResponse = await httpClient.request(
        url: '/v2/android/get-games-modalities/',
        method: 'get',
      );

      final mapGames = httpResponse['games'] as List;

      return mapGames
          .map((map) => RemoteModalityModel.fromMap(map).toEntity())
          .toList();
    } on Http401Error catch (error) {
      throw handle401Error(error);
    } on HttpError catch (_) {
      throw DomainError.unexpected;
    }
  }
}
