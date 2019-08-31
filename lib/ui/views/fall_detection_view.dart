import 'package:flutter/material.dart';
import 'package:the_gorgeous_login/ui/widgets/button.dart';

class FallDetectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fall Detection'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Button(
                label: 'BEGIN',
                labelSize: 18,
              ),
              SizedBox(
                height: 20,
              ),
              Button(
                label: 'Video about TuG and info',
                labelSize: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
