import 'package:bimskrip/features/dashboard/bussines/entities/progres.dart';
import 'package:bimskrip/utils/errors/failure.dart';
import '../../../../utils/params.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/dropdown_model.dart';
import '../../data/models/login_model.dart';
import '../../data/models/progres_model.dart';

abstract class DropdownRepository {
  Future<Either<Failure, DropdownModel>> getAllMahasiswa();
  Future<Either<Failure, DropdownModel>> getAllDosen();
}
