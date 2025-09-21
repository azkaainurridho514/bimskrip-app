import 'package:dartz/dartz.dart';

import '../../../../utils/errors/failure.dart';
import '../../data/models/dashboard_model.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardModel>> getDashboard();
}
