import 'dart:async';

import 'package:connectivity_plugin/connectivity_plugin.dart';
import 'package:flutter/material.dart';
import 'package:littlefish_assessment/styles/colors.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _isConnected = true;
  late StreamSubscription<bool> _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    ConnectivityPlugin.isConnected().then((isConnected) {
      setState(() {
        _isConnected = isConnected;
      });
    });

    _connectivitySubscription = ConnectivityPlugin.onConnectivityChanged.listen((isConnected) {
      setState(() {
        _isConnected = isConnected;
      });
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.primaryColour,
        elevation: 0,
        title: const Text(
          "Question 4",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
        ),
      ),
      backgroundColor: CustomColors.primaryColour,
      body: Center(
        child: Text(
          _isConnected ? 'Connected to the internet' : 'No internet connection',
          style: const TextStyle(
              color: Colors.white,
              fontSize: 20),
        ),
      ),
    );
  }
}