import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

abstract class Validation {
  String validate({required String field, required String value});
}

class LoginState {
  late String codeError;
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();

  final _state = LoginState();

  Stream<String> get codeErrorStream => _controller.stream
      .map(
        (state) => state.codeError,
      )
      .distinct();

  StreamLoginPresenter({required this.validation});

  void validateCode(String code) {
    _state.codeError = validation.validate(field: 'code', value: code);
    _controller.add(_state);
  }
}

class ValidationSpy extends Mock implements Validation {}

void main() {
  late ValidationSpy validation;
  late StreamLoginPresenter sut;
  late String code;

  mockValidationCall({String? field}) {
    return when(
      () => validation.validate(
        field: field ?? any(named: 'field'),
        value: any(named: 'value'),
      ),
    );
  }

  mockValidation({String? field, required String error}) {
    mockValidationCall(field: field).thenReturn(error);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    code = faker.internet.random.integer(999999).toString();
  });

  test('should call validation with correct code', () {
    mockValidation(error: '');

    sut.validateCode(code);

    verify(() => validation.validate(field: 'code', value: code)).called(1);
  });

  test('should emit code if validation fails', () {
    mockValidation(error: 'any error');

    sut.codeErrorStream
        .listen(expectAsync1((error) => expect(error, 'any error')));

    sut.validateCode(code);
    sut.validateCode(code);
  });
}
