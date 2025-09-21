import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/connection/network_info.dart';
import '../../../../utils/constraint.dart';
import '../../../../utils/errors/failure.dart';
import '../../../../utils/params.dart';
import '../../bussines/usecase/get_all_progress.dart';
import '../../data/datasource/local_data_source.dart';
import '../../data/datasource/progres_remote_data_source.dart';
import '../../data/models/progres_model.dart';
import '../../data/repositories/progres_repository_impl.dart';

class ProgresProvider extends ChangeNotifier {
  ProgresCreateModel? createProgress;
  ProgresModel? progress;
  Failure? failure;

  String _isLoading = '';
  String get isLoading => _isLoading;
  set isLoading(String value) {
    _isLoading = value;
    notifyListeners();
  }

  String _isLoadingCreate = '';
  String get isLoadingCreate => _isLoadingCreate;
  set isLoadingCreate(String value) {
    _isLoadingCreate = value;
    notifyListeners();
  }

  ProgresProvider({this.progress, this.failure});

  void eitherFailureOrProgress({
    required String userId,
    required String roleId,
  }) async {
    isLoading = kLoading;
    notifyListeners();
    ProgresRepositoryImpl repository = ProgresRepositoryImpl(
      remoteDataSource: ProgresRemoteDataSourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localDataSource: OnBoardingLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
    );

    final disbur = await GetAllProgress(repository).executeGetAllProgress(
      params: ProgresParams(
        userId: userId,
        roleId: roleId,
        content: "",
        nameId: "",
        dpaId: "",
        file: "",
      ),
    );

    disbur.fold(
      (newFailure) {
        progress = null;
        failure = newFailure;
        _isLoading = kLoadStop;
        notifyListeners();
      },
      (newProgres) {
        progress = newProgres;
        failure = null;
        _isLoading = kLoadStop;
        notifyListeners();
      },
    );
  }

  void eitherFailureOrCreateProgress({
    required String userId,
    required String dpaId,
    required String roleId,
    required String nameId,
    required String content,
    required String file,
  }) async {
    _isLoadingCreate = kLoading;
    notifyListeners();
    ProgresRepositoryImpl repository = ProgresRepositoryImpl(
      remoteDataSource: ProgresRemoteDataSourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localDataSource: OnBoardingLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
    );

    final disbur = await GetAllProgress(repository).executeGetCreateProgress(
      params: ProgresParams(
        content: content,
        nameId: nameId,
        userId: userId,
        dpaId: dpaId,
        roleId: "",
        file: file,
      ),
    );

    disbur.fold(
      (newFailure) {
        createProgress = null;
        failure = newFailure;
        _isLoadingCreate = kLoadStop;
        notifyListeners();
      },
      (newProgres) {
        createProgress = newProgres;
        failure = null;
        _isLoadingCreate = kLoadStop;
        notifyListeners();
      },
    );
  }

  void eitherFailureOrUpdateProgress({
    required String statusId,
    required String id,
    required String comment,
  }) async {
    _isLoadingCreate = kLoading;
    notifyListeners();
    ProgresRepositoryImpl repository = ProgresRepositoryImpl(
      remoteDataSource: ProgresRemoteDataSourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localDataSource: OnBoardingLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
    );

    final disbur = await GetAllProgress(
      repository,
    ).executeGetUpdateProgress(statusId: statusId, id: id, comment: comment);

    disbur.fold(
      (newFailure) {
        createProgress = null;
        failure = newFailure;
        _isLoadingCreate = kLoadStop;
        notifyListeners();
      },
      (newProgres) {
        createProgress = newProgres;
        failure = null;
        _isLoadingCreate = kLoadStop;
        notifyListeners();
      },
    );
  }
}
