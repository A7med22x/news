import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  String message;
  ErrorIndicator([this.message = 'Something Went Wrong']);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
