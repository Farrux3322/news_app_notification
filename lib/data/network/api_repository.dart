
import 'package:e_commerce/data/network/api_provider.dart';

import '../models/default_model.dart';
import '../models/universal_response.dart';

class ApiRepository{
  final ApiProvider apiProvider;
  ApiRepository({required this.apiProvider});

  Future<List<DefaultModel>> postNotification({required String title,required String description,required String image,})async{
    UniversalData universalResponse=await apiProvider.postNotification(title: title, description: description, image: image);
    if(universalResponse.error.isEmpty){
      return universalResponse.data as  List<DefaultModel>;
    }
    return [];
  }
}