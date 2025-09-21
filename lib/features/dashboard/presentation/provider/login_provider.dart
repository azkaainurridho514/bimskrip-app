import 'package:bimskrip/features/dashboard/data/models/login_model.dart';
import 'package:bimskrip/utils/params.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/connection/network_info.dart';
import '../../../../utils/constraint.dart';
import '../../bussines/usecase/boarding.dart';
import '../../data/datasource/local_data_source.dart';
import '../../data/datasource/onboarding_remote_data_source.dart';
import '../../data/repositories/onboarding_repository_impl.dart';
import 'user_provider.dart';

class LoginProvider extends ChangeNotifier {
  LoginAndRegisterModel? login;
  LoginAndRegisterModel? register;
  String _isLoading = '';
  String get isLoading => _isLoading;
  set isLoading(String value) {
    _isLoading = value;
    notifyListeners();
  }

  String _isLoadingRegister = '';
  String get isLoadingRegister => _isLoadingRegister;
  set isLoadingRegister(String value) {
    _isLoadingRegister = value;
    notifyListeners();
  }

  LoginProvider({this.login});

  void eitherFailureOrLogin(
    BuildContext context, {
    required String password,
    required String email,
  }) async {
    _isLoading = kLoading;
    notifyListeners();
    OnboardingRepositoryImpl repository = OnboardingRepositoryImpl(
      remoteDataSource: OnboardingRemoteDataSourceImpl(),
      localDataSource: OnBoardingLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );
    final failureOrRegister = await Boarding(
      repository,
    ).callLogin(params: LoginParam(email: email, password: password));

    failureOrRegister.fold(
      (newFailure) {
        login = null;
        _isLoading = kLoadStop;
        notifyListeners();
      },
      (newLogin) {
        login = newLogin;
        Provider.of<UserProvider>(
          context,
          listen: false,
        ).eitherFailureOrGetUserLocal(context);
        _isLoading = kLoadStop;
        notifyListeners();
      },
    );
  }

  void eitherFailureOrRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
    required int roleId,
    required int dosenPaId,
    required String? photo,
  }) async {
    _isLoadingRegister = kLoading;
    notifyListeners();
    OnboardingRepositoryImpl repository = OnboardingRepositoryImpl(
      remoteDataSource: OnboardingRemoteDataSourceImpl(),
      localDataSource: OnBoardingLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );
    final failureOrRegister = await Boarding(repository).callRegister(
      params: RegisterParam(
        email: email,
        password: password,
        name: name,
        phone: phone,
        roleId: roleId,
        dosenPaId: dosenPaId,
        photoPath: photo,
      ),
    );

    failureOrRegister.fold(
      (newFailure) {
        register = null;
        _isLoadingRegister = kLoadStop;
        notifyListeners();
      },
      (newLogin) {
        register = newLogin;
        _isLoadingRegister = kLoadStop;
        notifyListeners();
      },
    );
  }
}
