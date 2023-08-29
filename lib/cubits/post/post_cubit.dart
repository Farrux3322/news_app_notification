
import 'package:e_commerce/cubits/post/post_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';

import '../../data/firebase/upload_service.dart';
import '../../data/models/universal_response.dart';
import '../../data/repo/news_repsitory.dart';
import '../../utils/ui_utils/error_message_dialog.dart';
import '../../utils/ui_utils/loading_dialog.dart';


class PostNotificationCubit extends Cubit<PostNotificationState> {
  PostNotificationCubit({required this.newsRepository})
      : super(PostNotificationInitial());

  final NewsRepository newsRepository;
  bool isLoading = false;
  String imageUrl = "";

  Future<void> postNotification(
      {required String title,
        required String description}) async {
    isLoading = true;
    UniversalData universalData = await newsRepository.postNotification(
        title: title, description: description, image: imageUrl);
    isLoading=false;
    if (universalData.error.isEmpty) {
      imageUrl="";
      emit(PostNotificationSuccessState());
    } else {
      emit(PostNotificationErrorState(errorText: universalData.error));
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
      imageUrl = data.data as String;
      emit(PostNotificationImageUploadState());
    } else {
      if (context.mounted) {
        showErrorMessage(context: context,message: data.error);
      }
    }
  }
}
