
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_linkimager/ImagerRoute.dart';

class MyTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("TestRoute!")
        ), 
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(child: Text("hello world"), onPressed: () => debugPrint("helloWorld!")),
              FloatingActionButton(onPressed: ()  { debugPrint("wohohw!"); Navigator.push((context), MaterialPageRoute(builder: (context) => ImagerRoute())); },)
              ],
            ),
          )
          
    );
  }
  
}