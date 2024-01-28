import 'package:flutter/material.dart';

class firstpage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<firstpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AppSteven')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              child: InkWell(
            onTap: () {},
            child: Ink.image(
              image: AssetImage('assets/newpx1.png'),
              height: 350,
              width: 500,
              fit: BoxFit.cover,
            ),
          )),
          Container(
              child: InkWell(
            onTap: () {},
            child: Ink.image(
              image: AssetImage('assets/List.png'),
              height: 350,
              width: 500,
              fit: BoxFit.cover,
            ),
          )),
        ],
        //color: Colors.black,
      ),
    );
  }
}
