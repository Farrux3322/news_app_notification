

import 'package:e_commerce/data/network/api_service.dart';

import '../models/universal_response.dart';

class NewsRepository {
  final ApiService apiService;

  NewsRepository({required this.apiService});

  Future<UniversalData> postNotification(
      {required String title,
        required String description,
        required String image}) async =>
      apiService.postNotification(
          title: title, description: description, image: image);
}
