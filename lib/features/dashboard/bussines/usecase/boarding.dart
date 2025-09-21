import 'package:bimskrip/features/dashboard/bussines/entities/user.dart';
import 'package:bimskrip/utils/params.dart';
import 'package:dartz/dartz.dart';

import '../../../../utils/errors/failure.dart';
import '../../data/models/login_model.dart';
import '../repositories/onboarding_repository.dart';

class Boarding {
  final OnboardingRepository repository;
  Boarding(this.repository);
  Future<Either<Failure, LoginAndRegisterModel>> callLogin({
    required LoginParam params,
  }) async {
    return await repository.login(params: params);
  }

  Future<Either<Failure, LoginAndRegisterModel>> callRegister({
    required RegisterParam params,
  }) async {
    return await repository.register(params: params);
  }

  Future<Either<Failure, User>> callUserLocal() async {
    return await repository.callUserLocal();
  }

  Future<Either<Failure, dynamic>> callLogOut() async {
    return await repository.callLogOut();
  }
}
