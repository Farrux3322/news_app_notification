import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/ui/app_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../cubits/news/news_cubit.dart';
import '../../cubits/news/news_cubit_state.dart';
import '../../data/local/storage_repository/storage_repository.dart';
import '../../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSubs = StorageRepository.getBool("subs");

  checking() async {
    isSubs
        ? await FirebaseMessaging.instance.subscribeToTopic("news")
        : await FirebaseMessaging.instance.unsubscribeFromTopic("news");
  }

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
        title: const Text("Daryo"),
        centerTitle: true,
        actions: [
          Switch(
            onChanged: (value) {
              isSubs = !isSubs;
              StorageRepository.putBool("subs", isSubs);
              setState(() {
                checking();
              });
            },
            value: isSubs,
          ),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: SizedBox(
                          height: 125.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Delete This New",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Roboto"),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Are you sure you want to delete all News!",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Roboto"),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("No")),
                                  TextButton(
                                      onPressed: () {
                                        context
                                            .read<NewsCubit>()
                                            .deleteAllNews();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "News success deleted!")));
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(color: Colors.red),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: 30.sp,
              ))
        ],
      ),
      body: BlocConsumer<NewsCubit, NewsState>(
        builder: (context, state) {
          return context.watch<NewsCubit>().news.isEmpty
              ? Center(child: Lottie.asset("assets/images/hi.json"))
              : ListView(
                  children: [
                    ...List.generate(
                      context.watch<NewsCubit>().news.length,
                      (index) => ZoomTapAnimation(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.newsDetail,
                            arguments: {
                              "model": context.read<NewsCubit>().news[index],
                              "index": index
                            },
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          width: double.infinity,
                          height: 80.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: Colors.grey.shade200,
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade400),
                              boxShadow: const [
                                BoxShadow(color: Colors.black, blurRadius: 10)
                              ]),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Hero(
                                tag: index,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.r),
                                  child: CachedNetworkImage(
                                    imageUrl: context
                                        .watch<NewsCubit>()
                                        .news[index]
                                        .newsDataImg,
                                    width: 60.w,
                                    height: 60.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Expanded(
                                      child: SizedBox(
                                        width: 200.w,
                                        child: Text(
                                          context
                                              .watch<NewsCubit>()
                                              .news[index]
                                              .newsDataTitle,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
        },
        listener: (context, state) {
          if (state is NewsSuccessState) {
            context.read<NewsCubit>().getNews();
            setState(() {});
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.pushNamed(context, RouteNames.pushNotificationScreen);
        },
        child: Icon(
          Icons.add_circle_outline,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

// Positioned(
// right: 0,
// top: 0,
// child: Text(
// context
//     .watch<NewsCubit>()
//     .news[index]
//     .newsDataDatetime
//     .substring(0, 16),
// style: TextStyle(
// color: AppColors.black,
// fontSize: 14.sp,
// fontWeight: FontWeight.w600),
// ),
// )