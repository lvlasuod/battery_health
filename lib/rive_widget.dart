import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveWidget extends StatelessWidget {
  const RiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery. of(context). size. height-270,
      child: RiveAnimation.asset(
        'assets/scrollicon.riv',
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        antialiasing: false,
        placeHolder: Container(
          alignment: Alignment.topCenter,
            child:const LinearProgressIndicator(backgroundColor: Colors.black,color: Colors.white30,minHeight: 0.5,)),
      ),
    );
  }
}

/*

class RiveWidget extends StatefulWidget {
  const RiveWidget({Key? key}) : super(key: key);

  @override
  _RiveWidgetState createState() => _RiveWidgetState();
}

class _RiveWidgetState extends State<RiveWidget> {
  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      'assets/scrollicon.riv',
    );
  }
}
*/