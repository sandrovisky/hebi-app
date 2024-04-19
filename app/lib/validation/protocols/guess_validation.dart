import './/presentation/protocols/protocols.dart';

abstract class GuessFieldValidation {
  GuessValidationError? validate(String guess);
}
