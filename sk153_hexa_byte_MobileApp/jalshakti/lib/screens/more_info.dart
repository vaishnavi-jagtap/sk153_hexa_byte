import 'package:flutter/material.dart';

class MoreInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Text("About Us"),
              Divider(
                height: 20,
                endIndent: MediaQuery.of(context).size.width * 0.25,
                indent: MediaQuery.of(context).size.width * 0.25,
              ),
              Text("What we do?"),
              Text("dfbnh,"),
            ],
          ),
        ),
      ),
    );
  }
}
