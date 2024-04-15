import 'package:flutter/material.dart';
import 'package:littlefish_assessment/redux/redux_service.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<int>(
      store: Store<int>(ReduxActions.updateNumber, initialState: 0),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Littlefish Assessment',
        home: HomePage(),
      ),
    );
  }
}




