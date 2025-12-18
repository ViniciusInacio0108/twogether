import 'package:twogether_front/models/user_model.dart';

class AccountModel {
  final Set<UserModel> _users = {};

  AccountModel();

  Set<UserModel> get users => _users;

  void addAllUsers(Set<UserModel> users) {
    if (users.isEmpty) {
      throw Exception("Set de usuários vazio!");
    }

    _users.addAll(users);
  }

  void addUser(UserModel user) {
    final isUserAlreadyIn = users.contains(user);

    if (isUserAlreadyIn) {
      throw Exception("Usuário já está cadastrado!");
    }

    users.add(user);
  }

  void removeUser(UserModel user) {
    final isUserExisting = users.contains(user);

    if (!isUserExisting) {
      throw Exception("Usuário não está cadastrado!");
    }

    users.remove(user);
  }
}
