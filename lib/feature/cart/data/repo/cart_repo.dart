
import 'package:bookia/core/networking/api_endPoints.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/feature/cart/data/model/cart_model.dart';

class CartRepo {
  // =========================
  // SHOW CART
  // =========================

  static Future<Data?> showCart() async {
    try {
      final response = await DioFactory.dio?.get(
        ApiEndpoints.showCart,
      );

      print('SHOW CART STATUS: ${response?.statusCode}');
      print('SHOW CART RESPONSE: ${response?.data}');

      if (response?.statusCode == 200) {
        final CartModel cartModel = CartModel.fromJson(
          response!.data,
        );

        return cartModel.data;
      }

      return null;
    } catch (e) {
      print('SHOW CART ERROR: $e');
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
      );

      print('UPDATE CART STATUS: ${response?.statusCode}');
      print('UPDATE CART RESPONSE: ${response?.data}');

      if (response?.statusCode == 200 ||
          response?.statusCode == 201) {
        final CartModel cartModel = CartModel.fromJson(
          response!.data,
        );

        return cartModel.data;
      }

      return null;
    } catch (e) {
      print('UPDATE CART ERROR: $e');
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
      );

      print('REMOVE CART STATUS: ${response?.statusCode}');
      print('REMOVE CART RESPONSE: ${response?.data}');

      if (response?.statusCode == 200 ||
          response?.statusCode == 201) {
        final CartModel cartModel = CartModel.fromJson(
          response!.data,
        );

        return cartModel.data;
      }

      return null;
    } catch (e) {
      print('REMOVE CART ERROR: $e');
      return null;
    }
  }
}
