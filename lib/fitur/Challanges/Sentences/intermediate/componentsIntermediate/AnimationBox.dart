import 'package:flutter/material.dart';

Widget buildAnimationBox({
  required bool show,
  required Color color,
  required IconData icon,
}) {
  return Center(
    child: AnimatedOpacity(
      opacity: show ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: color.withOpacity(0.82),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          size: 100,
          color: Colors.white,
        ),
      ),
    ),
  );
}
