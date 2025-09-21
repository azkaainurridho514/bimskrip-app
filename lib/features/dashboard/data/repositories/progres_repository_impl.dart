import 'package:bimskrip/features/dashboard/data/models/progres_model.dart';
import 'package:bimskrip/utils/errors/failure.dart';
import 'package:bimskrip/utils/params.dart';
import 'package:dartz/dartz.dart';
import '../../../../utils/connection/network_info.dart';
import '../../../../utils/constraint.dart';
import '../../../../utils/errors/exceptions.dart';
import '../../bussines/repositories/progres_repository.dart';
import '../datasource/local_data_source.dart';
import '../datasource/progres_remote_data_source.dart';

class ProgresRepositoryImpl implements ProgresRepository {
  final ProgresRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final OnBoardingLocalDataSource localDataSource;
  ProgresRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, ProgresModel>> getAllProgress({
    required ProgresParams params,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        var remoteNetwork = await remoteDataSource.getProgress(params: params);
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
  Future<Either<Failure, ProgresCreateModel>> createProgress({
    required ProgresParams params,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        var remoteNetwork = await remoteDataSource.createProgress(
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
  Future<Either<Failure, ProgresCreateModel>> updateProgress({
    required String statusId,
    required String id,
    required String comment,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        var remoteNetwork = await remoteDataSource.updateProgress(
          statusId: statusId,
          id: id,
          comment: comment,
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
  Future<Either<Failure, ProgresModel>> deleteProgress({
    required ProgresParams params,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        var remoteNetwork = await remoteDataSource.deleteProgress(
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
