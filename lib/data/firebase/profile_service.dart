import 'package:firebase_auth/firebase_auth.dart';

import '../models/universal_response.dart';

class ProfileService{
  Future<UniversalData> updateUserName({required String username})async{
    try{
      await FirebaseAuth.instance.currentUser?.updateDisplayName(username);
      return UniversalData(data: "Updated!");
    }on FirebaseAuthException catch(e){
      return UniversalData(error: e.code);
    }catch (error){
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> updateUserImg({required String imagePath})async{
    try{
      await FirebaseAuth.instance.currentUser?.updatePhotoURL(imagePath);
      return UniversalData(data: "Updated!");
    }on FirebaseAuthException catch(e){
      return UniversalData(error: e.code);
    }catch (error){
      return UniversalData(error: error.toString());
    }
  }
}