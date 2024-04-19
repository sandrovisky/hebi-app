import 'package:equatable/equatable.dart';
import 'package:hebi/presentation/protocols/protocols.dart';
import 'package:hebi/validation/protocols/protocols.dart';

class MinAndMaxLengthValidation extends Equatable
    implements GuessFieldValidation {
  final int minLength;
  final int maxLength;

  const MinAndMaxLengthValidation(this.minLength, this.maxLength);

  @override
  GuessValidationError? validate(String guess) {
    if (guess.isEmpty) return GuessValidationError.invalidSize;

    if (guess.length >= minLength && guess.length <= maxLength) {
      return null;
    }

    return GuessValidationError.invalidSize;
  }

  @override
  List get props => [minLength, maxLength];
}
