import 'package:flutter/material.dart';
import 'package:littlefish_assessment/styles/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.primaryColour,
        elevation: 0,
        title: const Text(
          "Question 3",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
        ),
      ),
      backgroundColor: CustomColors.primaryColour,
      body: const Center(

      ),

    );
  }
}