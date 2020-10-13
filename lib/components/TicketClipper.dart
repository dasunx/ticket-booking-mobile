import 'package:flutter/material.dart';

class TicketClipper extends CustomClipper<Path> {
  final double radius;

  TicketClipper(this.radius);

  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.addOval(Rect.fromCircle(
        center: Offset(0.0, (size.height / 3) * 2), radius: radius));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, (size.height / 3) * 2), radius: radius));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
