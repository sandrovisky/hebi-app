import 'package:app/layers/domain/usecases/authentication.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:app/layers/presentation/presenters/presenters.dart';
import 'package:app/layers/presentation/presenters/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}

class AuthenticationSpy extends Mock implements Authentication {}

void main() {
  late ValidationSpy validation;
  late StreamLoginPresenter sut;
  late String code;
  late String password;
  late AuthenticationSpy authentication;

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
    authentication = AuthenticationSpy();
    validation = ValidationSpy();
    sut = StreamLoginPresenter(
        validation: validation, authentication: authentication);
    code = faker.internet.random.integer(999999).toString();
    password = faker.internet.random.integer(999999).toString();

    mockValidation(error: '');
  });

  test('should call validation with correct code', () {
    sut.validateCode(code);

    verify(() => validation.validate(field: 'code', value: code)).called(1);
  });

  test('should emit code error if validation fails', () {
    mockValidation(error: 'any error');

    sut.codeErrorStream
        .listen(expectAsync1((error) => expect(error, 'any error')));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateCode(code);
    sut.validateCode(code);
  });

  test('should emit a empty string if code validation succeeds', () {
    mockValidation(error: '');

    sut.codeErrorStream.listen(expectAsync1((error) => expect(error, '')));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateCode(code);
    sut.validateCode(code);
  });

  test('should call validation with correct password', () {
    sut.validatePassword(password);

    verify(() => validation.validate(field: 'password', value: password))
        .called(1);
  });

  test('should emit password error if validation fails', () {
    mockValidation(error: 'any error');

    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, 'any error')));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('should emit a empty string if password validation succeeds', () {
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, '')));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('should emit code error and passwords valid', () {
    mockValidation(error: 'any error', field: 'code');

    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, '')));
    sut.codeErrorStream
        .listen(expectAsync1((error) => expect(error, 'any error')));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validateCode(code);
  });

  test('should emits a valid form', () async {
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, '')));
    sut.codeErrorStream.listen(expectAsync1((error) => expect(error, '')));
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validatePassword(password);
    await Future.delayed(Duration.zero);
    sut.validateCode(code);
  });

  test('should call Authentication with correct values', () async {
    sut.validateCode(code);
    sut.validatePassword(password);

    await sut.auth();

    verify(() => authentication.auth(
            params: AuthenticationParams(user: code, password: password)))
        .called(1);
  });
}
