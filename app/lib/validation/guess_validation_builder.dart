import 'package:hebi/validation/guess_validators/guess_validators.dart';
import './protocols/protocols.dart';

class GuessValidationBuilder {
  List<GuessFieldValidation> validations = [];

  GuessValidationBuilder maxValue(int maxValue) {
    validations.add(MaxGuessValueValidation(maxValue));
    return this;
  }

  GuessValidationBuilder lengthValidate(int min, int max) {
    validations.add(MinAndMaxLengthValidation(min, max));
    return this;
  }

  List<GuessFieldValidation> build() => validations;
}
