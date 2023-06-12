import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_recognition_porto/face.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final options = FaceDetectorOptions(
    enableTracking: true,
    enableClassification: true,
  );
  String? imagePath;
  List<Offset> points = [];
  double smile = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Image Recognition ML KIT"),
      ),
      body: Column(
        children: [
          const Text("Take Picture"),
          ElevatedButton(
              onPressed: () async {
                final picker = ImagePicker();
                final result = await picker.pickImage(
                    source: ImageSource.camera, imageQuality: 100);
                final faceDetector = FaceDetector(options: options);
                points.clear();
                if (result != null) {
                  setState(() {
                    imagePath = result.path;
                  });
                  final List<Face> faces = await faceDetector
                      .processImage(InputImage.fromFilePath(result.path));

                  for (Face face in faces) {
                    final Rect boundingBox = face.boundingBox;
                    // print("bound : ${boundingBox.center}");
                    points.addAll([
                      boundingBox.topLeft,
                      boundingBox.topRight,
                      boundingBox.bottomRight,
                      boundingBox.bottomLeft,
                      boundingBox.topLeft,
                    ]);

                    smile = face.smilingProbability ?? 0;
                    // print(face.smilingProbability);
                  }
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FaceFinal(
                            imagePath: result.path,
                            points: points,
                            isSmiling: smile > 0.5 ? true : false,
                          )));
                }
              },
              child: const Icon(Icons.camera_front)),
        ],
      ),
    );
  }
}
