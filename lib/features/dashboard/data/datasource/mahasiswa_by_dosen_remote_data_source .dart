import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../../../utils/app_url.dart';
import '../../../../utils/errors/exceptions.dart';
import '../models/mahasiswa_by_dosen_model.dart';

abstract class MahasiswaByDosenRemoteDataSource {
  Future<MahasiswaByDosenModel> getMahasiswaByDosen({required int id});
}

class MahasiswaByDosenRemoteDataSourceImpl
    implements MahasiswaByDosenRemoteDataSource {
  // final Dio dio;

  MahasiswaByDosenRemoteDataSourceImpl();

  @override
  Future<MahasiswaByDosenModel> getMahasiswaByDosen({required int id}) async {
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
        AppUrl.allMahasiswaByDosen,
        queryParameters: {'dosen_pa_id': id},
      );
      if (response.statusCode == 201) {
        return MahasiswaByDosenModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException();
    }
  }
}
