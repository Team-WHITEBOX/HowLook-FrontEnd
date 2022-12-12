import 'dart:math';

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
  List<Face> face_position;

  MyPainter({
    required this.face_position,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final List<Position> rect;
    int i = 0;
    for (final face in face_position){
      // rect[i].left = face.boundingBox.left;
      // rect[i].right = face.boundingBox.right;
      // rect[i].top = face.boundingBox.top;
      // rect[i].bottom = face.boundingBox.bottom;
      i++;
    }

    final bubbleSize = Size(size.width, size.height * 0.8);
    final tailSize = Size(size.width * 0.1, size.height - bubbleSize.height);
    final fillet = bubbleSize.width * 0.1;
    final tailStartPoint = Point(size.width * 0.7, bubbleSize.height);
    //bubble body
    final bubblePath = Path()
      ..moveTo(0, fillet)
      // 왼쪽 위에서 왼쪽 아래 라인
      ..lineTo(0, bubbleSize.height - fillet)
      ..quadraticBezierTo(0, bubbleSize.height, fillet, bubbleSize.height)
      // 왼쪽 아래에서 오른쪽 아래 라인
      ..lineTo(bubbleSize.width - fillet, bubbleSize.height)
      ..quadraticBezierTo(bubbleSize.width, bubbleSize.height, bubbleSize.width,
          bubbleSize.height - fillet)
      // 오른쪽 아래에서 오른쪽 위 라인
      ..lineTo(bubbleSize.width, fillet)
      ..quadraticBezierTo(bubbleSize.width, 0, bubbleSize.width - fillet, 0)
      // 오른쪽 위에서 왼쪽 아래 라인
      ..lineTo(fillet, 0)
      ..quadraticBezierTo(0, 0, 0, fillet);

    // paint setting
    final paint = Paint()
      ..color = Color(0xffFCA311)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    // draw
    canvas.drawPath(bubblePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
