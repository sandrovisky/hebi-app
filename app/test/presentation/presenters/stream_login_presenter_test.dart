import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

abstract class Validation {
  String validate({required String field, required String value});
}

class StreamLoginPresenter {
  final Validation validation;

  StreamLoginPresenter({required this.validation});

  void validateCode(String code) {
    validation.validate(field: 'code', value: code);
  }
}

class ValidationSpy extends Mock implements Validation {}

void main() {
  test('should call validation with correct email', () {
    final validation = ValidationSpy();
    final sut = StreamLoginPresenter(validation: validation);
    final code = faker.internet.random.integer(999999).toString();
    when(
      () => validation.validate(
        field: any(named: 'field'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((invocation) => '');
    sut.validateCode(code);
    verify(() => validation.validate(field: 'code', value: code)).called(1);
  });
}
