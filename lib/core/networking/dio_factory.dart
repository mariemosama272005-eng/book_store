import 'package:bookia/core/Services/local/local_helper.dart';
import 'package:bookia/core/util/app_constans.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  static Dio ?dio;
  static init(){
     dio=Dio(
      BaseOptions(baseUrl:"https://codingarabic.eraapro.com/api/",
      headers: {
        "Accept":"application/json",
        "Content-Type":"application/json",
          "Authorization":"Bearer ${LocalHelper.prefs?.get(AppConstans.userToken)}"
      }
      )
     );
      
        dio?.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args){
            // don't print requests with uris containing '/posts' 
            if(options.path.contains('/posts')){
              return false;
            }
            // don't print responses with unit8 list data
            return !args.isResponse || !args.hasUint8ListData;
          }
        )
        );
    
  }
}