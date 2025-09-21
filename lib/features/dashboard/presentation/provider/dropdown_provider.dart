import 'package:bimskrip/features/dashboard/bussines/usecase/dropdown.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/connection/network_info.dart';
import '../../../../utils/constraint.dart';
import '../../../../utils/errors/failure.dart';
import '../../data/datasource/dropdown_remote_data_source.dart';
import '../../data/datasource/local_data_source.dart';
import '../../data/models/dropdown_model.dart';
import '../../data/repositories/dropdown_repository_impl.dart';

class DropdownProvider extends ChangeNotifier {
  DropdownModel? mahasiswa;
  DropdownModel? dosen;
  Failure? failure;
  String _isLoadingPost = '';
  String get isLoadingPost => _isLoadingPost;
  set isLoadingPost(String value) {
    _isLoadingPost = value;
    notifyListeners();
  }

  String _isLoading = '';
  String get isLoading => _isLoading;
  set isLoading(String value) {
    _isLoading = value;
    notifyListeners();
  }

  String _isLoadingNew = '';
  String get isLoadingNew => _isLoadingNew;
  set isLoadingNew(String value) {
    _isLoadingNew = value;
    notifyListeners();
  }

  int pagesNew = 1;
  int pages = 1;
  DropdownProvider({this.failure});

  void eitherFailureOrMahasiswa() async {
    notifyListeners();
    DropdownRepositoryImpl repository = DropdownRepositoryImpl(
      remoteDataSource: DropdownRemoteDataSourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localDataSource: OnBoardingLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
    );

    final res = await GetDropdown(repository).executeGetMahasiswa();

    res.fold(
      (newRes) {
        mahasiswa = DropdownModel(
          statusCode: 404,
          message: "Not Found",
          data: [],
        );
        failure = newRes;
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

  void eitherFailureOrDosen() async {
    notifyListeners();
    DropdownRepositoryImpl repository = DropdownRepositoryImpl(
      remoteDataSource: DropdownRemoteDataSourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localDataSource: OnBoardingLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
    );

    final res = await GetDropdown(repository).executeGetDosen();

    res.fold(
      (newRes) {
        dosen = DropdownModel(statusCode: 404, message: "Not Found", data: []);
        failure = newRes;
        _isLoading = kLoadStop;
        notifyListeners();
      },
      (newProgres) {
        dosen = newProgres;
        failure = null;
        _isLoading = kLoadStop;
        notifyListeners();
      },
    );
  }
}
