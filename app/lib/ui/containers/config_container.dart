import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './/ui/pages/pages.dart';
import './/presentation/blocs/blocs.dart';

class ConfigContainer extends StatelessWidget {
  const ConfigContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is ErrorSettingsState) {
          ErrorDialog(error: state.error, context: context);
        }
      },
      builder: (context, state) {
        if (state is InitialSettingsState) return const ConfigPage();

        return const LoadingPage();
      },
    );
  }
}
