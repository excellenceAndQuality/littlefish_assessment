import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity_plugin/connectivity_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConnectivityExampleScreen(),
    );
  }
}

class ConnectivityExampleScreen extends StatefulWidget {
  @override
  _ConnectivityExampleScreenState createState() => _ConnectivityExampleScreenState();
}

class _ConnectivityExampleScreenState extends State<ConnectivityExampleScreen> {
  bool _isConnected = true; // Default assumption: connected to the internet
  late StreamSubscription<bool> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    // Check current connectivity status
    ConnectivityPlugin.isConnected().then((isConnected) {
      setState(() {
        _isConnected = isConnected;
      });
    });

    // Listen to connectivity changes
    _connectivitySubscription = ConnectivityPlugin.onConnectivityChanged.listen((isConnected) {
      setState(() {
        _isConnected = isConnected;
      });
    });
  }

  @override
  void dispose() {
    // Cancel the subscription to avoid memory leaks
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connectivity Example'),
      ),
      body: Center(
        child: Text(
          _isConnected ? 'Connected to the internet' : 'No internet connection',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
