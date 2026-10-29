import 'package:bookia/core/networking/api_endPoints.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/feature/book_details/data/models/bookDitalisModel.dart';

class BookdetailsRepo {
  static Future<bookdetailsModel?> getbookDetails(int id) async {
    try {
      final response = await DioFactory.dio?.get(
        "${ApiEndpoints.ditails}$id",
      );

      if (response?.statusCode == 200) {
        return bookdetailsModel.fromJson(response?.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}