import 'package:dartz/dartz.dart';

import '../../../../utils/errors/failure.dart';
import '../../data/models/dropdown_model.dart';

import '../repositories/dropdown_repository.dart';

class GetDropdown {
  final DropdownRepository repo;
  const GetDropdown(this.repo);
  Future<Either<Failure, DropdownModel>> executeGetMahasiswa() async =>
      await repo.getAllMahasiswa();
  Future<Either<Failure, DropdownModel>> executeGetDosen() async =>
      await repo.getAllDosen();
}
