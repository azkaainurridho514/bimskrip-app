import 'package:bimskrip/features/dashboard/bussines/repositories/progres_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../utils/errors/failure.dart';
import '../../../../utils/params.dart';
import '../../data/models/progres_model.dart';

class GetAllProgress {
  final ProgresRepository progresRepository;
  const GetAllProgress(this.progresRepository);
  Future<Either<Failure, ProgresModel>> executeGetAllProgress({
    required ProgresParams params,
  }) async => await progresRepository.getAllProgress(params: params);
  Future<Either<Failure, ProgresCreateModel>> executeGetCreateProgress({
    required ProgresParams params,
  }) async => await progresRepository.createProgress(params: params);
  Future<Either<Failure, ProgresCreateModel>> executeGetUpdateProgress({
    required String statusId,
    required String id,
    required String comment,
  }) async => await progresRepository.updateProgress(
    statusId: statusId,
    id: id,
    comment: comment,
  );
  Future<Either<Failure, ProgresModel>> executeGetDeleteProgress({
    required ProgresParams params,
  }) async => await progresRepository.deleteProgress(params: params);
}
