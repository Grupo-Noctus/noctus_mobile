import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noctus_mobile/configs/theme_helper.dart';

class RegisterAvatarWidget extends StatefulWidget {
  final File? selectedImage;
  final void Function(File?) onImageSelected;

  const RegisterAvatarWidget({
    super.key,
    required this.selectedImage,
    required this.onImageSelected,
  });

  @override
  State<RegisterAvatarWidget> createState() => _RegisterAvatarWidgetState();
}

class _RegisterAvatarWidgetState extends State<RegisterAvatarWidget> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      widget.onImageSelected(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: ThemeHelper.kMediumGray,
            backgroundImage:
                widget.selectedImage != null ? FileImage(widget.selectedImage!) : null,
            child: widget.selectedImage == null
                ? const Icon(Icons.camera_alt, size: 40, color: ThemeHelper.kWhite)
                : null,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Toque para selecionar uma foto',
          style: TextStyle(color: ThemeHelper.kWhite),
        ),
      ],
    );
  }
}
