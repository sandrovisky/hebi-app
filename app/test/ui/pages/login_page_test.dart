import 'package:app/layers/presentation/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> loadPage(WidgetTester tester) async {
    const loginPage = MaterialApp(home: LoginPage());
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
}
