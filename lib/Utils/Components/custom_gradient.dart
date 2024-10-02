import 'package:flutter/material.dart';

class CustomGradient extends StatelessWidget {
  final List<Color> colors;
  final List<double>? stops;
  final Alignment begin;
  final Alignment end;

  CustomGradient({
    required this.colors,
    this.stops,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    required Stack child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: colors,
          stops: stops,
        ),
      ),
    );
  }
}
