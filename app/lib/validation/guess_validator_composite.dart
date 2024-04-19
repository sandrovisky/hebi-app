import 'package:hebi/presentation/protocols/protocols.dart';
import 'package:hebi/validation/protocols/protocols.dart';

class GuessValidationComposite implements GuessValidation {
  final List<GuessFieldValidation> validations;

  GuessValidationComposite(this.validations);

  @override
  List<GuessValidationError> validate(String guess) {
    List<GuessValidationError> errors = [];
    GuessValidationError? error;
    for (final validation in validations) {
      error = validation.validate(guess);
      if (error != null) {
        if (!errors.contains(error)) errors.add(error);
      }
    }
    return errors;
  }
}
