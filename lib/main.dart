import 'package:battery_health/rive_widget.dart';
import 'package:flutter/material.dart';

import 'battery_info.dart';


void main() {
  runApp(Splash());
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Builder(
                builder: (context) {
                  return GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                        );
                      },
                      child: const RiveWidget());
                }
              ),
             const Text("Battery Info",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 40
                ),),
              SizedBox(height: 15,),
              Builder(
                builder: (context) {
                  return TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                        );
                      },
                    child: const Text("To monitor your phone's battery\nhealth and other info\n\ntap here!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                    ),),
                  );
                }
              ),
              const SizedBox(height: 100,),
              const Text("mpdev.com v.0.1",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15
                ),),
            ],
          ),

        ),
      ),
    );
  }
}