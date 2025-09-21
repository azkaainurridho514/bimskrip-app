import 'package:bimskrip/utils/errors/failure.dart';
import 'package:bimskrip/utils/params.dart';
import 'package:dartz/dartz.dart';
import '../../../../utils/connection/network_info.dart';
import '../../../../utils/constraint.dart';
import '../../../../utils/errors/exceptions.dart';
import '../../bussines/repositories/schedule_repository.dart';
import '../datasource/local_data_source.dart';
import '../datasource/schedule_remote_data_source.dart';
import '../models/schedule_model.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final OnBoardingLocalDataSource localDataSource;
  ScheduleRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, ScheduleModel>> getAllSchedules({
    required ScheduleParams params,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        var remoteNetwork = await remoteDataSource.getSchedules(params: params);
        if (remoteNetwork.statusCode.toString() == "200") {
          return Right(remoteNetwork);
        } else {
          return Left(ServerFailure(errorMessage: kResServerException));
        }
      } on ServerException {
        return Left(ServerFailure(errorMessage: kResServerException));
      }
    } else {
      return Left(ServerFailure(errorMessage: kResNetworkNotFound));
    }
  }

  @override
  Future<Either<Failure, ScheduleModel>> getTodaySchedules({
    required ScheduleParams params,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        var remoteNetwork = await remoteDataSource.getTodaySchedules(
          params: params,
        );
        if (remoteNetwork.statusCode.toString() == "200") {
          return Right(remoteNetwork);
        } else {
          return Left(ServerFailure(errorMessage: kResServerException));
        }
      } on ServerException {
        return Left(ServerFailure(errorMessage: kResServerException));
      }
    } else {
      return Left(ServerFailure(errorMessage: kResNetworkNotFound));
    }
  }

  @override
  Future<Either<Failure, ScheduleModel>> getCreateSchedules({
    required ScheduleParams params,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        var remoteNetwork = await remoteDataSource.createSchedules(
          params: params,
        );
        if (remoteNetwork.statusCode.toString() == "200") {
          return Right(remoteNetwork);
        } else {
          return Left(ServerFailure(errorMessage: kResServerException));
        }
      } on ServerException {
        return Left(ServerFailure(errorMessage: kResServerException));
      }
    } else {
      return Left(ServerFailure(errorMessage: kResNetworkNotFound));
    }
  }
}
