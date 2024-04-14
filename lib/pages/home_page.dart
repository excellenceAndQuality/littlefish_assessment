import 'package:flutter/material.dart';
import 'package:littlefish_assessment/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/number_bloc.dart';
import '../blocs/number_event.dart';
import '../blocs/number_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColours.primaryColour,
      body: BlocBuilder<NumberBloc, NumberStates>(
        builder: (context, state) {
          if (state is InitialState) {
            return _ui(context, 0);
          }
          if (state is UpdateState) {
            return _ui(context, state.number);
          }
          return Container();
        },
      ),

    );
  }

  Widget _ui(BuildContext context, int number) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              context.read<NumberBloc>().add(IncreaseNumberEvent());
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
              backgroundColor: CustomColours.fadedGreen,
              foregroundColor: CustomColours.deepGreen,
            ),
            child: const Icon(Icons.add, color: CustomColours.green),
          ),
          const SizedBox(height: 50,),
          Text(
            number.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 60,
              fontWeight: FontWeight.w100
            ),
          ),
          const SizedBox(height: 50,),
          ElevatedButton(
            onPressed: () {
              context.read<NumberBloc>().add(DecreaseNumberEvent());
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
              backgroundColor: CustomColours.fadedRed,
              foregroundColor: CustomColours.deepRed,
            ),
            child: const Icon(Icons.remove, color: CustomColours.red),
          ),

        ],
      ),
    );
  }
}
