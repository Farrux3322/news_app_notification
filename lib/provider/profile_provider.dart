import 'package:e_commerce/data/firebase/profile_service.dart';
import 'package:e_commerce/data/models/universal_response.dart';
import 'package:e_commerce/utils/ui_utils/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ProfileProvider with ChangeNotifier {
  ProfileProvider({required this.profileService}) {
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
    listenUserChanges();
  }

  final ProfileService profileService;
  User? currentUser;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    notifyListeners();
  }

  listenUserChanges() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      currentUser = user;
      notifyListeners();
    });
  }

  Future<void> updateUserName(BuildContext context) async {
    String username = nameController.text;
    showLoading(context: context);

    UniversalData universalData =
        await profileService.updateUserName(username: username);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> updateUserImage(BuildContext context, String imagePath) async {
    showLoading(context: context);
    UniversalData universalData =
        await profileService.updateUserImg(imagePath: imagePath);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }
}
