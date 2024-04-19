import 'package:flutter/material.dart';

class JbLoadingModalitiesPage extends StatelessWidget {
  const JbLoadingModalitiesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text('Carregando Modalidades...')
          ],
        ),
      ),
    );
  }
}
