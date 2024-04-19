import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hebi/ui/pages/widgets/widgets.dart';
import 'package:intl/intl.dart';

import './/presentation/blocs/jb/jb.dart';

class JbInsertValuePage extends StatelessWidget {
  JbInsertValuePage({Key? key}) : super(key: key);
  final focus = FocusNode();
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<JBBloc>();
    final state = bloc.state as InsertValueJBState;
    focus.requestFocus();
    var formatter = NumberFormat.currency(locale: 'pt_BR', symbol: '');
    var formattedValue = formatter.format(state.value).trim();
    controller.text = formattedValue;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => bloc.add(BackToGuesesPageJbEvent()),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          '${state.modality} + ${state.submodality}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  prefix: Text('R\$  ', style: TextStyle(fontSize: 18)),
                ),
                focusNode: focus,
                controller: controller,
                onChanged: (value) {
                  bloc.add(ChangeGameValueJbEvent(
                    value.isNotEmpty ? value : '0',
                  ));
                },
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
              ),
              DefaultButton(
                enabled: state.value != 0,
                onPressed: () => bloc.add(CreateProductJbEvent(
                  guesses: state.guesses,
                  modality: state.modality,
                  submodality: state.submodality,
                  value: state.value,
                )),
                label: 'Continuar',
              )
            ],
          ),
        ),
      ),
    );
  }
}
