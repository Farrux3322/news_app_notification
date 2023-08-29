import 'package:e_commerce/data/network/api_service.dart';
import 'package:e_commerce/data/repo/news_repsitory.dart';
import 'package:e_commerce/services/fcm.dart';
import 'package:e_commerce/services/local_notification_service.dart';
import 'package:e_commerce/ui/app_routes.dart';
import 'package:e_commerce/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cubits/news/news_cubit.dart';
import 'cubits/post/post_cubit.dart';
import 'data/local/storage_repository/storage_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  await Firebase.initializeApp();

  await initFirebase();

  await LocalNotificationService.instance.setupFlutterNotifications();

  runApp(App(apiService: ApiService()));
}

class App extends StatelessWidget {
  const App({required this.apiService, super.key});

  final ApiService apiService;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => NewsRepository(apiService: apiService),
          )
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => NewsCubit.instance,
          ),
          BlocProvider(
            create: (context) => PostNotificationCubit(
                newsRepository: context.read<NewsRepository>()),
          )
        ], child: const MyApp()));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 783),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,
          initialRoute: RouteNames.splashScreen,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
