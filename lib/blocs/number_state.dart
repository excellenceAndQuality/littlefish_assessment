class NumberStates {}

class InitialState extends NumberStates {}

class UpdateState extends NumberStates {
  final int number;
  UpdateState(this.number);
}