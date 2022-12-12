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

    late double width = (rect.left! + 100) - (rect.right! - 300);
    late double height = rect.top! - (rect.bottom! - 600);

    final bubbleSize = Size((width * 0.5) / 2, height * 0.6);
    final fillet = bubbleSize.width * 0.1;

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
      ..imageFilter = ImageFilter.blur(sigmaX: 10, sigmaY: 10)
      // ..color = Colors.white.withOpacity(1)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    // draw
    canvas.drawPath(bubblePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
