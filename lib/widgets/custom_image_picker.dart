import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:rent_a_car/widgets/text/custom_text.dart';

class CustomImagePicker extends StatefulWidget {
  final Function(File?) onImageSelected;
  final String? profilePictureUrl;
  final bool? isLoading;

  const CustomImagePicker({
    super.key,
    required this.onImageSelected,
    this.profilePictureUrl,
    this.isLoading = false,
  });

  @override
  _CustomImagePickerState createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      widget.onImageSelected(_image);
    }
  }

  void _showOptionsDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        bool showRemoveButton = _image != null || (widget.profilePictureUrl != null && widget.profilePictureUrl!.isNotEmpty);

        return Wrap(
          children: [
            if(showRemoveButton)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text("Remove Image",
                    style: TextStyle(color: Colors.red)),
                onTap: () {
                  setState(() {
                    _image = null;
                  });
                  widget.onImageSelected(null);
                  Navigator.pop(context);
                },
              ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Pick from Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take a Photo"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = widget.isLoading ?? false;

    return GestureDetector(
      onTap: _showOptionsDialog,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
              radius: 80, // Bigger size
              backgroundColor: Colors.purple.shade100,
              child: ClipOval(
                child: SizedBox(
                    width: 160,
                    height: 160,
                    child: _image != null
                        ? Image.file(_image!, fit: BoxFit.cover)
                        : (widget.profilePictureUrl != null &&
                                widget.profilePictureUrl!.isNotEmpty)
                            ? Image.network(
                                widget.profilePictureUrl!,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error, color: Colors.red),
                              )
                            : const Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.white,
                              )),
              )),
          if (isLoading)
            const Positioned.fill(
              child: ClipOval(
                child: SizedBox(
                  width: 160,
                  height: 160,
                  child: ColoredBox(
                    color: Colors.black26,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
