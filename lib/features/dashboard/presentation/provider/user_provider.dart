import 'package:bimskrip/features/dashboard/bussines/entities/user.dart';
import 'package:bimskrip/features/dashboard/bussines/usecase/boarding.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/connection/network_info.dart';
import '../../../../utils/errors/failure.dart';
import '../../data/datasource/local_data_source.dart';
import '../../data/datasource/onboarding_remote_data_source.dart';
import '../../data/repositories/onboarding_repository_impl.dart';

class UserProvider extends ChangeNotifier {
  User? users;
  Failure? failure;

  String _isLoading = '';
  String get isLoading => _isLoading;
  set isLoading(String value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearData() {
    users = null;
    failure = null;
    notifyListeners();
  }

  UserProvider({this.users});

  void eitherFailureOrGetUserLocal(BuildContext context) async {
    notifyListeners();
    OnboardingRepositoryImpl repository = OnboardingRepositoryImpl(
      remoteDataSource: OnboardingRemoteDataSourceImpl(),
      localDataSource: OnBoardingLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrRegister = await Boarding(repository).callUserLocal();

    failureOrRegister.fold(
      (newFailure) {
        users = null;
        failure = newFailure;
        notifyListeners();
      },
      (newLogin) {
        users = newLogin;
        failure = null;
        notifyListeners();
      },
    );
  }

  void eitherFailureOrLogOut(BuildContext context) async {
    notifyListeners();
    OnboardingRepositoryImpl repository = OnboardingRepositoryImpl(
      remoteDataSource: OnboardingRemoteDataSourceImpl(),
      localDataSource: OnBoardingLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );

    final failureOrRegister = await Boarding(repository).callLogOut();

    failureOrRegister.fold(
      (newFailure) {
        users = null;
        failure = newFailure;
        notifyListeners();
      },
      (newLogin) {
        users = null;
        failure = null;
        notifyListeners();
      },
    );
  }
}
