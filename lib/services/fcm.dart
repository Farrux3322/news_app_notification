import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import '../cubits/news/news_cubit.dart';
import '../data/local/storage_repository/storage_repository.dart';
import '../data/models/news_model.dart';
import 'local_notification_service.dart';

Future<void> initFirebase() async {
  NewsCubit newsCubit = NewsCubit.instance;
  bool isSubs=StorageRepository.getBool("subs");
  await Firebase.initializeApp();
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  debugPrint("FCM USER TOKEN: $fcmToken");
  isSubs? await  FirebaseMessaging.instance.subscribeToTopic("news"):await FirebaseMessaging.instance.unsubscribeFromTopic("news");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint(
        "NOTIFICATION FOREGROUND MODE: ${message.data["title"]} va ${message.notification!.title} in foreground");
    LocalNotificationService.instance.showFlutterNotification(message);
    newsCubit.insertNews(newsModel: NewsModel(
      newsTitle: message.notification?.title ?? "",
      newsBody: message.notification?.body ?? "",
      newsDataTitle: message.data["title"],
      newsDataBody: message.data["body"],
      newsDataImg: message.data["image"],
      newsDataDatetime: DateTime.now().toString(),
    ),);
    newsCubit.getNews();
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  handelMessage(RemoteMessage message) {
    newsCubit.insertNews(newsModel: NewsModel(
      newsTitle: message.notification?.title ?? "",
      newsBody: message.notification?.body ?? "",
      newsDataTitle: message.data["title"],
      newsDataBody: message.data["body"],
      newsDataImg: message.data["image"],
      newsDataDatetime: DateTime.now().toString(),
    ),);
    newsCubit.getNews();

    debugPrint(
        "NOTIFICATION FROM TERMINATED MODE: ${message.data["title"]} va ${message.notification!.title} in terminated");
    LocalNotificationService.instance.showFlutterNotification(message);

  }

  RemoteMessage? remoteMessage =
  await FirebaseMessaging.instance.getInitialMessage();

  if (remoteMessage != null) {
    handelMessage(remoteMessage);
  }

  FirebaseMessaging.onMessageOpenedApp.listen(handelMessage);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  NewsCubit newsCubit = NewsCubit.instance;
  await Firebase.initializeApp();
  LocalNotificationService.instance.showFlutterNotification(message);
  newsCubit.insertNews(newsModel: NewsModel(
    newsTitle: message.notification?.title ?? "",
    newsBody: message.notification?.body ?? "",
    newsDataTitle: message.data["title"],
    newsDataBody: message.data["body"],
    newsDataImg: message.data["image"],
    newsDataDatetime: DateTime.now().toString(),
  ),);
  newsCubit.getNews();
  debugPrint(
      "NOTIFICATION BACKGROUND MODE: ${message.data["title"]} va ${message.notification!.title} in background");
}
