import 'package:flutter/widgets.dart';
import 'package:twogether_front/models/user_model.dart';
import 'package:twogether_front/services/image_picker_service.dart';
import 'package:twogether_front/ui/views/create_profile_view.dart';
import 'package:twogether_front/ui/views/home_view.dart';
import 'package:twogether_front/ui/views/onboarding_configuration_view.dart';
import 'package:twogether_front/ui/views/profile_view.dart';

class MyAppRouting {
  static const PROFILE_PAGE = "/";
  static const CREATE_PROFILE_PAGE = "/create-profile";
  static const ONBOARDING_CONFIGURATION = "/onboarding-configuration";
  static const HOME = "/home";

  Map<String, Widget Function(BuildContext)> routes = {
    PROFILE_PAGE: (_) => const ProfileView(),
    CREATE_PROFILE_PAGE: (_) => CreateProfileView(
          imageService: ImagePickerService(),
        ),
    ONBOARDING_CONFIGURATION: (ctx) {
      final user = ModalRoute.of(ctx)!.settings.arguments as UserModel;
      return OnboardingConfigurationView(profile: user);
    },
    HOME: (_) => HomeView(),
  };
}
