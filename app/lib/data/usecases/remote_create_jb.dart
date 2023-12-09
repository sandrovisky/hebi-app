import 'package:flutter/foundation.dart';
import 'package:hebi/domain/entities/entities.dart';
import 'package:hebi/domain/usecases/create_jb.dart';

import './/domain/repositories/repositories.dart';

class RemoteCreateJb implements ICreateJb {
  final IShiftsRepository shiftsRepository;

  RemoteCreateJb({required this.shiftsRepository});

  @override
  Future<List<ShiftEntity>> getOpenShifts() async {
    try {
      return await shiftsRepository.getOpens();
    } catch (error) {
      debugPrint('RemoteCreateJb: $error');
      rethrow;
    }
  }
}
