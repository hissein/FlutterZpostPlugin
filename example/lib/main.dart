import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:ZpostCliv2_example/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ZpostCliv2/ZpostCliv2.dart';
import 'package:ZpostCliv2/widget/widget_to_image.dart';
import 'widget/card_widget.dart';
import 'widget/title_widget.dart';
import 'widget/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey key1;
  GlobalKey key2;
  Uint8List bytes1;
  Uint8List bytes2;
  String _platformVersion = 'Unknown';
  bool _print, _init;
  Uint8List byt;
  String _base = null;
  File file;
  @override
  void initState() {
    super.initState();
    initPlatformState();
    //  printFile();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    bool init, print;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      init = await ZpostCliv2.initSdk();
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _init = init;
      _print = print;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            WidgetToImage(
              builder: (key) {
                this.key1 = key;
                return CardWidget(title: 'Title1', description: 'Description1');
              },
            ),
            Column(
              children: [
                TitleWidget('Images'),
                buildImage(bytes1),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Theme.of(context).accentColor,
        padding: EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          child: RaisedButton(
            color: Colors.white,
            child: Text('Capture'),
            onPressed: () async {
              final bytes1 = await Utils.capture(key1);

              String bytes = base64Encode(bytes1);

              await ZpostCliv2.printTicket(bytes);

              setState(() {
                this.bytes1 = bytes1;
              });
            },
          ),
        ),
      ),
    ));
  }

  Widget buildImage(Uint8List bytes) => bytes != null
      ? Container(
          child: Image.memory(bytes),
        )
      : Container();
  TicketModel ticket = new TicketModel(
      id: "5f7b2215f947dc3979b5de5d",
      code: "wa-3",
      etat: true,
      generate_at: new DateTime.fromMicrosecondsSinceEpoch(1601905173681));
  String slogan = "Just Do It";
  String name = "Mousaïda SoftWare";
}
