import 'package:flutter/foundation.dart';
import 'package:twogether_front/models/profile_configurations.dart';
import 'package:uuid/uuid.dart';

class UserModel {
  final String _id;
  String _name;
  Uint8List _pictureBytes;
  ProfileConfigurations _configurations =
      ProfileConfigurations(maxDailySpending: 100.0);

  UserModel({
    required name,
    required Uint8List pictureBytes,
  })  : _id = const Uuid().v4(),
        _name = name,
        _pictureBytes = pictureBytes,
        _configurations = ProfileConfigurations(maxDailySpending: 100.0);

  factory UserModel.empty() => UserModel(
        name: "",
        pictureBytes: Uint8List.fromList([]),
      );

  String get id => _id;
  String get name => _name;
  Uint8List get pictureBytes => _pictureBytes;
  ProfileConfigurations get configurations => _configurations;

  void changeName(String name) {
    if (name.isEmpty) {
      throw Exception("Nome não pode ser vazio!");
    }

    _name = name;
  }

  void changePicture(Uint8List newPictureBytes) {
    if (newPictureBytes.isEmpty) {
      throw Exception("Bytes da imagem vazio!");
    }

    _pictureBytes = newPictureBytes;
  }

  void setConfigurations(ProfileConfigurations newConfigs) {
    _configurations = newConfigs;
  }
}
