import 'package:flutter/foundation.dart';

import 'package:twogether_front/models/user_model.dart';

class ProfilesController with ChangeNotifier {
  List<UserModel> _accountUsers = [];
  List<UserModel> get accountUsers => _accountUsers;

  UserModel? _currentSelectedUser;
  UserModel? get currentSelectedUser => _currentSelectedUser;

  Future<void> fetchAccountUsers() async {
    await Future.delayed(const Duration(seconds: 2));

    _accountUsers = [];
    notifyListeners();
  }

  void selectCurrentUser(UserModel user) {
    _currentSelectedUser = user;
    notifyListeners();
  }

  UserModel createNewProfile(String name, Uint8List imageBytes) {
    if (_accountUsers.length >= 5) {
      throw Exception("Limite de novos perfis atingido!");
    }

    final newProfile = UserModel(name: name, pictureBytes: imageBytes);

    _accountUsers.add(newProfile);
    notifyListeners();

    return newProfile;
  }

  void updateProfileById(String id, UserModel newProfile) {
    int? currentProfileIndex;
    const notFoundInListValue = -1;

    currentProfileIndex ??=
        _accountUsers.indexWhere((element) => element.id == id);

    if (currentProfileIndex == notFoundInListValue) {
      throw Exception("Id de usuário não encontrado para update.");
    }

    _accountUsers[currentProfileIndex] = newProfile;
  }
}
