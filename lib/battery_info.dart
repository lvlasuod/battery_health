import 'dart:async';

import 'package:backdrop/backdrop.dart';
import 'package:battery_health/info_card.dart';
import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/enums/charging_status.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/services.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(backgroundColor: Colors.black),
      home: BackdropScaffold(
          appBar: BackdropAppBar(
            backgroundColor: Colors.black,
            title: Text(_deviceData['brand'].toString().toUpperCase() +" "+ _deviceData['model'].toString().toUpperCase()), // device info
            centerTitle: true,
            actions: <Widget>[],
          ),
          backLayerBackgroundColor: Colors.black,
          frontLayer: Center(
            child: Column(
              children: [
               // battery health card
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
                  child: FutureBuilder<AndroidBatteryInfo?>(
                      future: BatteryInfoPlugin().androidBatteryInfo,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Card(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(Icons.health_and_safety,
                                        size: 70, color: Colors.green),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Battery Health',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 15),
                                    child: Text(
                                      snapshot.data!.health!.toUpperCase().split("_").last,
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return CircularProgressIndicator();
                      }),
                ),
                StreamBuilder<AndroidBatteryInfo?>(
                    stream: BatteryInfoPlugin().androidBatteryInfoStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Row(
                                children: [
                                  InfoCard(icon: Icons.power_rounded,iconColor:Colors.red, title: "Voltage", value: "${(snapshot.data!.voltage)} mV", padding: 10.0),
                                  InfoCard(icon: Icons.battery_charging_full_sharp,iconColor:Colors.amber, title: "Charging status", value: (snapshot.data!.chargingStatus.toString().split(".")[1]), padding: 26.0),

                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Row(
                                children: [
                                  InfoCard(icon: Icons.battery_full_outlined,iconColor:Colors.blue, title: "Battery Level", value: "${(snapshot.data!.batteryLevel)} %", padding: 10.0),
                                  InfoCard(icon: Icons.power_rounded,iconColor:Colors.black, title: "Battery Capacity", value: "${(snapshot.data!.batteryCapacity! / 1000)} mAh", padding: 26.0),

                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Row(
                                children: [
                                  InfoCard(icon: Icons.battery_full_outlined,iconColor:Colors.blue, title: "Technology", value: "${(snapshot.data!.technology)}", padding: 10.0),
                                  InfoCard(icon: Icons.power_rounded,iconColor:Colors.black, title: "Remaining energy", value: "${(-(snapshot.data!.remainingEnergy! * 1.0E-9)).toStringAsFixed(3)} Watt-h", padding: 26.0),

                                ],
                              ),
                            ),
                            InfoCard(icon: Icons.timer,iconColor:Colors.deepPurpleAccent, title: "Charge time remaining", value:  _getChargeTime(snapshot.data!), padding: 0),
                          ],
                        );
                      }
                      return const CircularProgressIndicator();
                    }),
              ],
            ),
          ),
          backLayer: Center(
            child: ListView(
              children: _deviceData.keys.map((String property) {
                return Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        property,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                      child: Text(
                        '${_deviceData[property]}',
                        style: const TextStyle(color: Colors.white),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                  ],
                );
              }).toList(), //Image.asset("assets/batt.png"),
            ),
          )),
    );
  }

  String _getChargeTime(AndroidBatteryInfo data) {
    if (data.chargingStatus == ChargingStatus.Charging) {

      return data.chargeTimeRemaining == -1
          ? "Calculating charge time remaining..."
          :
              "${(data.chargeTimeRemaining! / 1000 / 60).truncate()} minutes";
    }
    return "Battery is full or not connected to a power source";
  }
}
