abstract class GuessValidation {
  List<GuessValidationError> validate(String guess);
}

enum GuessValidationError { valueToHigh, isNotPair, invalidSize }
