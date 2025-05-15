import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileSection extends StatefulWidget {
  final String initialUsername;
  final String? initialImageUrl;
  final void Function(String username, File? imageFile) onSave;
  final VoidCallback onCancel;

  const EditProfileSection({
    super.key,
    required this.initialUsername,
    this.initialImageUrl,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<EditProfileSection> createState() => _EditProfileSectionState();
}

class _EditProfileSectionState extends State<EditProfileSection> {
  late TextEditingController _usernameController;
  File? _pickedImageFile;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.initialUsername);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (_pickedImageFile != null) {
      imageWidget = Image.file(_pickedImageFile!, width: 100, height: 100, fit: BoxFit.cover);
    } else if (widget.initialImageUrl != null && widget.initialImageUrl!.isNotEmpty) {
      imageWidget = Image.network(widget.initialImageUrl!, width: 100, height: 100, fit: BoxFit.cover);
    } else {
      imageWidget = Container(
        width: 100,
        height: 100,
        color: Colors.grey[300],
        child: const Icon(Icons.camera_alt, size: 40),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("프로필 수정", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: "닉네임"),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _pickImage,
            child: imageWidget,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.onSave(_usernameController.text, _pickedImageFile);
                },
                child: const Text("저장"),
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: widget.onCancel,
                child: const Text("취소"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}