import 'package:bimskrip/features/dashboard/bussines/entities/schedule.dart';
import 'package:bimskrip/features/dashboard/bussines/repositories/progres_repository.dart';
import 'package:bimskrip/features/dashboard/data/models/schedule_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../utils/errors/failure.dart';
import '../../../../utils/params.dart';
import '../../data/models/progres_model.dart';
import '../repositories/schedule_repository.dart';

class GetAllSchedule {
  final ScheduleRepository repo;
  const GetAllSchedule(this.repo);
  Future<Either<Failure, ScheduleModel>> executeGetAllSchedule({
    required ScheduleParams params,
  }) async => await repo.getAllSchedules(params: params);
  Future<Either<Failure, ScheduleModel>> executeGetTodaySchedule({
    required ScheduleParams params,
  }) async => await repo.getTodaySchedules(params: params);
  Future<Either<Failure, ScheduleModel>> executeGetCreateSchedule({
    required ScheduleParams params,
  }) async => await repo.getCreateSchedules(params: params);
}
