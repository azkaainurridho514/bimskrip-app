import 'package:dartz/dartz.dart';

import '../../../../utils/connection/network_info.dart';
import '../../../../utils/constraint.dart';
import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/errors/failure.dart';
import '../../bussines/repositories/dashboard_repository.dart';
import '../datasource/dashboard_remote_data_source.dart';
import '../datasource/local_data_source.dart';
import '../models/dashboard_model.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final OnBoardingLocalDataSource localDataSource;
  DashboardRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, DashboardModel>> getDashboard() async {
    if (await networkInfo.isConnected!) {
      try {
        var remoteNetwork = await remoteDataSource.getDashboard();
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
