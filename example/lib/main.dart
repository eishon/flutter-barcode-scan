import 'dart:async';

import 'package:flutter_barcode_scan/flutter_barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Barcode Scanner Example'),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Container(
                  child: MaterialButton(
                    onPressed: scan,
                    child: const Text("Scan"),
                  ),
                  padding: const EdgeInsets.all(8.0),
                ),
                Text(barcode),
              ],
            ),
          )),
    );
  }

  Future scan() async {
    try {
      String barcode = await FlutterBarcodeScan.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == FlutterBarcodeScan.CameraAccessDenied) {
        setState(() {
          barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => barcode = 'Unknown error: $e');
    }
  }
}
