import 'package:dartz/dartz.dart';

import '../../../../utils/errors/failure.dart';
import '../../../../utils/params.dart';
import '../../data/models/schedule_model.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, ScheduleModel>> getAllSchedules({
    required ScheduleParams params,
  });
  Future<Either<Failure, ScheduleModel>> getTodaySchedules({
    required ScheduleParams params,
  });
  Future<Either<Failure, ScheduleModel>> getCreateSchedules({
    required ScheduleParams params,
  });
}
