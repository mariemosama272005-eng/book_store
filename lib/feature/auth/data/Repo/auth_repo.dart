import 'package:bookia/core/Services/local/local_helper.dart';
import 'package:bookia/core/networking/api_endPoints.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/core/util/app_constans.dart';
import 'package:dio/dio.dart';

class AuthRepo {

   static Future<bool> Login({required String email,required String password})async{
        try {
         final response=await DioFactory.dio?.post(ApiEndpoints.login,data: {
            "email":email,
            "password":password
        });
        if(response?.statusCode==200){
            String ?token=response?.data["data"]["token"];
      saveToken(token);
return true;
        }else{
            return false;
        }
        } catch (e) {
          return false;
        }

    }

  static Future<bool> Register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String address,
    required String city,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiEndpoints.reg, 
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
          "address": address,
          "city": city,
        },
      );
      
      if (response?.statusCode == 200 || response?.statusCode == 201) {
        var userData = response?.data["data"];
        String? token = userData["token"];
        await saveToken(token);
        await LocalHelper.prefs?.setString("user_name", userData["name"] ?? "");
        await LocalHelper.prefs?.setString("user_email", userData["email"] ?? "");

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static saveToken(String? token) async {
    await LocalHelper.prefs?.setString(AppConstans.userToken, token!);
  }
}