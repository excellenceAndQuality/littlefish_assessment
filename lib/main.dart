import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littlefish_assessment/blocs/number_bloc.dart';
import 'package:littlefish_assessment/pages/home_page.dart';
import 'package:littlefish_assessment/styles/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NumberBloc>(
      create: (context) => NumberBloc(),
      child: MaterialApp(
        title: 'Littlefish Assessment',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const HomePage(),
      ),
    );
  }
}

