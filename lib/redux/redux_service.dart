
enum NumberActions { Increase, Decrease }

class ReduxActions {

  static int updateNumber(int state, dynamic action) {

    if (action == NumberActions.Increase) {

      return state + 1;

    } else if (action == NumberActions.Decrease) {

      return state - 1;

    } else {

      return state;

    }

  }
}