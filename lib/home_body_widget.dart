import 'package:flutter/material.dart';

class HomeBodyWidget extends StatelessWidget {
  final Color color;

  HomeBodyWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}