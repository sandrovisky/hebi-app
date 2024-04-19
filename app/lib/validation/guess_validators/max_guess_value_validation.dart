import 'package:equatable/equatable.dart';
import 'package:hebi/presentation/protocols/protocols.dart';
import 'package:hebi/validation/protocols/protocols.dart';

class MaxGuessValueValidation extends Equatable
    implements GuessFieldValidation {
  final int maxLength;

  const MaxGuessValueValidation(this.maxLength);

  @override
  GuessValidationError? validate(String guess) {
    if (guess.isEmpty) return GuessValidationError.invalidSize;
    if (guess.length % 2 != 0) return GuessValidationError.isNotPair;

    for (int i = 0; i < guess.length; i += 2) {
      int number = int.parse(guess.substring(i, i + 2));

      if (number > maxLength) {
        return GuessValidationError.valueToHigh;
      }
    }

    return null;
  }

  @override
  List get props => [maxLength];
}
