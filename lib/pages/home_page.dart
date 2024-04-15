import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../redux/redux_service.dart';
import '../styles/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = Store<int>(ReduxActions.updateNumber, initialState: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColours.primaryColour,
        elevation: 0,
        title: const Text(
          "Question 2",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
        ),
      ),
      backgroundColor: CustomColours.primaryColour,
      body: Container(child: _ui(context)),
    );
  }

  Widget _ui(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StoreConnector<int, VoidCallback>(
            converter: (store) {
              return () => store.dispatch(NumberActions.Increase);
            },
            builder: (context, callback) {
              return ElevatedButton(
                onPressed: callback,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  backgroundColor: CustomColours.fadedGreen,
                  foregroundColor: CustomColours.deepGreen,
                ),
                child: const Icon(Icons.add, color: CustomColours.green),
              );
            },
          ),
          const SizedBox(
            height: 50,
          ),
          StoreConnector<int, String>(
            converter: (store) => store.state.toString(),
            builder: (context, count) {
              return Text(
                count.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.w100),
              );
            },
          ),
          const SizedBox(
            height: 50,
          ),
          StoreConnector<int, VoidCallback>(
            converter: (store) {
              return () => store.dispatch(NumberActions.Decrease);
            },
            builder: (context, callback) {
              return ElevatedButton(
                onPressed: callback,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  backgroundColor: CustomColours.fadedRed,
                  foregroundColor: CustomColours.deepRed,
                ),
                child: const Icon(Icons.remove, color: CustomColours.red),
              );
            },
          ),
        ],
      ),
    );
  }
}
