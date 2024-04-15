import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'providers/character_provider.dart';
import 'repositories/character_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CharacterProvider(CharacterRepository()),
        ),
      ],
      child: const MaterialApp(
        title: 'Littlefish Assessment',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );

  }
}



