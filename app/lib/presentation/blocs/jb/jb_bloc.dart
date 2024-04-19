import 'package:bloc/bloc.dart';
import 'package:hebi/presentation/protocols/protocols.dart';
import 'package:hebi/validation/validation.dart';
import 'package:hebi/validation/guess_validators/guess_validators.dart';

import './/domain/entities/entities.dart';
import './/domain/helpers/helpers.dart';
import './/domain/usecases/usecases.dart';

import './jb.dart';

class JBBloc extends Bloc<JbEvent, JBState> {
  final ICreateJb useCase;

  JBBloc({required this.useCase}) : super(InitialJBState()) {
    on<GetShiftsJbEvent>(_getShifts);

    on<ChangeSelectedShiftJbEvent>(_changeSelectedShift);

    on<GetGamesJbEvent>(_getGames);

    on<BackToShiftsPageJbEvent>(_backToShifts);

    on<BackToModalitiesPageJbEvent>(_backToModalities);

    on<BackToModalityDetailPageJbEvent>(_backToModalityDetail);

    on<BackToGuesesPageJbEvent>(_backToGuesses);

    on<SelectModalityJbEvent>(_selectModality);

    on<SelectModalityDetailJbEvent>(_selectModalityDetail);

    on<ChangeGameValueJbEvent>(_validateValue);

    on<ChangeGuessJbEvent>(_changeGuess);

    on<InsertGuessJbEvent>(_insertGuess);

    on<RemoveGuessJbEvent>(_removeGuess);

    on<FinishGuessesJbEvent>(_finishGuesses);

    on<CreateProductJbEvent>(_finishProduct);
  }

  List<ShiftEntity> _shifts = [];
  late ModalityEntity _selectedModalityMenu;
  List<ModalityEntity> _modalities = [];
  late GuessValidation _validation;
  late InsertingGuessJBState _gameInProgress;
  late InsertValueJBState _insertValueJBState;
  late GameDetailsJBState _gameDetailsJBState;

  void _getShifts(GetShiftsJbEvent event, Emitter<JBState> emit) async {
    emit(LoadingJBState());
    try {
      _shifts = await useCase.getOpenShifts();
      emit(LoadedShiftsJBState(_shifts));
    } on DomainError catch (error) {
      emit(ErrorJBState(error));
    } catch (_) {
      emit(ErrorJBState(DomainError.unexpected));
    }
  }

  void _changeSelectedShift(
    ChangeSelectedShiftJbEvent event,
    Emitter<JBState> emit,
  ) async {
    for (var shift in _shifts) {
      if (shift.number == event.shift.number) {
        shift.isSelected = !shift.isSelected;
      }
    }

    emit(LoadedShiftsJBState(_shifts));
  }

  void _getGames(GetGamesJbEvent event, Emitter<JBState> emit) async {
    emit(JbLoadingModalitiesPageState());

    _gameDetailsJBState = GameDetailsJBState(
      order: OrderEntity(shifts: event.shifts, bets: []),
      actualBet: BetEntity(),
    );

    try {
      if (_modalities.isEmpty) {
        _modalities = await useCase.fetchGames();
      }

      emit(LoadedModalitiesJBState(_modalities));
    } on DomainError catch (error) {
      emit(ErrorJBState(error));
    } catch (_) {
      emit(ErrorJBState(DomainError.unexpected));
    }
  }

  void _backToShifts(BackToShiftsPageJbEvent event, Emitter<JBState> emit) {
    emit(LoadedShiftsJBState(_shifts));
  }

  void _backToModalities(
    BackToModalitiesPageJbEvent event,
    Emitter<JBState> emit,
  ) {
    emit(LoadedModalitiesJBState(_modalities));
  }

  void _backToModalityDetail(
    BackToModalityDetailPageJbEvent event,
    Emitter<JBState> emit,
  ) {
    emit(ModalitySelectedJBState(_selectedModalityMenu));
  }

  void _backToGuesses(
    BackToGuesesPageJbEvent event,
    Emitter<JBState> emit,
  ) {
    emit(_gameInProgress);
  }

