import 'package:flutter_bloc/flutter_bloc.dart';
import 'number_event.dart';
import 'number_state.dart';

class NumberBloc extends Bloc<NumberEvents, NumberStates> {
  int number = 0;

  NumberBloc() : super(InitialState()) {
    on<IncreaseNumberEvent>(onNumberIncrease);
    on<DecreaseNumberEvent>(onNumberDecrease);
  }

  void onNumberIncrease(IncreaseNumberEvent event, Emitter<NumberStates> emit) async {
    number = number + 1;
    emit(UpdateState(number));
  }

  void onNumberDecrease(DecreaseNumberEvent event, Emitter<NumberStates> emit) async {
    number = number - 1;
    emit(UpdateState(number));
  }
}