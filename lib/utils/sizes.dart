import 'package:flutter/material.dart';

double width(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
}

double height(BuildContext context) {
  return MediaQuery.sizeOf(context).height;
}

class Height extends StatelessWidget {
  const Height(this.height, {super.key});
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class Width extends StatelessWidget {
  const Width(this.width, {super.key});
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
