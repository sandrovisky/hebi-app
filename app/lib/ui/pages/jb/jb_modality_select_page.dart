// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hebi/domain/entities/entities.dart';

import './/presentation/blocs/jb/jb.dart';
import './/ui/pages/jb/components/components.dart';

class JbModalitiesSelectPage extends StatelessWidget {
  const JbModalitiesSelectPage(
    this.modalities, {
    Key? key,
  }) : super(key: key);
  final List<ModalityEntity> modalities;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<JBBloc>();
    final modalities = (bloc.state as LoadedModalitiesJBState).modalities;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () =>
              context.read<JBBloc>().add(BackToShiftsPageJbEvent()),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: modalities.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 1.5,
          ),
          itemBuilder: (context, index) => CardOptionMenu(
            title: modalities[index].acronym,
            subtitle: modalities[index].name,
            onTap: () => bloc.add(SelectModalityJbEvent(modalities[index])),
          ),
        ),
      ),
    );
  }
}
