import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/enums/charging_status.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter = "null";
  AndroidBatteryInfo myBatteryInfo = AndroidBatteryInfo();
  void _incrementCounter() async {
    _counter =
    "Battery Health: ${(await BatteryInfoPlugin().androidBatteryInfo)!.health}";

    setState(() {});
  }

  void xx() {
    BatteryInfoPlugin().androidBatteryInfo.then((value) {
      if (value != null) {
        myBatteryInfo = value;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            myBatteryInfo.technology != null
                ? Column(
              children: [
                Text("${(myBatteryInfo.health)}"),
                SizedBox(
                  height: 20,
                ),
                Text("Voltage: ${(myBatteryInfo.voltage)} mV"),
                SizedBox(
                  height: 20,
                ),
                Text(
                    "${(myBatteryInfo.chargingStatus.toString())}"),
                SizedBox(
                  height: 20,
                ),
                Text("Battery Level: ${(myBatteryInfo.batteryLevel)} %"),
                SizedBox(
                  height: 20,
                ),
                Text(
                    "Battery Capacity: ${(myBatteryInfo.batteryCapacity! / 1000)} mAh"),
                SizedBox(
                  height: 20,
                ),
                Text("Technology: ${(myBatteryInfo.technology)} "),
                SizedBox(
                  height: 20,
                ),
                Text(
                    "Battery present: ${myBatteryInfo.present! ? "Yes" : "False"} "),
                SizedBox(
                  height: 20,
                ),
                Text("Scale: ${(myBatteryInfo.scale)} "),
                SizedBox(
                  height: 20,
                ),
                Text(
                    "Remaining energy: ${-(myBatteryInfo.remainingEnergy! * 1.0E-9)} Watt-hours,"),
                SizedBox(
                  height: 20,
                ),
              ],
            )
                : const CircularProgressIndicator(),
            TextButton(onPressed: xx, child: const Text("hey"))
          ],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
