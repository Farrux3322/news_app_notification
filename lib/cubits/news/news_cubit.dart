


import 'package:e_commerce/cubits/news/news_cubit_state.dart';
import 'package:e_commerce/data/local/db/local_database.dart';
import 'package:e_commerce/data/models/news_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsState>{
  NewsCubit._() : super(NewsInitial()){getNews();}


  static final NewsCubit instance = NewsCubit._();
  List<NewsModel> news=[];
  bool isLoading=false;


  getNews()async{
    news = await LocalDatabase.getAllNews();
    debugPrint("GET ALL");
    emit(NewsInitial());
  }

  deleteNews({required int id})async{
    emit(NewsLoadingState());
    await LocalDatabase.deleteNew(id);
    await getNews();
    debugPrint("DELETE");
    emit(NewsSuccessState());
  }

  deleteAllNews()async{
    emit(NewsLoadingState());
    await LocalDatabase.deleteAllNews();
    debugPrint("DELETE ALL");
    getNews();
    emit(NewsSuccessState());

  }

  insertNews({required NewsModel newsModel})async{
    emit(NewsLoadingState());
    await LocalDatabase.insertNews(newsModel);
    await getNews();
    debugPrint("INSERTTTT");
    emit(NewsSuccessState());
  }
}