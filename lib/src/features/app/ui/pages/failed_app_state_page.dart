import 'package:flutter/material.dart';

class FailedAppStatePage extends StatelessWidget {
  final String title;
  const FailedAppStatePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
    );
  }
}