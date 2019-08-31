import 'package:flutter/material.dart';
import 'package:the_gorgeous_login/core/constants/app_contstants.dart';
import 'package:the_gorgeous_login/core/models/user.dart';
import 'package:the_gorgeous_login/ui/views/track_screen.dart';
import 'package:the_gorgeous_login/ui/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class HomeView extends StatelessWidget {
  void _fallDetection(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Button(
                  label: 'See Your Data',
                  labelSize: 18,
                  onPressed: () =>
                      Navigator.pushNamed(context, Routes.contacts),
                ),
                SizedBox(
                  height: 20,
                ),
                Button(
                  label: 'Add Contacts',
                  labelSize: 18,
                  onPressed: () =>
                      Navigator.pushNamed(context, Routes.AddContacts),
                ),
                SizedBox(
                  height: 20,
                ),
                Button(
                  label: 'Contact list',
                  labelSize: 18,
                  onPressed: () =>
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TrackScreen())),
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child: Text('Close'),
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
          );
        });
  }

  sendMail() async {
    final Email email = Email(
      body: 'Email body',
      subject: 'Email subject',
      recipients: ['mohab@gmail.com'],
    );

    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          leading: Container(),

        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 0.0),
                child: new Image(
                    width: 330.0,
                    height: 200.0,
                    fit: BoxFit.fill,
                    image: new AssetImage('assets/img/welcome_page.png')),
              ),
              Align(
                alignment: Alignment.center,
                child: Text('Welcome ${user?.name ?? ''}'),
              ),
              SizedBox(
                height: 20,
              ),
              Button(
                label: 'TUG Test',
                onPressed: () => Navigator.pushNamed(context, Routes.TUG),
              ),
              SizedBox(
                height: 20,
              ),
              Button(
                label: 'Fall Detection',
                onPressed: () => _fallDetection(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
