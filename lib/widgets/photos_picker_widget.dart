import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clients_digcoach/data/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PhotosPickerWidget extends StatefulWidget {
  final List<Uint8List> images;
  final int maxPickedImages;
  final List<String> editImages;

  const PhotosPickerWidget({
    Key? key,
    this.images = const [],
    this.maxPickedImages = 1000,
    this.editImages = const [],
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
          // if (canPickImages)
            InkWell(
              onTap: canPickImages ? pickImage : null,
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
                    SizedBox(height: 3),
                    Text('Add Image', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ),
          const SizedBox(width: 10),
          SizedBox(
            width: 550,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
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
                  const SizedBox(width: 10),
                  ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.editImages.length,
                      separatorBuilder: (context, _) =>
                          const SizedBox(width: 10),
                      itemBuilder: (context, index) => CachedNetworkImage(
                            imageUrl: widget.editImages[index],
                            fit: BoxFit.cover,
                            width: 200,
                            placeholder: (context, url) => const Center(
                                child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator())),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )),
                ],
              ),
            ),
          )
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
