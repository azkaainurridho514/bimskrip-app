import 'package:bimskrip/features/dashboard/bussines/entities/user.dart';
import 'package:bimskrip/utils/params.dart';
import 'package:dartz/dartz.dart';

import '../../../../utils/errors/failure.dart';
import '../../data/models/login_model.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, LoginAndRegisterModel>> login({
    required LoginParam params,
  });
  Future<Either<Failure, LoginAndRegisterModel>> register({
    required RegisterParam params,
  });
  Future<Either<Failure, User>> callUserLocal();
  Future<Either<Failure, dynamic>> callLogOut();
}
