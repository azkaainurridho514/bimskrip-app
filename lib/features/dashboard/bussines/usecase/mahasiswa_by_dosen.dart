import 'package:dartz/dartz.dart';

import '../../../../utils/errors/failure.dart';
import '../../data/models/mahasiswa_by_dosen_model.dart';
import '../repositories/mahasiswa_by_dosen_repository.dart';

class GetMahasiswaByDosen {
  final MahasiswaByDosenRepository repo;
  const GetMahasiswaByDosen(this.repo);
  Future<Either<Failure, MahasiswaByDosenModel>> executeGetMahasiswaByDosen({
    required int id,
  }) async => await repo.getAllMahasiswaByDosen(id: id);
}
