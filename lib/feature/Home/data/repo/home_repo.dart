import 'package:bookia/feature/Home/data/models/book_model.dart';
import 'package:dio/dio.dart';

class HomeRepo {
  static Dio dio=Dio();
  static getBestseller()async{
try {
  final response=await dio.get("https://codingarabic.eraapro.com/api/products-bestseller");
  if(response.statusCode==200){
BookModel book=BookModel.fromJson(response.data);
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