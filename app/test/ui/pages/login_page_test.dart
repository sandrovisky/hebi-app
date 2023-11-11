import 'dart:async';

import 'package:app/presentation/containers/login_container.dart';
import 'package:app/presentation/core/basic_controller.dart';
import 'package:app/presentation/presenters/presenters.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:app/presentation/pages/pages.dart';
import 'package:provider/provider.dart';

class LoginPresenterSpy extends Mock implements ILoginPresenter {}

void main() {
  late LoginPresenterSpy presenter = LoginPresenterSpy();

  setUp(
    () {
      presenter = LoginPresenterSpy();
    },
  );

  tearDown(() {});

  Future<void> loadPage(WidgetTester tester) async {
    final loginPage = ChangeNotifierProvider<ILoginPresenter>(
      create: (context) => presenter,
      child: const MaterialApp(
        home: LoginContainer(),
      ),
    );
    await tester.pumpWidget(loginPage);
  }

  testWidgets(
    'should load with correct initial state, with no errors',
    (WidgetTester tester) async {
      when(() => presenter.value).thenReturn(LoginInitialState());
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

  // testWidgets(
  //   'should call validate with correct values',
  //   (WidgetTester tester) async {
  //     await loadPage(tester);

  //     final code = faker.currency.random.numberOfLength(6);

  //     await tester.enterText(
  //         find.widgetWithText(TextFormField, 'Codigo'), code);

  //     verify(() => presenter.validateCode(code));

  //     final password = faker.currency.random.numberOfLength(6);

  //     await tester.enterText(
  //         find.widgetWithText(TextFormField, 'Senha'), password);

  //     verify(() => presenter.validatePassword(password));
  //   },
  // );

  // testWidgets(
  //   'should present error if code is invalid',
  //   (WidgetTester tester) async {
  //     await loadPage(tester);

  //     codeErrorController.add('error');
  //     await tester.pump();

  //     expect(find.text('error'), findsOneWidget);
  //   },
  // );

  // testWidgets(
  //   'should present no error if code is valid',
  //   (WidgetTester tester) async {
  //     await loadPage(tester);

  //     codeErrorController.add('');
  //     await tester.pump();

  //     final codeTexts = find.descendant(
  //       of: find.widgetWithText(TextFormField, 'Codigo'),
  //       matching: find.text(' '),
  //     );

  //     expect(
  //       codeTexts,
  //       findsOneWidget,
  //     );
  //   },
  // );

  // testWidgets(
  //   'should present error if password is invalid',
  //   (WidgetTester tester) async {
  //     await loadPage(tester);

  //     passwordErrorController.add('error');
  //     await tester.pump();

  //     expect(find.text('error'), findsOneWidget);
  //   },
  // );

  // testWidgets(
  //   'should present no error if password is valid',
  //   (WidgetTester tester) async {
  //     await loadPage(tester);

  //     passwordErrorController.add('');
  //     await tester.pump();

  //     final passwordTexts = find.descendant(
  //       of: find.widgetWithText(TextFormField, 'Senha'),
  //       matching: find.text(' '),
  //     );

  //     expect(
  //       passwordTexts,
  //       findsOneWidget,
  //     );
  //   },
  // );

  // testWidgets(
  //   'should enable form button if form is valid',
  //   (WidgetTester tester) async {
  //     await loadPage(tester);

  //     isFormValidController.add(true);
  //     await tester.pump();

  //     final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));

  //     expect(button.onPressed, isNotNull);
  //   },
  // );

  // testWidgets(
  //   'should disables form button if form is invalid',
  //   (WidgetTester tester) async {
  //     await loadPage(tester);

  //     isFormValidController.add(false);
  //     await tester.pump();

  //     final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));

  //     expect(button.onPressed, isNull);
  //   },
  // );

  // testWidgets(
  //   'shouldcall authentication on form submit',
  //   (WidgetTester tester) async {
  //     await loadPage(tester);

  //     isFormValidController.add(true);
  //     await tester.pump();
  //     await tester.tap(find.byType(ElevatedButton));

  //     verify(() => presenter.auth()).called(1);
  //   },
  // );

  // testWidgets(
  //   'should present loading',
  //   (WidgetTester tester) async {
  //     await loadPage(tester);

  //     basicController.add(LoadingControllerState());
  //     await tester.pump();

  //     expect(find.byType(LoginLoadingPage), findsOneWidget);
  //   },
  // );

  // testWidgets(
  //   'should hide loading',
  //   (WidgetTester tester) async {
  //     await loadPage(tester);

  //     basicController.add(LoadingControllerState());

  //     expect(find.byType(LoginLoadingPage), findsNothing);
  //   },
  // );

  // testWidgets(
  //   'should present error message if authentication fails',
  //   (WidgetTester tester) async {
  //     await loadPage(tester);

  //     basicController.add(ErrorControllerState('any error'));
  //     await tester.pump();

  //     expect(find.text('any error'), findsOneWidget);
  //   },
  // );

  // testWidgets(
  //   'should close streams on dispose',
  //   (WidgetTester tester) async {
  //     await loadPage(tester);

  //     addTearDown(() => verify(() => presenter.dispose()).called(1));
  //   },
  // );
}
