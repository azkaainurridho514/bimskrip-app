import 'package:bimskrip/utils/errors/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../utils/connection/network_info.dart';
import '../../../../utils/constraint.dart';
import '../../../../utils/errors/exceptions.dart';
import '../../bussines/repositories/mahasiswa_by_dosen_repository.dart';

import '../datasource/local_data_source.dart';
import '../datasource/mahasiswa_by_dosen_remote_data_source .dart';
import '../models/mahasiswa_by_dosen_model.dart';

class MahasiswaByDosenRepositoryImpl implements MahasiswaByDosenRepository {
  final MahasiswaByDosenRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final OnBoardingLocalDataSource localDataSource;
  MahasiswaByDosenRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, MahasiswaByDosenModel>> getAllMahasiswaByDosen({
    required int id,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        var remoteNetwork = await remoteDataSource.getMahasiswaByDosen(id: id);
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
