import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ConditionDiary extends StatefulWidget {
  final TextEditingController controller;

  const ConditionDiary({super.key, required this.controller});

  @override
  State<ConditionDiary> createState() => _ConditionDiaryState();
}

class _ConditionDiaryState extends State<ConditionDiary> {
  late TextEditingController _controller;
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  Future<void> _editDiary() async {
    final tempController = TextEditingController(text: _controller.text);
    File? tempImageFile = _imageFile;

    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (tempImageFile != null)
                  Stack(
                    children: [
                      Image.file(tempImageFile!, width: double.infinity, height: 150, fit: BoxFit.cover),
                      Positioned(
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            setModalState(() {
                              tempImageFile = null;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.photo_library),
                  label: const Text('이미지 선택'),
                  onPressed: () async {
                    final picked = await _picker.pickImage(source: ImageSource.gallery);
                    if (picked != null) {
                      setModalState(() {
                        tempImageFile = File(picked.path);
                      });
                    }
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: tempController,
                  autofocus: true,
                  maxLines: 6,
                  minLines: 4,
                  decoration: const InputDecoration(
                    hintText: '오늘의 상태를 기록해보세요...',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, {
                          'text': tempController.text,
                          'image': tempImageFile,
                        });
                      },
                      child: const Text('저장', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      },
    );

    if (result != null) {
      final newText = result['text'] as String;
      final newImage = result['image'] as File?;
      if (newText != _controller.text || newImage?.path != _imageFile?.path) {
        setState(() {
          _controller.text = newText;
          _imageFile = newImage;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasText = _controller.text.trim().isNotEmpty;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 350),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFFAEDCE),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_imageFile != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Stack(
                children: [
                  Image.file(_imageFile!, width: double.infinity, height: 150, fit: BoxFit.cover),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _imageFile = null;
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          else
            Center(
              child: SizedBox(
                width: 300,
                height: 200,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.photo_library),
                  label: const Text('이미지 선택'),
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black54,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 12),
          InkWell(
            onTap: _editDiary,
            borderRadius: BorderRadius.circular(8),
            child: Text(
              hasText ? _controller.text : '오늘의 상태를 기록해보세요...',
              style: TextStyle(
                fontSize: 16,
                color: hasText ? Colors.black87 : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}