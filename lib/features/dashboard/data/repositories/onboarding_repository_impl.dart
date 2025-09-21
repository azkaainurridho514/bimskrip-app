import 'package:bimskrip/features/dashboard/bussines/entities/user.dart';
import 'package:bimskrip/utils/params.dart';
import 'package:dartz/dartz.dart';

import '../../../../utils/connection/network_info.dart';
import '../../../../utils/constraint.dart';
import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/errors/failure.dart';
import '../../bussines/repositories/onboarding_repository.dart';
import '../datasource/local_data_source.dart';
import '../datasource/onboarding_remote_data_source.dart';
import '../models/login_model.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingRemoteDataSource remoteDataSource;
  final OnBoardingLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  OnboardingRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, LoginAndRegisterModel>> login({
    required LoginParam params,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final remote = await remoteDataSource.login(params: params);
        if (remote.statusCode.toString() == "200") {
          localDataSource.deleteUser();
          localDataSource.deleteAll();
          localDataSource.cacheUser(remote.data);
        }
        return Right(remote);
      } on ServerException {
        return Left(ServerFailure(errorMessage: kResServerException));
      }
    } else {
      return Left(ServerFailure(errorMessage: kResNetworkNotFound));
    }
  }

  @override
  Future<Either<Failure, LoginAndRegisterModel>> register({
    required RegisterParam params,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final remote = await remoteDataSource.register(params: params);
        return Right(remote);
        // if (remote.statusCode.toString() == kResDataAvailable) {
        // } else {
        //   return Left(ServerFailure(errorMessage: remote.message));
        // }
      } on ServerException {
        return Left(ServerFailure(errorMessage: kResServerException));
      }
    } else {
      return Left(ServerFailure(errorMessage: kResNetworkNotFound));
    }
  }

  @override
  Future<Either<Failure, User>> callUserLocal() async {
    try {
      final remote = await localDataSource.getLastUsers();
      return Right(remote);
    } on ServerException {
      return Left(ServerFailure(errorMessage: kResServerException));
    }
  }

  @override
  Future<Either<Failure, dynamic>> callLogOut() async {
    try {
      await localDataSource.deleteUser();
      await localDataSource.deleteAll();
      return Right("Berhasil Logout");
    } on ServerException {
      return Left(ServerFailure(errorMessage: kResServerException));
    }
  }
}
