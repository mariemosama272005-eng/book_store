import 'package:dio/dio.dart';

class AuthRepo {
   static Dio dio=Dio();
   static Future<bool> Login({required String email,required String password})async{
        try {
         final response=await dio.post("https://codingarabic.eraapro.com//login",data: {
            "email":email,
            "password":password
        });
        if(response.statusCode==200){
return true;
        }else{
            return false;
        }
        } catch (e) {
          return false;
        }

    }
}