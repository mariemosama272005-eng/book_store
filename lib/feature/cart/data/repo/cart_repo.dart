import 'package:bookia/core/Services/local/local_helper.dart';
import 'package:bookia/core/networking/api_endPoints.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/core/util/app_constans.dart';
import 'package:bookia/feature/cart/data/model/cart_model.dart';
import 'package:dio/dio.dart';

class CartRepo {
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

  // =========================
  // SHOW CART
  // =========================
  static Future<Data?> showCart() async {
    try {
      final response = await DioFactory.dio?.get(
        ApiEndpoints.showCart,
        options: _getAuthOptions(),
      );

      if (response?.statusCode == 200) {
        if (response?.data != null && response!.data is Map<String, dynamic>) {
          final CartModel cartModel = CartModel.fromJson(response.data);
          return cartModel.data ?? Data(cartItems: [], total: "0.00");
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  // =========================
  // UPDATE CART
  // =========================
  static Future<Data?> updateCart({
    required int itemId,
    required int quantity,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiEndpoints.Updatecart,
        data: {
          'cart_item_id': itemId,
          'quantity': quantity,
        },
        options: _getAuthOptions(),
      );

      if (response?.statusCode == 200 || response?.statusCode == 201) {
        if (response?.data != null && response!.data is Map<String, dynamic>) {
          final CartModel cartModel = CartModel.fromJson(response.data);
          return cartModel.data ?? Data(cartItems: [], total: "0.00");
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  // =========================
  // REMOVE FROM CART
  // =========================
  static Future<Data?> removeFromCart({
    required int itemId,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiEndpoints.removefromcart,
        data: {
          'cart_item_id': itemId,
        },
        options: _getAuthOptions(),
      );

      if (response?.statusCode == 200 || response?.statusCode == 201) {
        if (response?.data != null && response!.data is Map<String, dynamic>) {
          final CartModel cartModel = CartModel.fromJson(response.data);
          return cartModel.data ?? Data(cartItems: [], total: "0.00");
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
