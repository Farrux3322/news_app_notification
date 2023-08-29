import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/default_model.dart';
import '../models/universal_response.dart';

class ApiProvider {
  Future<UniversalData> postNotification(
      {required String title,
      required String description,
      required String image}) async {
    Uri uri = Uri.parse("https://fcm.googleapis.com/fcm/send");
    try {
      http.Response response = await http.post(uri, headers: <String, String>{
        "content-type": "application/json",
        "Authorization":
            "key=AAAAV-sOZLg:APA91bHEBbjntxEWoOfVmjg6ygBVbCMjcTDuE9bkwBWun5eTKCHSuTrMFHS35PVwdp0UHnvx-PUqEpYI0ycj07uw6MbsAY_5DS-bvnxHCTRKmKBcdDxr38uXLx-_2nPVO0FjxcEnrDJ7"
      },body: jsonEncode(<String,dynamic>{
        "to":"/topics/news",
        "notification":{
          "title":"NEWS APP",
          "body":"YANGILIKLAR DUNYOSI"
        },"data":{
          "title":title,
          "body":description,
          "image":image
        }
      }));

      if (response.statusCode == 200) {
        print("SUCSESSSSSSSSSS");
        return UniversalData(
            data: (jsonDecode(response.body) as List?)
                    ?.map((e) => DefaultModel.fromJson(e))
                    .toString() ??
                []);
      }
      return UniversalData(error: "ERROR");
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}
