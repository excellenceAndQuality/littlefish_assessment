import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:littlefish_assessment/styles/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SpinKitDoubleBounce(
          color: CustomColors.red,
          size: 30.0,
        ),
      ),
    );
  }
}
