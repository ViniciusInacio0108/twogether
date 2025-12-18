import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfilePictureSelector extends StatelessWidget {
  const ProfilePictureSelector({
    super.key,
    required this.name,
    required this.pictureBytes,
    required this.onPressed,
  });

  final String name;
  final Uint8List pictureBytes;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onPressed,
          child: CircleAvatar(
            minRadius: 32,
            maxRadius: 40,
            backgroundImage: MemoryImage(pictureBytes),
          ),
        ),
        const SizedBox(height: 8),
        Text(name),
      ],
    );
  }
}
