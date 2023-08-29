import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/data/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/news/news_cubit.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen(
      {super.key, required this.newsModel, required this.index});

  final NewsModel newsModel;
  final int index;

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
        title: const Text("Detail Screen"),
        centerTitle: true,
        actions: [
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
                              "Are you sure you want to delete this New!",
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
                                          .deleteNews(id: newsModel.id ?? 0);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "New success deleted!")));
                                      Navigator.pop(context);
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
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                newsModel.newsDataTitle,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 22.sp),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Hero(
                  tag: index,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: CachedNetworkImage(
                      imageUrl:
                          context.watch<NewsCubit>().news[index].newsDataImg,
                      width: 300.w,
                      height: 300.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                newsModel.newsDataBody,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
