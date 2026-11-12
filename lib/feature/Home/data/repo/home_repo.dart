import 'package:bookia/core/Services/local/local_helper.dart';
import 'package:bookia/core/networking/api_endPoints.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/core/networking/errorHandler.dart';
import 'package:bookia/core/util/app_constans.dart';
import 'package:bookia/feature/Home/data/models/book_model.dart';
import 'package:bookia/feature/Home/data/models/sliderModel.dart';
import 'package:dio/dio.dart';

class HomeRepo {
  static Options _getAuthOptions() {
    final token = LocalHelper.prefs?.getString(AppConstans.userToken) ??
        LocalHelper.prefs?.get(AppConstans.userToken)?.toString();

    return Options(
      headers: {
        if (token != null && token.isNotEmpty)
          'Authorization': 'Bearer $token',
      },
    );
  }

  static Future<BookModel?> getBestseller() async {
    try {
      final response = await DioFactory.dio?.get(
        ApiEndpoints.bestseller,
        options: _getAuthOptions(),
      );
      if (response?.statusCode == 200) {
        return BookModel.fromJson(response?.data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Products>?> search(String text) async {
    try {
      final response = await DioFactory.dio?.get(
        ApiEndpoints.search,
        queryParameters: {
          "name": text,
        },
        options: _getAuthOptions(),
      );
      if (response?.statusCode == 200) {
        final book = BookModel.fromJson(response?.data);
        return book.data?.products;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<SliderModel?> slider() async {
    try {
      final response = await DioFactory.dio?.get(
        ApiEndpoints.slider,
        options: _getAuthOptions(),
      );
      if (response?.statusCode == 200) {
        return SliderModel.fromJson(response?.data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> addToCart(int productId) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiEndpoints.addToCart,
        data: {
          "product_id": productId,
        },
        options: _getAuthOptions(),
      );

      return response?.statusCode == 200 || response?.statusCode == 201;
    } on DioException catch (e) {
      throw Exception(DioErrorHandler.handle(e));
    } catch (e) {
      return false;
    }
  }
}
