
import 'package:bookia/core/Services/local/local_helper.dart';
import 'package:bookia/core/networking/api_endPoints.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/core/networking/errorHandler.dart';
import 'package:bookia/core/util/app_constans.dart';
import 'package:bookia/feature/auth/data/model/forgetpass_model.dart';
import 'package:dio/dio.dart';

class AuthRepo {
  static Future<bool> Login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response?.statusCode == 200) {
        final data = response?.data;
        final token = data?["data"]?["token"];

        if (token == null || token.toString().isEmpty) {
          throw Exception('Login failed. No token received.');
        }

        await saveToken(token.toString());
        return true;
      }

      throw Exception('Login failed. Please try again.');
    } on DioException catch (e) {
      throw Exception(DioErrorHandler.handle(e));
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '');
      throw Exception(msg);
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
        final userData = response?.data?["data"];

        if (userData == null) {
          throw Exception('Registration failed. No user data received.');
        }

        final token = userData["token"];

        if (token == null || token.toString().isEmpty) {
          throw Exception('Registration failed. No token received.');
        }

        await saveToken(token.toString());

        await LocalHelper.prefs?.setString(
          "user_name",
          userData["name"]?.toString() ?? "",
        );

        await LocalHelper.prefs?.setString(
          "user_email",
          userData["email"]?.toString() ?? "",
        );

        return true;
      }

      throw Exception('Registration failed. Please try again.');
    } on DioException catch (e) {
      throw Exception(DioErrorHandler.handle(e));
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '');
      throw Exception(msg);
    }
  }


  static Future<ForgotPasswordModel> forgotPassword({
    required String email,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiEndpoints.forgetpass,
        data: {
          'email': email,
        },
      );

      if (response?.statusCode == 200 && response?.data != null) {
        return ForgotPasswordModel.fromJson(response!.data);
      }

      throw Exception('Something went wrong. Please try again.');
    } on DioException catch (e) {
      throw Exception(DioErrorHandler.handle(e));
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '');
      throw Exception(msg);
    }
  }


  static Future<bool> checkForgetPassword({
    required String email,
    required String code,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiEndpoints.checkForgetPassword,
        data: {
          'email': email,
          'code': code,
        },
      );

      if (response?.statusCode == 200) {
        return true;
      }

      throw Exception('Invalid or expired code. Please try again.');
    } on DioException catch (e) {
      throw Exception(DioErrorHandler.handle(e));
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '');
      throw Exception(msg);
    }
  }


  static Future<bool> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiEndpoints.resetPassword,
        data: {
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      if (response?.statusCode == 200) {
        return true;
      }

      throw Exception('Password reset failed. Please try again.');
    } on DioException catch (e) {
      throw Exception(DioErrorHandler.handle(e));
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '');
      throw Exception(msg);
    }
  }

  static Future<void> saveToken(String token) async {
    await LocalHelper.prefs?.setString(
      AppConstans.userToken,
      token,
    );
  }
}
