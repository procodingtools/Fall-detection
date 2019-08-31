import 'dart:io';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission/permission.dart';
import 'package:date_format/date_format.dart';


class TrackScreen extends StatefulWidget {
  createState() => _TrackState();
}

class _TrackState extends State<TrackScreen> {
  List<String> _users = List();
  bool _isTracking = false;
  Location _location;
  File _file;
  IOSink _open;
  String _path = "";
  double _lat, _lng;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //requesting storage permission
    _requestStoragePermission();

    //getting SDCard path
    _getPath();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact list'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                TextEditingController controller;
                if (index < _users.length) {
                  controller = TextEditingController();
                  controller.text = _users[index];
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: index == _users.length
                      ? MaterialButton(
                          onPressed: () {
                              setState(() {
                                _users.add("");
                              });
                          },
                          child: Text("add"))
                      : TextField(
                          decoration: InputDecoration(
                            labelText: "Person name",
                          ),
                          controller: controller,
                          onChanged: (txt) {
                            _users[index] = txt;
                          },
                        ),
                );
              },
              itemCount: _users.length + 1,
            ),
          ),
          MaterialButton(
            onPressed: () {
    if (!_isTracking)
      _requestLocating();
    else {
      _startStopLocationg();
    }
    },
            color: Colors.blue,
            textColor: Colors.white,
            child: Text(!_isTracking ? "Track" : "Untrack"),
          )
        ],
      ),
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
      _file = File("$_path${formatDate(date, [
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
      ])}.txt");

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

      _file.writeAsStringSync(
          "${_users.map((user) => "$user ")}",
          mode: FileMode.append);

      //closing file.
      _open.flush();
      _open.close();
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
}
