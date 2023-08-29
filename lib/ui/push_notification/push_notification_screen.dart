import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../cubits/post/post_cubit.dart';
import '../../utils/colors.dart';

class PushNotificationScreen extends StatefulWidget {
  const PushNotificationScreen({super.key});

  @override
  State<PushNotificationScreen> createState() => _PushNotificationScreenState();
}

class _PushNotificationScreenState extends State<PushNotificationScreen> {
  ImagePicker picker = ImagePicker();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:const SystemUiOverlayStyle(
          statusBarColor: Colors.black, // <-- SEE HERE
          statusBarIconBrightness: Brightness.light, //<-- For Android SEE HERE (dark icons)
          statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
        ),
        backgroundColor: Colors.black,
        title: const Text("Push Notification"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.1),
              TextField(
                style: const TextStyle(color: Colors.black),
                controller: titleController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.title),
                  hintText: "Title",
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide:
                      const BorderSide(width: 1, color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide:
                      const BorderSide(width: 1, color: Colors.black)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide:
                      const BorderSide(width: 1, color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide:
                      const BorderSide(width: 1, color: Colors.black)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide:
                      const BorderSide(width: 1, color: Colors.black)),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextField(
                style: const TextStyle(color: Colors.black),
                controller: descController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.description),
                  hintText: "Description",
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide:
                      const BorderSide(width: 1, color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide:
                      const BorderSide(width: 1, color: Colors.black)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide:
                      const BorderSide(width: 1, color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide:
                      const BorderSide(width: 1, color: Colors.black)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide:
                      const BorderSide(width: 1, color: Colors.black)),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ZoomTapAnimation(
                onTap: () {
                  showBottomSheetDialog();
                },
                child: Container(
                  padding: EdgeInsets.all(14.sp),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.black),
                  child: Center(
                    child: context
                        .watch<PostNotificationCubit>()
                        .imageUrl
                        .isEmpty
                        ? const Text(
                      "Image Not Selected",
                      style: TextStyle(color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                        : Image.network(
                        context.watch<PostNotificationCubit>().imageUrl),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ZoomTapAnimation(
                onTap: () {
                  if (titleController.text.isNotEmpty &&
                      descController.text.isNotEmpty &&
                      context
                          .read<PostNotificationCubit>()
                          .imageUrl
                          .isNotEmpty) {
                    context.read<PostNotificationCubit>().postNotification(
                        title: titleController.text,
                        description: descController.text);
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 700),
                        backgroundColor: Colors.red,
                        margin: EdgeInsets.symmetric(
                          vertical: 100,
                          horizontal: 20,
                        ),
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          "Maydonlari to'ldiring!!!",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: AppColors.black),
                  child: Center(
                    child: Text(
                      "Post",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text(
                  "Select from Camera",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo),
                title: const Text(
                  "Select from Gallery",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (xFile != null) {
      if (context.mounted) {
        await BlocProvider.of<PostNotificationCubit>(context, listen: false)
            .uploadCategoryImage(context, xFile);
      }
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null) {
      if (context.mounted) {
        await BlocProvider.of<PostNotificationCubit>(context, listen: false)
            .uploadCategoryImage(context, xFile);
      }
    }
  }
}
