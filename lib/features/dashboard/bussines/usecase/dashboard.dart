import 'package:dartz/dartz.dart';

import '../../../../utils/errors/failure.dart';
import '../../data/models/dashboard_model.dart';
import '../repositories/dashboard_repository.dart';

class GetDashboard {
  final DashboardRepository repo;
  const GetDashboard(this.repo);
  Future<Either<Failure, DashboardModel>> executeDashboard() async =>
      await repo.getDashboard();
}
