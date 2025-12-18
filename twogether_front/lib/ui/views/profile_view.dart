import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twogether_front/configs/app_routing.dart';
import 'package:twogether_front/controllers/profiles_controller.dart';
import 'package:twogether_front/models/user_model.dart';
import 'package:twogether_front/ui/components/profile_picture_selector.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future _fetchProfilesFuture;

  void _onPressedUserProfile(UserModel user) {
    context.read<ProfilesController>().selectCurrentUser(user);
    // navigate home
  }

  void _onPressedCreateNewProfile() {
    Navigator.pushNamed(context, MyAppRouting.CREATE_PROFILE_PAGE);
  }

  @override
  void initState() {
    super.initState();
    _fetchProfilesFuture =
        context.read<ProfilesController>().fetchAccountUsers();
  }

  @override
  Widget build(BuildContext context) {
    final accountUsers = context.watch<ProfilesController>().accountUsers;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecione um perfil"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: FutureBuilder(
          future: _fetchProfilesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              final errorMessage = snapshot.error.toString();
              return Center(
                child: Text("Erro! $errorMessage"),
              );
            }

            if (accountUsers.isEmpty) {
              return Column(
                children: [
                  const Expanded(
                    child: Center(
                      child:
                          Text("Você ainda não tem um perfil. Vamos começar!"),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _onPressedCreateNewProfile(),
                    child: const Text("Criar novo perfil"),
                  ),
                ],
              );
            }

            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 20,
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount: accountUsers.length,
                    itemBuilder: (context, index) {
                      return ProfilePictureSelector(
                        name: accountUsers[index].name,
                        pictureBytes: accountUsers[index].pictureBytes,
                        onPressed: () =>
                            _onPressedUserProfile(accountUsers[index]),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: _onPressedCreateNewProfile,
                  child: const Text("Criar novo perfil"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
