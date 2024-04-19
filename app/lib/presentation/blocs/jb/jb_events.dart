import './/domain/entities/entities.dart';

abstract class JbEvent {}

class GetShiftsJbEvent extends JbEvent {}

class GetGamesJbEvent extends JbEvent {
  final List<ShiftEntity> shifts;

  GetGamesJbEvent(this.shifts);
}

class BackToShiftsPageJbEvent extends JbEvent {}

class BackToModalitiesPageJbEvent extends JbEvent {}

class BackToModalityDetailPageJbEvent extends JbEvent {}

class BackToGuesesPageJbEvent extends JbEvent {}

class SelectModalityJbEvent extends JbEvent {
  final ModalityEntity modality;

  SelectModalityJbEvent(this.modality);
}

class ChangeSelectedShiftJbEvent extends JbEvent {
  final ShiftEntity shift;

  ChangeSelectedShiftJbEvent(this.shift);
}

class SelectModalityDetailJbEvent extends JbEvent {
  final ModalityEntity modality;
  final String submodality;

  SelectModalityDetailJbEvent(this.modality, this.submodality);
}

class ChangeGameValueJbEvent extends JbEvent {
  final String value;

  ChangeGameValueJbEvent(this.value);
}

class InsertGuessJbEvent extends JbEvent {
  final String guess;

  InsertGuessJbEvent(this.guess);
}

class ChangeGuessJbEvent extends JbEvent {
  final String guess;

  ChangeGuessJbEvent(this.guess);
}

class RemoveGuessJbEvent extends JbEvent {
  final String guess;

  RemoveGuessJbEvent(this.guess);
}

class FinishGuessesJbEvent extends JbEvent {
  final String modality;
  final String submodality;
  final List<String> guesses;

  FinishGuessesJbEvent({
    required this.modality,
    required this.submodality,
    required this.guesses,
  });
}

class CreateProductJbEvent extends JbEvent {
  final String modality;
  final String submodality;
  final List<String> guesses;
  final double value;

  CreateProductJbEvent({
    required this.modality,
    required this.submodality,
    required this.guesses,
    required this.value,
  });

  CreateProductJbEvent copyWith({
    String? modality,
    String? submodality,
    List<String>? guesses,
    double? value,
  }) {
    return CreateProductJbEvent(
      modality: modality ?? this.modality,
      submodality: submodality ?? this.submodality,
      guesses: guesses ?? this.guesses,
      value: value ?? this.value,
    );
  }
}
