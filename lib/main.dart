import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: HomePage(),
    );
  }

}

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Native Code from Dart'),
      ),
      body: MyHomePage(),
    );
  }

}

class MyHomePage extends StatefulWidget{
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage>{

  static const platform = const MethodChannel('flutter.native/helper');
  String _responseFromNativeCode = 'Waiting for Response...';

  // Invoke method on platform Channel
  Future<void> responseFromNativeCode() async{
    String response = "";
    try{
      final String result = await platform.invokeMethod('helloFromNativeCode');
      response = result;
    }on PlatformException catch(e) {
      response = "Failed to Invoke: '${e.message}'.";
    }

    setState(() {
      _responseFromNativeCode = response;
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
                child: Text('Call Native Method'),
                onPressed: responseFromNativeCode),
            Text(_responseFromNativeCode),
          ],
        )
      ),
    );
  }

}
