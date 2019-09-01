import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission/permission.dart';
import 'package:the_gorgeous_login/core/constants/app_contstants.dart';
import 'package:the_gorgeous_login/core/models/user.dart';
import 'package:the_gorgeous_login/ui/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class HomeView extends StatelessWidget {

  bool _isTracking = false;

  void _fallDetection(context, user) {
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
                _TrackingBtn(isTracking: _isTracking, onTracking: (isTracking) => _isTracking = isTracking, user: user),
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
                onPressed: () => _fallDetection(context, user),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrackingBtn extends StatefulWidget{

  final Function(bool isTracking) onTracking;
  final bool isTracking;
  final User user;

  const _TrackingBtn({Key key, this.onTracking, this.isTracking, this.user}) : super(key: key);

  createState() => _TrackingState();
}

class _TrackingState extends State<_TrackingBtn>{

  bool _isTracking;
  Location _location;
  File _file;
  IOSink _open;
  String _path = "";
  double _lat, _lng;
  String _fileName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isTracking = widget.isTracking;

    //requesting storage permission
    _requestStoragePermission();

    //getting SDCard path
    _getPath();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Button(
      label: 'Tracking ${_isTracking ? "on" : "off"}',
      labelSize: 18,
      onPressed: () {
        if (!_isTracking)
          _requestLocating();
        else {
          _startStopLocationg();
        }
        widget.onTracking(_isTracking);
      }
    );
  }



  void _requestLocating() {
    //initializing location if it's null
    if (_location == null) _location = Location();

    //checking for location permission
    _location.hasPermission().then((granted) {
      if (!granted)
        _location.requestPermission().then((status) {//permission not granted
          //requesting permission
          if (!status)
            _requestLocating(); //re request permission if denied
          else
            _location.requestService().then((val) {
              // request to enable location service
              if (val) //location service enabled
                _startStopLocationg(); //Start locating...
              else //location service not enabled
                _requestLocating(); //re request enable location service
            });
        });
      else //permission granted
        _location.requestService().then((val) {
          if (val)//location service enabled
            _startStopLocationg();//Start locating...
          else
            _requestLocating(); //location service not enabled => re request to enable location service
        });
    });
  }

  Future _startStopLocationg() async {
    //if is not tracking
    if (!_isTracking) {

      //preparing file
      //getting date
      final date = DateTime.now();

      //prepare file location (path + datetime + .txt)
      _fileName = "${formatDate(date, [
        yy,
        '-',
        mm,
        "-",
        dd,
        " ",
        HH,
        ":",
        nn,
        ":",
        ss
      ])}.txt";
      _file = File("$_path/$_fileName");

      //creating file in storage
      await _file.create(recursive: true);

      //opening the file
      _open = _file.openWrite();

      //update ui to set (application is locating)
      setState(() {
        _isTracking = true;
      });
      //resetting old latitude and old longitude to null;
      _lat = null;
      _lng = null;

      print('locating');

      //starting location listener
      _startLocationListener();
    } else { //if the app is tracking
      setState(() {
        //updating the state to set => app is not locating
        _isTracking = false;
      });

      //closing file.
      _open.flush();
      _open.close();

      _storeFileToFirebase();
    }
  }

  Future<String> _getPath() async {
    //requesting for SDCard path
    final storageInfo = await PathProviderEx.getStorageInfo();
    //saving path
    _path = storageInfo[0].rootDir + "/track me files/";
    //returning path
    return storageInfo[0].rootDir + "/track me files/";
  }

  Future _requestStoragePermission() async {
    //defining current platform
    if (Platform.isIOS) {
      //checking permission status
      final isGranted =
      await Permission.getSinglePermissionStatus(PermissionName.Storage);
      if (isGranted != PermissionStatus.allow ||
          isGranted != PermissionStatus.always) {
        //if denied, request for it
        await Permission.requestSinglePermission(PermissionName.Storage);
      }
    } else if (Platform.isAndroid) {
      //checking permission status
      final isGranted =
      await Permission.getPermissionsStatus([PermissionName.Storage]);
      if (isGranted != PermissionStatus.allow ||
          isGranted != PermissionStatus.always) {
        //if denied, request for it
        await Permission.requestPermissions([PermissionName.Storage]);
      }
    }
  }

  void _startLocationListener() {
    //on location changed
    _location.onLocationChanged().listen((location) {

      if (_isTracking == true){
        //if old position is recently initialized to null then create the new position the file.
        if (_lat == null) {
          //writing position to the file
          _file.writeAsStringSync(
              "${location.latitude},${location.longitude}\n",
              mode: FileMode.append);
        } else if (location.latitude != _lat || location.longitude != _lng) {
          //if the new position is dfferent than the old, create the position to the file.
          _file.writeAsStringSync(
              "${location.latitude},${location.longitude}\n",
              mode: FileMode.append);
        }

        //storing last position to compare it to the comming one.
        _lat = location.latitude;
        _lng = location.longitude;
      }

    });
  }

  void _storeFileToFirebase() {
    StorageReference storageRef =
    FirebaseStorage.instance.ref().child("track/${widget.user.email}/$_fileName");
    storageRef.putFile(_file);
  }

}
