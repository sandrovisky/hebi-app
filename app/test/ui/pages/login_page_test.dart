import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:app/layers/presentation/pages/pages.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  LoginPresenterSpy presenter = LoginPresenterSpy();

  Future<void> loadPage(WidgetTester tester) async {
    final loginPage = MaterialApp(home: LoginPage(presenter: presenter));
    await tester.pumpWidget(loginPage);
  }

  testWidgets(
    'should load with correct initial state, with no errors',
    (WidgetTester tester) async {
      await loadPage(tester);

      final userTexts = find.descendant(
        of: find.widgetWithText(TextFormField, 'Codigo'),
        matching: find.text(' '),
      );

      final passwordTexts = find.descendant(
        of: find.widgetWithText(TextFormField, 'Senha'),
        matching: find.text(' '),
      );

      expect(
        userTexts,
        findsOneWidget,
        reason:
            '''teste verifica se no TextFormField de Codigo inicia com alguma mensagem de erro, 
						procurando um unico Text que deve ser uma string com um espaço em branco, 
						usado para preencher espaço reservado para mensagem de erro''',
      );
      expect(
        passwordTexts,
        findsOneWidget,
        reason:
            '''teste verifica se no TextFormField de Senha inicia com alguma mensagem de erro, 
						procurando um unico Text que deve ser uma string com um espaço em branco, 
						usado para preencher espaço reservado para mensagem de erro''',
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));

      expect(button.onPressed, null);
    },
  );

  testWidgets(
    'should call validate with correct values',
    (WidgetTester tester) async {
      await loadPage(tester);

      final code = faker.currency.random.numberOfLength(6);

      await tester.enterText(
          find.widgetWithText(TextFormField, 'Codigo'), code);

      verify(() => presenter.validateCode(code));

      final password = faker.currency.random.numberOfLength(6);

      await tester.enterText(
          find.widgetWithText(TextFormField, 'Senha'), password);

      verify(() => presenter.validatePassword(password));
    },
  );
}
