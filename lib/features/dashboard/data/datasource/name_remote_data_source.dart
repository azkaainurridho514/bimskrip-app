import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../../../utils/app_url.dart';
import '../../../../utils/errors/exceptions.dart';
import '../models/name_model.dart';

abstract class NameRemoteDataSource {
  Future<NameModel> getStatusName();
  Future<NameModel> getProgressName();
}

class NameRemoteDataSourceImpl implements NameRemoteDataSource {
  // final Dio dio;

  NameRemoteDataSourceImpl();

  @override
  Future<NameModel> getStatusName() async {
    Dio dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (
      HttpClient dioClient,
    ) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };
    try {
      final response = await dio.get(AppUrl.allStatusName);
      if (response.statusCode == 201) {
        return NameModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<NameModel> getProgressName() async {
    Dio dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (
      HttpClient dioClient,
    ) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };
    final response = await dio.get(AppUrl.allProgressName);
    if (response.statusCode == 201) {
      return NameModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
