import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/connection/network_info.dart';
import '../../../../utils/errors/failure.dart';
import '../../bussines/usecase/name.dart';
import '../../data/datasource/local_data_source.dart';
import '../../data/datasource/name_remote_data_source.dart';
import '../../data/models/name_model.dart';
import '../../data/repositories/name_repository_impl.dart';

class NameProvider extends ChangeNotifier {
  NameModel? statusName;
  NameModel? progressName;
  Failure? failure;

  NameProvider({this.failure});

  void eitherFailureOrStatusName() async {
    notifyListeners();
    NameRepositoryImpl repository = NameRepositoryImpl(
      remoteDataSource: NameRemoteDataSourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localDataSource: OnBoardingLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
    );

    final ress = await GetName(repository).executeGetStatusName();

    ress.fold(
      (newFailure) {
        statusName = null;
        failure = newFailure;
        notifyListeners();
      },
      (newProgres) {
        statusName = newProgres;
        failure = null;
        notifyListeners();
      },
    );
  }

  void eitherFailureOrProgressName() async {
    notifyListeners();
    NameRepositoryImpl repository = NameRepositoryImpl(
      remoteDataSource: NameRemoteDataSourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localDataSource: OnBoardingLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
    );

    final ress = await GetName(repository).executeGetProgressName();

    ress.fold(
      (newFailure) {
        progressName = null;
        failure = newFailure;
        notifyListeners();
      },
      (newProgres) {
        progressName = newProgres;
        failure = null;
        notifyListeners();
      },
    );
  }
}
