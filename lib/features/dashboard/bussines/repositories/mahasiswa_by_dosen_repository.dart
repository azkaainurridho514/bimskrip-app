import 'package:bimskrip/utils/errors/failure.dart';

import 'package:dartz/dartz.dart';

import '../../data/models/mahasiswa_by_dosen_model.dart';

abstract class MahasiswaByDosenRepository {
  Future<Either<Failure, MahasiswaByDosenModel>> getAllMahasiswaByDosen({
    required int id,
  });
}
