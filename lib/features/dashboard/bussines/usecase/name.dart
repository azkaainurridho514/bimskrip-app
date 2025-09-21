import 'package:dartz/dartz.dart';

import '../../../../utils/errors/failure.dart';
import '../../data/models/name_model.dart';
import '../repositories/name_repository.dart';

class GetName {
  final NameRepository repo;
  const GetName(this.repo);
  Future<Either<Failure, NameModel>> executeGetStatusName() async =>
      await repo.getAllStatusName();
  Future<Either<Failure, NameModel>> executeGetProgressName() async =>
      await repo.getAllProgressName();
}
