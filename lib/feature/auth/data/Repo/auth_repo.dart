import 'package:bookia/core/Services/local/local_helper.dart';
import 'package:bookia/core/util/app_constans.dart';
import 'package:dio/dio.dart';

class AuthRepo {
   static Dio dio=Dio();
   static Future<bool> Login({required String email,required String password})async{
        try {
         final response=await dio.post("https://codingarabic.eraapro.com/api/login",data: {
            "email":email,
            "password":password
        });
        if(response.statusCode==200){
            String ?token=response.data["data"]["token"];
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
}) async {
  try {
    final response = await dio.post(
"https://codingarabic.eraapro.com/api/register", 
      data: {
        "name": name,
        "email": email,
        "password": password,
        
      },
    );
    
    if (response.statusCode == 200 || response.statusCode == 201) {
    

      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
static saveToken(String? token)async{
  await LocalHelper.prefs?.setString(AppConstans.userToken, token!);
}
}