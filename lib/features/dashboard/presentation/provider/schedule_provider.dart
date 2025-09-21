import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/connection/network_info.dart';
import '../../../../utils/constraint.dart';
import '../../../../utils/errors/failure.dart';
import '../../../../utils/params.dart';
import '../../bussines/usecase/schelude.dart';
import '../../data/datasource/local_data_source.dart';
import '../../data/datasource/schedule_remote_data_source.dart';
import '../../data/models/schedule_model.dart';
import '../../data/repositories/schedule_repository_impl.dart';

class ScheduleProvider extends ChangeNotifier {
  ScheduleModel? schedules;
  ScheduleModel? todaySchedules;
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

  ScheduleProvider({this.failure});

  void eitherFailureOrSchedules({
    required String userId,
    required String roleId,
  }) async {
    _isLoading = kLoading;
    notifyListeners();
    ScheduleRepositoryImpl repository = ScheduleRepositoryImpl(
      remoteDataSource: ScheduleRemoteDataSourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localDataSource: OnBoardingLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
    );

    final disbur = await GetAllSchedule(repository).executeGetAllSchedule(
      params: ScheduleParams(
        userId: userId,
        roleId: roleId,
        date: "",
        mahasiswaId: "",
        tempat: "",
      ),
    );

    disbur.fold(
      (newFailure) {
        schedules = null;
        failure = newFailure;
        _isLoading = kLoadStop;
        notifyListeners();
      },
      (newSchedule) {
        schedules = newSchedule;
        _isLoading = kLoadStop;
        failure = null;
        notifyListeners();
      },
    );
  }

  void eitherFailureOrTodaySchedules({
    required String userId,
    required String roleId,
  }) async {
    _isLoading = kLoading;
    notifyListeners();
    ScheduleRepositoryImpl repository = ScheduleRepositoryImpl(
      remoteDataSource: ScheduleRemoteDataSourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localDataSource: OnBoardingLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
    );

    final disbur = await GetAllSchedule(repository).executeGetTodaySchedule(
      params: ScheduleParams(
        userId: userId,
        roleId: roleId,
        date: "",
        mahasiswaId: "",
        tempat: "",
      ),
    );

    disbur.fold(
      (newFailure) {
        todaySchedules = null;
        failure = newFailure;
        _isLoading = kLoadStop;
        notifyListeners();
      },
      (newSchedule) {
        todaySchedules = newSchedule;
        _isLoading = kLoadStop;
        failure = null;
        notifyListeners();
      },
    );
  }

  void eitherFailureOrCreateSchedules({
    required String userId,
    required String mahasiswaId,
    required String tempat,
    required String date,
  }) async {
    _isLoadingCreate = kLoading;
    notifyListeners();
    ScheduleRepositoryImpl repository = ScheduleRepositoryImpl(
      remoteDataSource: ScheduleRemoteDataSourceImpl(),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
      localDataSource: OnBoardingLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
    );

    final disbur = await GetAllSchedule(repository).executeGetCreateSchedule(
      params: ScheduleParams(
        userId: userId,
        roleId: "",
        date: date,
        mahasiswaId: mahasiswaId,
        tempat: tempat,
      ),
    );

    disbur.fold(
      (newFailure) {
        schedules = null;
        failure = newFailure;
        _isLoadingCreate = kLoadStop;
        notifyListeners();
      },
      (newSchedule) {
        schedules = newSchedule;
        failure = null;
        _isLoadingCreate = kLoadStop;
        notifyListeners();
      },
    );
  }
}
