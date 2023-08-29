


import 'package:equatable/equatable.dart';

abstract class PostNotificationState extends Equatable{}

class PostNotificationInitial extends PostNotificationState {
  @override
  List<Object?> get props => [];
}

class PostNotificationLoadingState extends PostNotificationState{
  @override
  List<Object?> get props => [];
}

class PostNotificationErrorState extends PostNotificationState{
  final String errorText;
  PostNotificationErrorState({required this.errorText});

  @override
  List<Object?> get props => [errorText];
}

class PostNotificationSuccessState extends PostNotificationState{
  @override
  List<Object?> get props => [];
}
class PostNotificationImageUploadState extends PostNotificationState{
  @override
  List<Object?> get props => [];
}
