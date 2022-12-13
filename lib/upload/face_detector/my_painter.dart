import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class Position {
  double? left;
  double? right;
  double? top;
  double? bottom;

  Position({
    this.left,
    this.right,
    this.top,
    this.bottom,
  });
}

class MyPainter extends CustomPainter {
  Face face_position;

  MyPainter({
    required this.face_position,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Position rect = Position();
    rect.left = face_position.boundingBox.left;
    rect.right = face_position.boundingBox.right;
    rect.top = face_position.boundingBox.top;
    rect.bottom = face_position.boundingBox.bottom;

    double left = rect.left!;
    double right = rect.right!;
    double top = rect.top!;
    double bottom = rect.bottom!;
    // late double width = (rect.left! + 100) - (rect.right! - 300);
    // late double height = rect.bottom! - rect.top!;

    // final po = Rect.fromLTRB(left, top, right, bottom);
    // final paint = Paint()
    //   ..color = Colors.black
    //   ..style = PaintingStyle.fill
    //   ..strokeWidth = 4;
    // canvas.drawRect(po, paint);

     // final poa = Rect.fromLTRB(left / 2, top / 5, right / 2, bottom / 3);
    final poa = Rect.fromLTRB(size.width / (left / 1), size.height - (top * 8), size.width - right, size.height * (bottom));
    //final poa = Rect.fromLTRB(left / 5, top / 6, right / 7, bottom / 8);
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeWidth = 4;
    canvas.drawOval(poa, paint);

    // path.addOval(Rect.fromLTWH(left, top, size.width / 4, size.height / 3));
    // path.addOval(Rect.fromLTRB(left, right, top, bottom));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
