import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/connection/network_info.dart';
import '../../../../utils/constraint.dart';
import '../../../../utils/errors/failure.dart';
import '../../bussines/usecase/dashboard.dart';
import '../../data/datasource/dashboard_remote_data_source.dart';
import '../../data/datasource/local_data_source.dart';
import '../../data/models/dashboard_model.dart';
import '../../data/repositories/dashboard_repository_impl.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardModel? dashboard;
  Failure? failure;

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
  DashboardProvider({this.failure});

  void eitherFailureOrDashboard() async {
    _isLoading = kLoading;
    notifyListeners();
    DashboardRepositoryImpl repository = DashboardRepositoryImpl(
      remoteDataSource: DashboardRemoteDataSourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localDataSource: OnBoardingLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
    );

    final res = await GetDashboard(repository).executeDashboard();

    res.fold(
      (newRes) {
        dashboard = DashboardModel(
          statusCode: 404,
          message: "Not Found",
          data: null,
        );
        failure = newRes;
        _isLoading = kLoadStop;
        notifyListeners();
      },
      (newProgres) {
        dashboard = newProgres;
        failure = null;
        _isLoading = kLoadStop;
        notifyListeners();
      },
    );
  }
}
