import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/connection/network_info.dart';
import '../../../../utils/constraint.dart';
import '../../../../utils/errors/failure.dart';
import '../../bussines/usecase/mahasiswa_by_dosen.dart';
import '../../data/datasource/local_data_source.dart';
import '../../data/datasource/mahasiswa_by_dosen_remote_data_source .dart';
import '../../data/models/mahasiswa_by_dosen_model.dart';
import '../../data/repositories/mahasiswa_by_dosen_repository_impl.dart';

class MahasiswaByDosenProvider extends ChangeNotifier {
  MahasiswaByDosenModel? mahasiswa;
  MahasiswaByDosenModel? dosen;
  Failure? failure;

  String _isLoading = '';
  String get isLoading => _isLoading;
  set isLoading(String value) {
    _isLoading = value;
    notifyListeners();
  }

  MahasiswaByDosenProvider({this.failure});

  void eitherFailureOrGetMahasiswaByDosen({required int id}) async {
    notifyListeners();
    MahasiswaByDosenRepositoryImpl repository = MahasiswaByDosenRepositoryImpl(
      remoteDataSource: MahasiswaByDosenRemoteDataSourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localDataSource: OnBoardingLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
    );

    final disbur = await GetMahasiswaByDosen(
      repository,
    ).executeGetMahasiswaByDosen(id: id);

    disbur.fold(
      (newFailure) {
        mahasiswa = null;
        failure = newFailure;
        _isLoading = kLoadStop;
        notifyListeners();
      },
      (newProgres) {
        mahasiswa = newProgres;
        failure = null;
        _isLoading = kLoadStop;
        notifyListeners();
      },
    );
  }
}
