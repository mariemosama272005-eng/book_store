import 'package:bookia/core/networking/api_endPoints.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/feature/Home/data/models/book_model.dart';
import 'package:dio/dio.dart';

class HomeRepo {
  
  static getBestseller()async{
try {
  final response=await DioFactory.dio?.get(ApiEndpoints.bestseller);
  if(response?.statusCode==200){
BookModel book=BookModel.fromJson(response?.data);
return book;
  }
  else{
    return null;
  }
} catch (e) {
  return null;
}
  }
}