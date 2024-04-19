import 'package:flutter/material.dart';
import 'package:hebi/ui/pages/jb/jb_insert_guess_page_components/components.dart';

class JbInsertGuessPage extends StatefulWidget {
  const JbInsertGuessPage({super.key});

  @override
  State<JbInsertGuessPage> createState() => _JbInsertGuessPageState();
}

class _JbInsertGuessPageState extends State<JbInsertGuessPage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const JbInsertGuessAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  JbInsertGuessField(controller: controller),
                  const JbInsertGuessErrorMessage(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      JbInsertGuessInsertButton(controller: controller),
                      const JbInsertGuessContinueButton(),
                    ],
                  ),
                ],
              ),
            ),
            const JbInsertGuessGrid(),
          ],
        ),
      ),
    );
  }
}
