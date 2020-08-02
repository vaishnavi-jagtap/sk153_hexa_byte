import 'package:flutter/material.dart';

class ApprovalHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
      ),
      body: Container(
        child: Center(
          child: Text("Help me regarding survey approval"),
        ),
      ),
    );
  }
}
