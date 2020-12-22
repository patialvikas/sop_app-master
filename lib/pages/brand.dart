import 'package:flutter/material.dart';
import 'dart:async';

class Brand extends StatefulWidget {
  @override
  _BrandState createState() => _BrandState();
}

class _BrandState extends State<Brand> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Timer( Duration(seconds: 2),() =>Navigator.pushNamed(context, '/register')
    );
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: new BoxDecoration ( color: Color.fromRGBO(0,66,96, 1), ),
          constraints: BoxConstraints.expand(),
          padding: EdgeInsets.all(40.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text( 'Bizz Sutra', textAlign: TextAlign.center, style: TextStyle( color: Color.fromRGBO(234,112,12, 1), fontWeight: FontWeight.bold, fontSize: 50.0 ) ),
              ]
          )
        )
      )
    );
  }
}