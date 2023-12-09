import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hebi/presentation/blocs/jb/jb.dart';

class ShiftsPage extends StatelessWidget {
  const ShiftsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<JBBloc>();
    final state = bloc.state as LoadedShiftJBState;
    final shifts = state.shifts;

    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        padding: const EdgeInsets.only(top: 10),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: shifts.length,
        itemBuilder: (context, index) => SwitchListTile(
          title: Text('${shifts[index].number} - ${shifts[index].abbr}'),
          value: shifts[index].isSelected,
          onChanged: (value) {
            bloc.add(ChangeSelectedShiftJbEvent(shifts[index]));
          },
        ),
      ),
    );
  }
}
