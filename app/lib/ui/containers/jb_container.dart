import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hebi/ui/pages/jb/components/card_modality_menu.dart';

import './/presentation/blocs/jb/jb.dart';
import './/ui/mixins/mixins.dart';
import './/ui/pages/jb/jb.dart';
import './/ui/pages/pages.dart';

class JBContainer extends StatefulWidget {
  const JBContainer({Key? key}) : super(key: key);

  @override
  State<JBContainer> createState() => _JBContainerState();
}

class _JBContainerState extends State<JBContainer> with DomainErrorHandler {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<JBBloc>().add(GetShiftsJbEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JBBloc, JBState>(
      listener: (context, state) async {
        if (state is ErrorJBState) {
          await dialogDomainErrorHandler(context, state.error);
          if (context.mounted) Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is LoadedShiftsJBState) {
          return const ShiftsPage();
        }

        if (state is JbLoadingModalitiesPageState) {
          return const JbLoadingModalitiesPage();
        }

        if (state is LoadedModalitiesJBState) {
          return JbModalitiesSelectPage(state.modalities);
        }

        if (state is ModalitySelectedJBState) {
          return JbModalityDetailSelectPage(state.modality);
        }

        if (state is InsertingGuessJBState) {
          return const JbInsertGuessPage();
        }

        if (state is InsertValueJBState) {
          return JbInsertValuePage();
        }

        if (state is GameDetailsJBState) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(18),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: Colors.amber,
                      child: GridView(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 100,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                        ),
                        children: [
                          CardOptionMenu(
                            title: 'ENVIAR',
                            onTap: () {},
                          ),
                          CardOptionMenu(
                            title: 'CANCELAR',
                            onTap: () {},
                          ),
                          CardOptionMenu(
                            title: 'VALE',
                            onTap: () {},
                          ),
                          CardOptionMenu(
                            title: 'NOVA APOSTA',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    Text('data')
                  ],
                ),
              ),
            ),
          );
        }

        return const LoadingPage();
      },
    );
  }
}
