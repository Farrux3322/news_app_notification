import 'package:e_commerce/ui/auth/widgets/global_button.dart';
import 'package:e_commerce/ui/auth/widgets/global_textfield.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/extension.dart';
import 'package:e_commerce/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key, required this.onChanged, required this.parentContext});

  final VoidCallback onChanged;
  final BuildContext parentContext;

  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        children: [Expanded(
          child: ListView(
            children: [
              80.ph,
              GlobalTextField(
                hintText: "Username",
                textInputType: TextInputType.name,
                controller: context.read<AuthProvider>().userController,
              ),
              24.ph,
              GlobalTextField(
                hintText: "Email",
                textInputType: TextInputType.emailAddress,
                controller: context.read<AuthProvider>().emailController,
              ),
              24.ph,
              GlobalTextField(
                isPassword: true,
                hintText: "Password",
                textInputType: TextInputType.visiblePassword,
                controller: context.read<AuthProvider>().passwordController,
              ),
              24.ph,
              GlobalTextField(isPassword: true,
                hintText: "Confirm Password",
                textInputType: TextInputType.visiblePassword,
                controller:
                context.read<AuthProvider>().confirmPasswordController,
              ),
              24.ph,
              SizedBox(
                width: 150,
                height: 150,
                child: TextButton(
                  onPressed: () {
                    showBottomSheetDialog(parentContext);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).indicatorColor),
                  child: context
                      .watch<AuthProvider>()
                      .userUrl
                      .isEmpty
                      ?  Text(
                    "Image Not Selected",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                      : Image.network(
                      context.watch<AuthProvider>().userUrl),
                ),
              ),
              24.ph,
              GlobalButton(
                  title: "Sign up",
                  onTap: () {
                    context.read<AuthProvider>().checkPassword(context);
                  }),
              24.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        onChanged.call();
                        context.read<AuthProvider>().loginButtonPressed();
                      },
                      child: Text("Log In",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.c_3669C9),))
                ],
              ),
              TextButton(
                  onPressed: () {
                    context.read<AuthProvider>().signInWithGoogle(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Sign Up with Google"),
                      const SizedBox(width: 12),
                      SvgPicture.asset(AppIcons.google)
                    ],
                  ))
            ],
          ),
        )],
      ),
    );



  }
   void showBottomSheetDialog(BuildContext context2) {
     showModalBottomSheet(
       backgroundColor: Colors.transparent,
       context:  context2,
       builder: (BuildContext context) {
         return Container(
           padding: const EdgeInsets.all(24),
           height: 200,
           decoration: BoxDecoration(
             color: AppColors.c_3669C9,
             borderRadius:  BorderRadius.only(
               topLeft: Radius.circular(16.r),
               topRight: Radius.circular(16.r),
             ),
           ),
           child: Column(
             children: [
               ListTile(
                 onTap: () {
                   getFromCamera(context2);
                   Navigator.pop(context);
                 },
                 leading: const Icon(Icons.camera_alt),
                 title: const Text("Select from Camera"),
               ),
               ListTile(
                 onTap: () {
                   getFromGallery(context2);
                   Navigator.pop(context);
                 },
                 leading: const Icon(Icons.photo),
                 title: const Text("Select from Gallery"),
               )
             ],
           ),
         );
       },
     );
   }
   Future<void> getFromCamera(BuildContext context) async {
     XFile? xFile = await picker.pickImage(
       source: ImageSource.camera,
       maxHeight: 512,
       maxWidth: 512,
     );

     if (xFile != null) {
       await Provider.of<AuthProvider>(context,listen: false)
           .uploadCategoryImage(context , xFile);

     }
   }
   Future<void> getFromGallery(BuildContext context) async {
     XFile? xFile = await picker.pickImage(
       source: ImageSource.gallery,
       maxHeight: 512,
       maxWidth: 512,
     );
     if (xFile != null) {
       await Provider.of<AuthProvider>(context ,listen: false)
           .uploadCategoryImage(context, xFile);
     }
   }
}
