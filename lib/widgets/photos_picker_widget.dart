import 'dart:typed_data';

import 'package:clients_digcoach/data/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PhotosPickerWidget extends StatefulWidget {
  final List<Uint8List> images;
  final int maxPickedImages;

  const PhotosPickerWidget({
    Key? key,
    required this.images,
    this.maxPickedImages = 1000,
  }) : super(key: key);

  @override
  State<PhotosPickerWidget> createState() => _PhotosPickerWidgetState();
}

class _PhotosPickerWidgetState extends State<PhotosPickerWidget> {
  @override
  Widget build(BuildContext context) {
    final canPickImages = widget.images.length < widget.maxPickedImages;

    return SizedBox(
      height: 100,
      child: Row(
        children: [
          if (canPickImages)
            InkWell(
              onTap: pickImage,
              child: SizedBox(
                height: 100,
                width: 100,
                child: Column(
                  children: const [
                    Icon(
                      Icons.add_a_photo,
                      color: AppColors.primaryColor,
                      size: 70,
                    ),
                    SizedBox(height: 4),
                    Text('Add Image', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ),
          const SizedBox(width: 10),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.images.length,
              separatorBuilder: (context, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) => Image.memory(
                widget.images[index],
                fit: BoxFit.cover,
                width: 200,
                height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      final fileBytes = result.files.first.bytes!;

      setState(() {
        widget.images.add(fileBytes);
      });
    }
  }
}
