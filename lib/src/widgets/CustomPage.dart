import 'package:flutter/material.dart';

class CustomPageBase extends StatelessWidget {
  const CustomPageBase({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(15),
              child: child,
            )
        ),
      ),
    );
  }
}
