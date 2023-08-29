import 'package:e_commerce/ui/auth/widgets/global_button.dart';
import 'package:e_commerce/ui/auth/widgets/global_textfield.dart';
import 'package:e_commerce/utils/extension.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';
import '../../../utils/colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.onChanged});

  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w,),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            100.ph,
            GlobalTextField(
                controller: context.read<AuthProvider>().emailController,
                hintText: "Email",
                textInputType: TextInputType.emailAddress),
            50.ph,
            GlobalTextField(
              controller: context.read<AuthProvider>().passwordController,
              hintText: "Password",
              textInputType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            50.ph,
            GlobalButton(title: "Log In", onTap: (){
              context.read<AuthProvider>().loginUser(context);
            }),
            24.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      onChanged.call();
                      context.read<AuthProvider>().signUpButtonPressed();
                    },
                    child:  Text("Sign Up",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.c_3669C9),))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
