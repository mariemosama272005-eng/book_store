import 'package:bookia/core/networking/api_endPoints.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/feature/profile/data/models/profile_model.dart';
import 'package:dio/dio.dart';

class ProfileRepo {



   static Future<ProfileModel?> ? getProfileData()async{
    try {
      final response=await DioFactory.dio?.get(ApiEndpoints.profile);
      if (response?.statusCode==200) {
        ProfileModel profile=ProfileModel.fromJson(response?.data);
        return profile;
      }else{
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}