import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twogether_front/configs/app_routing.dart';
import 'package:twogether_front/controllers/profiles_controller.dart';
import 'package:twogether_front/models/profile_configurations.dart';
import 'package:twogether_front/models/user_model.dart';

class OnboardingConfigurationView extends StatelessWidget {
  OnboardingConfigurationView({super.key, required this.profile});

  final UserModel profile;
  final TextEditingController _maxDailyController = TextEditingController();

  void _onClickContinueButton(BuildContext context) {
    final maxDailyValue = double.tryParse(_maxDailyController.text);

    if (maxDailyValue == null) {
      throw Exception("O valor diário precisa conter apenas dígitos.");
    }

    profile.setConfigurations(
      ProfileConfigurations(maxDailySpending: maxDailyValue),
    );

    context.read<ProfilesController>().updateProfileById(profile.id, profile);

    Navigator.popUntil(
      context,
      (route) => route.settings.name == MyAppRouting.PROFILE_PAGE,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Olá bem-vindo, ${profile.name}"),
              const SizedBox(height: 12),
              const Text("Agora vamos personalizar a sua experiência."),
              const SizedBox(height: 24),
              TextFormField(
                controller: _maxDailyController,
                decoration: const InputDecoration(labelText: "Quanto sobra"),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 12),
              const Text(
                "Quanto tem sobrando por mês depois de diminuir os custos fixos e 15% de investimento?",
              ),
              const SizedBox(height: 8),
              const Text(
                "Ex: R\$2500 de salário, R\$1500 de custos fixos, R\$375 de investimentos. Me sobra R\$625 para o mês.",
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewPadding.bottom),
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () => _onClickContinueButton(context),
                    child: const Text("Continuar"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
