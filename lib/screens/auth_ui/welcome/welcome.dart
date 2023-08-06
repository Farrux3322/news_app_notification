import 'package:e_commerce/constanst/assets_images_dart.dart';
import 'package:e_commerce/constanst/routs.dart';
import 'package:e_commerce/screens/auth_ui/login/login.dart';
import 'package:e_commerce/widgets/primary_button/primary_button.dart';
import 'package:e_commerce/widgets/top_titles/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


import '../sign_up/sign_up.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitles(
                  subtitle: "Buy AnyItems From Using App ", title: "Welcome"),
              Center(
                child: Lottie.asset("assets/images/hi.json",height: MediaQuery.of(context).size.height*.5)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: const Icon(
                      Icons.facebook,
                      size: 35,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  CupertinoButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: Image.asset(
                      AssetsImages.instance.googleImage,
                      scale: 30.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              PrimaryButton(
                title: "Login",
                onPressed: () {
                  Routes.instance.push(widget: const Login(), context: context);
                },
              ),
              const SizedBox(
                height: 18.0,
              ),
              PrimaryButton(
                title: "Sign Up",
                onPressed: () {
                  Routes.instance.push(widget: const SignUp(), context: context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
