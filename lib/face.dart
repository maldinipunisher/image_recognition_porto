import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_recognition_porto/face_painter.dart';

class FaceFinal extends StatelessWidget {
  final List<Offset> points;
  final String imagePath;
  final bool isSmiling;
  const FaceFinal(
      {super.key,
      required this.points,
      required this.imagePath,
      required this.isSmiling});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomPaint(
              child: Image.file(File(imagePath)),
              foregroundPainter: FacePainter(points),
            ),
            Text((isSmiling) ? "Im smiling" : "No Smiling")
          ],
        ),
      ),
    );
  }
}
