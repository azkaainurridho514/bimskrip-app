import 'package:bimskrip/utils/errors/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../utils/connection/network_info.dart';
import '../../../../utils/constraint.dart';
import '../../../../utils/errors/exceptions.dart';
import '../../bussines/repositories/dropdown_repository.dart';
import '../datasource/dropdown_remote_data_source.dart';
import '../datasource/local_data_source.dart';
import '../models/dropdown_model.dart';

class DropdownRepositoryImpl implements DropdownRepository {
  final DropdownRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final OnBoardingLocalDataSource localDataSource;
  DropdownRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, DropdownModel>> getAllMahasiswa() async {
    if (await networkInfo.isConnected!) {
      try {
        var remoteNetwork = await remoteDataSource.getMahasiswa();
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
  Future<Either<Failure, DropdownModel>> getAllDosen() async {
    if (await networkInfo.isConnected!) {
      try {
        var remoteNetwork = await remoteDataSource.getDosen();
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
