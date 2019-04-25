import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _phoneController = TextEditingController();

  PhoneNumber _phoneNumber;

  bool valid = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: const Text('Lib Phone Number demo'),
          ),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _parsePhoneNumber(), icon: Icon(Icons.phone), label: Text('Parse')),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                ),
                SizedBox(height: 16.0),
                Text('Country Code: ${_phoneNumber?.countryCode}'),
                Text('National Number: ${_phoneNumber?.nationalNumber}'),
                Text('Extension: ${_phoneNumber?.numberExtension}'),
                Text('Valid: $valid')
              ],
            ),
          )),
    );
  }

  void _parsePhoneNumber() async {
    try {
      final parsed = await FlutterLibPhoneNumber.parse(_phoneController.text);
      setState(() {
        valid = true;
        _phoneNumber = parsed;
      });
    } on PlatformException catch (e) {
      setState(() {
        valid = false;
      });
      debugPrint(e.code + ' --- ' + e.message);
    }
  }
}
