import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../../../utils/app_url.dart';
import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/params.dart';
import '../models/schedule_model.dart';

abstract class ScheduleRemoteDataSource {
  Future<ScheduleModel> getSchedules({required ScheduleParams params});
  Future<ScheduleModel> getTodaySchedules({required ScheduleParams params});
  Future<ScheduleModel> createSchedules({required ScheduleParams params});
}

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  // final Dio dio;

  ScheduleRemoteDataSourceImpl();

  @override
  Future<ScheduleModel> getSchedules({required ScheduleParams params}) async {
    Dio dio = Dio();

    try {
      final response = await dio.get(
        AppUrl.allSchedule,
        queryParameters: {'user_id': params.userId, 'role_id': params.roleId},
      );
      if (response.statusCode == 201) {
        return ScheduleModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ScheduleModel> getTodaySchedules({
    required ScheduleParams params,
  }) async {
    Dio dio = Dio();

    try {
      final response = await dio.get(
        AppUrl.allTodaySchedule,
        queryParameters: {'user_id': params.userId, 'role_id': params.roleId},
      );
      if (response.statusCode == 201) {
        print(response.data);
        return ScheduleModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ScheduleModel> createSchedules({
    required ScheduleParams params,
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
      "mhs_id": int.parse(params.mahasiswaId),
      "dosen_pa_id": int.parse(params.userId),
      "tempat": params.tempat,
      "date": params.date,
    };
    print(paramRegister);
    try {
      final response = await dio.post(
        AppUrl.createSchedule,
        // queryParameters: {'user_id': params.userId, 'role_id': params.roleId},
        options: Options(
          headers: {HttpHeaders.contentTypeHeader: "application/json"},
        ),
        data: paramRegister,
      );
      if (response.statusCode == 201) {
        print(response.data);
        return ScheduleModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }
}
