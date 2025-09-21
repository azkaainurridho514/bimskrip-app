import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../../../utils/app_url.dart';
import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/params.dart';
import '../models/dropdown_model.dart';
import '../models/login_model.dart';
import '../models/progres_model.dart';

abstract class DropdownRemoteDataSource {
  Future<DropdownModel> getMahasiswa();
  Future<DropdownModel> getDosen();
}

class DropdownRemoteDataSourceImpl implements DropdownRemoteDataSource {
  // final Dio dio;

  DropdownRemoteDataSourceImpl();

  @override
  Future<DropdownModel> getMahasiswa() async {
    Dio dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (
      HttpClient dioClient,
    ) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };
    try {
      final response = await dio.get(AppUrl.allMahasiswa);
      if (response.statusCode == 201) {
        return DropdownModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<DropdownModel> getDosen() async {
    Dio dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (
      HttpClient dioClient,
    ) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };
    final response = await dio.get(AppUrl.allDosen);
    if (response.statusCode == 201) {
      return DropdownModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