  void _selectModality(SelectModalityJbEvent event, Emitter<JBState> emit) {
    _selectedModalityMenu = event.modality;
    emit(ModalitySelectedJBState(_selectedModalityMenu));
  }

  void _selectModalityDetail(
    SelectModalityDetailJbEvent event,
    Emitter<JBState> emit,
  ) {
    _gameInProgress = InsertingGuessJBState(
      guesses: [],
      typedGuess: '',
      modality: event.modality,
      guessErrors: [],
      guessIsValid: false,
      submodality: event.submodality,
    );

    _validation = _buildValidation(event.modality);

    emit(_gameInProgress);
  }

  void _validateValue(ChangeGameValueJbEvent event, Emitter<JBState> emit) {
    try {
      final raw = event.value.replaceAll(RegExp('[^0-9]'), '');
      final value = double.parse(raw);
      _insertValueJBState = _insertValueJBState.copyWith(
        value: value / 100,
      );

      emit(_insertValueJBState);
    } catch (e) {
      emit(_insertValueJBState);
    }
  }

  void _changeGuess(ChangeGuessJbEvent event, Emitter<JBState> emit) {
    final errors = _validateGuess(event.guess);
    _gameInProgress = _gameInProgress.copyWith(
      typedGuess: event.guess,
      guessErrors: errors,
      guessIsValid: errors.isEmpty && event.guess.isNotEmpty,
    );

    emit(_gameInProgress);
  }

  void _insertGuess(InsertGuessJbEvent event, Emitter<JBState> emit) {
    final guesses = _gameInProgress.guesses;
    guesses.add(event.guess);
    _gameInProgress = _gameInProgress.copyWith(
      guesses: guesses,
      typedGuess: '',
    );

    emit(_gameInProgress);
  }

  void _removeGuess(RemoveGuessJbEvent event, Emitter<JBState> emit) {
    final guesses = _gameInProgress.guesses;
    guesses.remove(event.guess);
    _gameInProgress = _gameInProgress.copyWith(guesses: guesses);

    emit(_gameInProgress);
  }

  GuessValidationComposite _buildValidation(ModalityEntity modality) {
    return GuessValidationComposite([
      MinAndMaxLengthValidation(modality.minLength, modality.maxLength),
      if (modality.isGroup) const MaxGuessValueValidation(25),
      if (modality.isCaixa) MaxGuessValueValidation(modality.maxValue),
    ]);
  }

  List<GuessError> _validateGuess(String guess) {
    if (guess.isEmpty) return [];

    final validationErrors = _validation.validate(guess);
    final errors = <GuessError>[];
    for (var error in validationErrors) {
      switch (error) {
        case GuessValidationError.valueToHigh:
          errors.add(GuessError.greaterThan);
          break;
        case GuessValidationError.isNotPair:
          errors.add(GuessError.pairRequired);
          break;
        case GuessValidationError.invalidSize:
          errors.add(GuessError.invalidLength);
          break;
      }
    }
    return errors;
  }

  void _finishGuesses(FinishGuessesJbEvent event, Emitter<JBState> emit) {
    _insertValueJBState = InsertValueJBState(
      guesses: event.guesses,
      modality: event.modality,
      submodality: event.submodality,
    );

    emit(_insertValueJBState);
  }

  void _finishProduct(CreateProductJbEvent event, Emitter<JBState> emit) {
    BetEntity cloneBet = _gameDetailsJBState.actualBet.copyWith();
    if (_gameDetailsJBState.actualBet.guesses.isEmpty) {
      cloneBet = cloneBet.copyWith(guesses: event.guesses);
      //_gameDetailsJBState = _gameDetailsJBState.copyWith(actualBet: cloneBet);
    }

    List<ProductEntity> products = [];
    products.addAll(cloneBet.products);
    products.add(ProductEntity(
      modality: event.modality,
      submodality: event.submodality,
      value: event.value,
    ));
    cloneBet = cloneBet.copyWith(products: products);
    _gameDetailsJBState = _gameDetailsJBState.copyWith(actualBet: cloneBet);

    emit(_gameDetailsJBState);
  }
}
