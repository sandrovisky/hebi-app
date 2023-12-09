import 'package:hebi/data/models/remote_shift_model.dart';

import './/data/cache/cache.dart';
import './/data/http/http.dart';
import './/data/repositories/repositories.dart';
import './/domain/entities/entities.dart';
import './/domain/helpers/helpers.dart';
import './/domain/repositories/repositories.dart';

class ShiftsRepository with IBaseRepository implements IShiftsRepository {
  final IHttpClient httpClient;
  final ICacheStorage cacheStorage;

  ShiftsRepository({required this.httpClient, required this.cacheStorage});

  @override
  Future<List<ShiftEntity>> getOpens() async {
    try {
      final api = await cacheStorage.fetch('apiURL');
      final httpResponse = await httpClient.request(
        url: '$api/v2/android/get-open-shifts/',
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
}
