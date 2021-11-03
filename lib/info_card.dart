

import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
   IconData icon;
   Color iconColor;
   String title="undefined";
   String value="undefined";
   double padding=0;
   InfoCard({Key? key,required this.icon,required this.iconColor,required this.title,required this.value,required this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: SizedBox(
            width:padding !=0 ? MediaQuery.of(context)
                .size
                .width /
                2 -
                padding: MediaQuery.of(context)
                .size
                .width - 22,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Padding(

                  padding: EdgeInsets.only(left:10.0,top:5,bottom:2),
                  child: Icon(icon,
                      size: 30,
                      color: iconColor),
                ),
                 Padding(
                  padding: EdgeInsets.only(left:10.0,bottom:5),
                  child: Text(title,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight.w300)),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left:13.0,top:5,bottom:15),
                  child: Text(
                      value,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight:
                          FontWeight.bold)),
                ),



              ],
            )));
  }
}
