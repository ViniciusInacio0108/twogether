import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:twogether_front/configs/app_routing.dart';
import 'package:twogether_front/controllers/profiles_controller.dart';
import 'package:twogether_front/services/image_picker_service.dart';

class CreateProfileView extends StatefulWidget {
  const CreateProfileView({super.key, required this.imageService});

  final ImagePickerService imageService;

  @override
  State<CreateProfileView> createState() => _CreateProfileViewState();
}

class _CreateProfileViewState extends State<CreateProfileView> {
  final TextEditingController _nameController = TextEditingController();

  Uint8List? _selectedImageBytes;
  static const placeholderImagePath = "assets/images/avatar_placeholder.jpg";

  Future<Uint8List> _getPlaceholderImageBytes() async {
    ByteData byteData = await rootBundle.load(placeholderImagePath);

    return byteData.buffer.asUint8List();
  }

  Future<void> _onPressedSelectPicture() async {
    if (mounted) {
      _selectedImageBytes = await widget.imageService.getImageBytesFromGalley();
      setState(() {});
    }
  }

  Future<void> _onPressedAddProfile(BuildContext context) async {
    try {
      final name = _nameController.text;

      if (name.isEmpty) {
        throw Exception("Um nome é necessário. Por favor, digite um.");
      }

      _selectedImageBytes ??= await _getPlaceholderImageBytes();

      if (!context.mounted) return;

      final newUser = context
          .read<ProfilesController>()
          .createNewProfile(name, _selectedImageBytes!);

      Navigator.pushNamed(
        context,
        MyAppRouting.ONBOARDING_CONFIGURATION,
        arguments: newUser,
      );
    } catch (e) {
      if (!context.mounted) return;

      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Text(e.toString());
        },
      );

      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ImageProvider circleAvatarImage = (_selectedImageBytes == null)
        ? const AssetImage(placeholderImagePath)
        : MemoryImage(_selectedImageBytes!);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Criar perfil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  InkWell(
                    onTap: () => _onPressedSelectPicture(),
                    child: CircleAvatar(
                      minRadius: 50,
                      maxRadius: 60,
                      backgroundImage: circleAvatarImage,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Nome",
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _onPressedAddProfile(context),
              child: const Text("Adicionar"),
            ),
          ],
        ),
      ),
    );
  }
}
