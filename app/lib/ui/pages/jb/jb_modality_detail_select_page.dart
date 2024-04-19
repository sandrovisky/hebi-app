// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hebi/domain/entities/entities.dart';

import './/presentation/blocs/jb/jb.dart';
import './/ui/pages/jb/components/components.dart';

class JbModalityDetailSelectPage extends StatelessWidget {
  const JbModalityDetailSelectPage(this.selectedModality, {Key? key})
      : super(key: key);
  final ModalityEntity selectedModality;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<JBBloc>();
    final subs = selectedModality.details;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => bloc.add(BackToModalitiesPageJbEvent()),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          selectedModality.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: subs.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 1.5,
          ),
          itemBuilder: (context, index) => CardOptionMenu(
            title: subs[index],
            onTap: () => bloc.add(
              SelectModalityDetailJbEvent(selectedModality, subs[index]),
            ),
          ),
        ),
      ),
    );
  }
}
