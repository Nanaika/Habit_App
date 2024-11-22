import 'package:flutter/material.dart';

class ImageRow extends StatelessWidget {
  const ImageRow({
    super.key, required this.imagePath,
  });
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Image.asset(imagePath)],
    );
  }
}