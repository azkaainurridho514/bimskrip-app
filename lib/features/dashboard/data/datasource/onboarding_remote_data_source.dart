import 'dart:convert';
import 'dart:io';
import 'package:bimskrip/utils/app_url.dart';
import 'package:bimskrip/utils/params.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/rendering.dart';
import '../../../../utils/errors/exceptions.dart';
import '../models/login_model.dart';

abstract class OnboardingRemoteDataSource {
  Future<LoginAndRegisterModel> login({required LoginParam params});
  Future<LoginAndRegisterModel> register({required RegisterParam params});
}

class OnboardingRemoteDataSourceImpl implements OnboardingRemoteDataSource {
  // final Dio dio;

  OnboardingRemoteDataSourceImpl();

  @override
  Future<LoginAndRegisterModel> login({required LoginParam params}) async {
    Dio dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (
      HttpClient dioClient,
    ) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };
    try {
      final response = await dio.get(
        AppUrl.login,
        queryParameters: {'email': params.email, 'password': params.password},
      );
      if (response.statusCode == 201) {
        return LoginAndRegisterModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<LoginAndRegisterModel> register({
    required RegisterParam params,
  }) async {
    Dio dio = Dio();

    // Mengizinkan koneksi ke server dengan sertifikat self-signed (opsional)
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (
      HttpClient dioClient,
    ) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };

    try {
      print("ASkjhasdoifuhgsaioudefrgh");
      FormData formData = FormData.fromMap({
        "email": params.email,
        "password": params.password,
        "name": params.name,
        "phone": params.phone,
        "role_id": params.roleId,
        if (params.dosenPaId != 0) "dosen_pa_id": params.dosenPaId,
        if (params.photoPath != null && params.photoPath!.isNotEmpty)
          "photo": await MultipartFile.fromFile(params.photoPath!),
      });
      final response = await dio.post(
        AppUrl.register,
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}),
      );
      print(response);
      if (response.statusCode == 201) {
        return LoginAndRegisterModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      throw ServerException();
    }
  }
}
