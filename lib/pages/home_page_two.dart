import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../styles/colors.dart';




class HomaPageTwo extends StatefulWidget {
  const HomaPageTwo({super.key});

  @override
  State<HomaPageTwo> createState() => _HomaPageTwoState();
}

class _HomaPageTwoState extends State<HomaPageTwo> {
  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectivityResult = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String connectionStatus = "";

    switch (_connectivityResult) {
      case ConnectivityResult.mobile:
        connectionStatus = "Mobile data connection is being used.";
        break;
      case ConnectivityResult.wifi:
        connectionStatus = "Wi-Fi connection is being used.";
        break;
      case ConnectivityResult.bluetooth:
        connectionStatus = "Bluetooth connection is being used.";
        break;
      case ConnectivityResult.ethernet:
        connectionStatus = "Ethernet connection is being used.";
        break;
      case ConnectivityResult.other:
        connectionStatus = "Other connection is being used.";
        break;
      case ConnectivityResult.vpn:
        connectionStatus = "Vpn connection is being used.";
        break;
      case ConnectivityResult.none:
        connectionStatus = "No connection.";
        break;
    }

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: Text(
                "Connection Status:",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
            Center(
              child: Text(
                connectionStatus,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
