import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './/presentation/blocs/settings/settings.dart';
import './/ui/pages/pages.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is ErrorSettingsState) {
          ErrorDialog(error: state.error, context: context);
        }
      },
      builder: (context, state) {
        if (state is InitialSettingsState) return const SettingsPage();

        return const LoadingPage();
      },
    );
  }
}
