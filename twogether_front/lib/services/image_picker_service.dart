import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  Future<XFile> getXFileImageFromGalley() async {
    return await _pickImageFromGallery();
  }

  Future<Uint8List> getImageBytesFromGalley() async {
    final image = await _pickImageFromGallery();

    return await image.readAsBytes();
  }

  Future<XFile> _pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      throw Exception("Imagem não selecionada!");
    }

    return image;
  }
}
