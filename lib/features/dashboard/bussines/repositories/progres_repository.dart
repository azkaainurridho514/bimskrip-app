import 'package:bimskrip/features/dashboard/bussines/entities/progres.dart';
import 'package:bimskrip/utils/errors/failure.dart';
import '../../../../utils/params.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/progres_model.dart';

abstract class ProgresRepository {
  Future<Either<Failure, ProgresModel>> getAllProgress({
    required ProgresParams params,
  });
  Future<Either<Failure, ProgresCreateModel>> createProgress({
    required ProgresParams params,
  });
  Future<Either<Failure, ProgresCreateModel>> updateProgress({
    required String statusId,
    required String id,
    required String comment,
  });
  Future<Either<Failure, ProgresModel>> deleteProgress({
    required ProgresParams params,
  });
}
