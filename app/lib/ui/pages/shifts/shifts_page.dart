import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hebi/ui/pages/widgets/widgets.dart';

import './/presentation/blocs/jb/jb.dart';
import './/ui/pages/shifts/components/components.dart';

class ShiftsPage extends StatelessWidget {
  const ShiftsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<JBBloc>();
    final state = bloc.state as LoadedShiftsJBState;
    final shifts = state.shifts;

    return Scaffold(
      appBar: AppBar(),
      body: shifts.isNotEmpty
          ? ListView.builder(
              itemCount: shifts.length + 1,
              padding: const EdgeInsets.only(top: 10),
              itemBuilder: (context, index) {
                if (index == shifts.length) {
                  return DefaultButton(
                    enabled: shifts.any((shift) => shift.isSelected),
                    onPressed: () => bloc.add(GetGamesJbEvent(
                      shifts.where((shift) => shift.isSelected).toList(),
                    )),
                    label: 'Continuar',
                  );
                }

                return ShiftCard(
                  shift: shifts[index],
                  onChanged: (_) => bloc.add(ChangeSelectedShiftJbEvent(
                    shifts[index],
                  )),
                );
              },
            )
          : const Center(child: Text('NENHUM TURNO EM ABERTO PARA JOGO')),
    );
  }
}
