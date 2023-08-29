import 'package:e_commerce/data/firebase/auth_service.dart';
import 'package:e_commerce/data/models/user_model.dart';
import 'package:e_commerce/utils/ui_utils/error_message_dialog.dart';
import 'package:e_commerce/utils/ui_utils/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../data/firebase/upload_service.dart';
import '../data/models/universal_response.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider({required this.firebaseService});

  final AuthService firebaseService;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String userUrl="";

  loginButtonPressed() {
    emailController.clear();
    userController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  signUpButtonPressed() {
    emailController.clear();
    passwordController.clear();
  }

  checkPassword(BuildContext context) {
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    if (password == confirmPassword) {
      signUpUser(context);

    } else {
      showErrorMessage(
          message: "Password and Confirm Password are not the same! Try Again",
          context: context);
    }
  }

  Future<void> signUpUser(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    showLoading(context: context);
    UniversalData universalData =
        await firebaseService.signUpUser(email: email, password: password);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }

    if (universalData.error.isEmpty) {
      if (context.mounted) {
        addUser(context: context);
        loginButtonPressed();
        showConfirmMessage(message: "User signed Up", context: context);
      }
    } else {
      if (context.mounted) {
        showErrorMessage(message: universalData.error, context: context);
      }
    }
  }

  Stream<User?> listenAuthState() => FirebaseAuth.instance.authStateChanges();

  Future<void> loginUser(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    showLoading(context: context);
    UniversalData universalData = await firebaseService.loginUser(email: email, password: password);
    if(context.mounted){
      hideLoading(dialogContext: context);
    }

    if (universalData.error.isEmpty) {
      if (context.mounted) {
        loginButtonPressed();
        showConfirmMessage(message: "User logged!", context: context);
      }
    } else {
      if (context.mounted) {
        showErrorMessage(message: universalData.error, context: context);
      }
    }
  }

  Future<void> logOutUser(BuildContext context)async{
    showLoading(context: context);
    UniversalData universalData = await firebaseService.logOutUser();
    if(context.mounted){
      hideLoading(dialogContext: context);
    }

    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showConfirmMessage(message: universalData.data as String, context: context);
      }
    } else {
      if (context.mounted) {
        showErrorMessage(message: universalData.error, context: context);
      }
    }
  }

  Future<void> signInWithGoogle(BuildContext context)async{
    showLoading(context: context);
    UniversalData universalData = await firebaseService.signInWithGoogle();
    if(context.mounted){
      hideLoading(dialogContext: context);
    }

    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showConfirmMessage(message: "User Signed Up with Google!", context: context);
      }
    } else {
      if (context.mounted) {
        showErrorMessage(message: universalData.error, context: context);
      }
    }
  }


  Future<void> addUser({required BuildContext context}) async {
    String userName = userController.text;
    String userEmail = emailController.text;

    if (userName.isNotEmpty && userEmail.isNotEmpty && userUrl.isNotEmpty) {
      UserModel userModel = UserModel(
        userId: "",
        userName: userName,
        email: userEmail,
        imageUrl: userUrl,
        createdAt: DateTime.now().toString(),
      );
      // showLoading(context: context);
      UniversalData universalData =
      await firebaseService.addUser(userModel: userModel);
      // if(context.mounted){
      //   hideLoading(dialogContext: context);
      // }

      if (universalData.error.isEmpty) {
        if (context.mounted) {
          showConfirmMessage(context: context, message: universalData.data as String);
          loginButtonPressed();
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          showErrorMessage(message: universalData.error, context: context);
        }
      }
    } else {
      showErrorMessage(message: "Maydonlar to'liq emas", context: context);
    }
  }

  Future<void> uploadCategoryImage(
      BuildContext context,
      XFile xFile,
      ) async {
    showLoading(context: context);
    UniversalData data = await FileUploader.imageUploader(xFile);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (data.error.isEmpty) {
      userUrl = data.data as String;
      notifyListeners();
    } else {
      if (context.mounted) {
        showErrorMessage(message: data.error, context: context);
      }
    }
  }
}
