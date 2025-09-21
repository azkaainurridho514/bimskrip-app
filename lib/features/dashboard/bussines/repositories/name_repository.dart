import 'package:dartz/dartz.dart';

import '../../../../utils/errors/failure.dart';
import '../../data/models/name_model.dart';

abstract class NameRepository {
  Future<Either<Failure, NameModel>> getAllStatusName();
  Future<Either<Failure, NameModel>> getAllProgressName();
}
