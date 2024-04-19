// ignore_for_file: public_member_api_docs, sort_constructors_first
import './/domain/entities/entities.dart';
import './/domain/helpers/helpers.dart';

abstract class JBState {}

class InitialJBState extends JBState {}

class LoadingJBState extends JBState {}

class JbLoadingModalitiesPageState extends JBState {}

class ErrorJBState extends JBState {
  final DomainError error;

  ErrorJBState(this.error);
}

class LoadedShiftsJBState extends JBState {
  final List<ShiftEntity> shifts;

  LoadedShiftsJBState(this.shifts);
}

class LoadedModalitiesJBState extends JBState {
  final List<ModalityEntity> modalities;

  LoadedModalitiesJBState(this.modalities);
}

class ModalitySelectedJBState extends JBState {
  final ModalityEntity modality;

  ModalitySelectedJBState(this.modality);
}

class InsertingGuessJBState extends JBState {
  final ModalityEntity modality;
  final List<GuessError> guessErrors;
  final bool guessIsValid;
  final String submodality;
  final String typedGuess;
  final List<String> guesses;

  InsertingGuessJBState({
    required this.modality,
    required this.guessErrors,
    required this.guessIsValid,
    required this.submodality,
    required this.typedGuess,
    required this.guesses,
  });

  InsertingGuessJBState copyWith({
    ModalityEntity? modality,
    List<GuessError>? guessErrors,
    bool? guessIsValid,
    String? typedGuess,
    List<String>? guesses,
    String? submodality,
  }) {
    return InsertingGuessJBState(
      modality: modality ?? this.modality,
      guessErrors: guessErrors ?? this.guessErrors,
      guessIsValid: guessIsValid ?? this.guessIsValid,
      typedGuess: typedGuess ?? this.typedGuess,
      guesses: guesses ?? this.guesses,
      submodality: submodality ?? this.submodality,
    );
  }
}

class InsertValueJBState extends JBState {
  final String modality;
  final String submodality;
  final List<String> guesses;
  final double value;

  InsertValueJBState({
    required this.modality,
    required this.submodality,
    required this.guesses,
    this.value = 0,
  });

  InsertValueJBState copyWith({
    String? modality,
    String? submodality,
    List<String>? guesses,
    double? value,
  }) {
    return InsertValueJBState(
      modality: modality ?? this.modality,
      submodality: submodality ?? this.submodality,
      guesses: guesses ?? this.guesses,
      value: value ?? this.value,
    );
  }
}

class GameDetailsJBState extends JBState {
  final OrderEntity order;
  final BetEntity actualBet;

  GameDetailsJBState({
    required this.order,
    required this.actualBet,
  });

  GameDetailsJBState copyWith({
    OrderEntity? order,
    BetEntity? actualBet,
  }) {
    return GameDetailsJBState(
      order: order ?? this.order,
      actualBet: actualBet ?? this.actualBet,
    );
  }
}
