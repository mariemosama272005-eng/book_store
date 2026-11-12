import 'package:bookia/feature/auth/data/model/user_model.dart';

class ForgotPasswordModel {
  final UserDataModel? data;
  final String? message;

  final int? status;

  ForgotPasswordModel({
    this.data,
    this.message,
 
    this.status,
  });

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(
      data: json['data'] != null
          ? UserDataModel.fromJson(json['data'])
          : null,
      message: json['message'],
      status: json['status'],
    );
  }
}