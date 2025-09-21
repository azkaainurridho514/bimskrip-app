import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../../../utils/app_url.dart';
import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/params.dart';
import '../models/progres_model.dart';

abstract class ProgresRemoteDataSource {
  Future<ProgresModel> getProgress({required ProgresParams params});
  Future<ProgresCreateModel> createProgress({required ProgresParams params});
  Future<ProgresCreateModel> updateProgress({
    required String statusId,
    required String id,
    required String comment,
  });
  Future<ProgresModel> deleteProgress({required ProgresParams params});
}

class ProgresRemoteDataSourceImpl implements ProgresRemoteDataSource {
  // final Dio dio;

  ProgresRemoteDataSourceImpl();

  @override
  Future<ProgresModel> getProgress({required ProgresParams params}) async {
    Dio dio = Dio();
    final response = await dio.get(
      AppUrl.allProgresses,
      queryParameters: {'user_id': params.userId, 'role_id': params.roleId},
    );
    if (response.statusCode == 201) {
      return ProgresModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProgresCreateModel> createProgress({
    required ProgresParams params,
  }) async {
    Dio dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (
      HttpClient dioClient,
    ) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };
    FormData formData = FormData.fromMap({
      "mhs_id": int.parse(params.userId),
      "name_id": int.parse(params.nameId),
      "dosen_pa_id": int.parse(params.dpaId),
      "desc": params.content,
      'file': await MultipartFile.fromFile(params.file),
    });
    try {
      final response = await dio.post(
        AppUrl.createProgress,
        options: Options(headers: {"Content-Type": "multipart/form-data"}),
        data: formData,
      );
      if (response.statusCode == 201) {
        return ProgresCreateModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ProgresCreateModel> updateProgress({
    required String statusId,
    required String id,
    required String comment,
  }) async {
    Dio dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (
      HttpClient dioClient,
    ) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };
    var paramRegister = {
      "status_id": int.parse(statusId),
      "id": int.parse(id),
      "comment": comment,
    };
    print(paramRegister);
    try {
      final response = await dio.put(
        AppUrl.updateStatusProgress,
        // queryParameters: {'user_id': params.userId, 'role_id': params.roleId},
        options: Options(
          headers: {HttpHeaders.contentTypeHeader: "application/json"},
        ),
        data: paramRegister,
      );
      print(response);
      if (response.statusCode == 201) {
        return ProgresCreateModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ProgresModel> deleteProgress({required ProgresParams params}) async {
    Dio dio = Dio();
    try {
      final response = await dio.get(
        AppUrl.allProgresses,
        queryParameters: {'user_id': params.userId, 'role_id': params.roleId},
      );
      if (response.statusCode == 201) {
        return ProgresModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }
}
