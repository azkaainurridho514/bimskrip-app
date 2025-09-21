class ScheduleParams {
  final String userId;
  final String roleId;

  final String mahasiswaId;
  final String tempat;
  final String date;
  ScheduleParams({
    required this.mahasiswaId,
    required this.tempat,
    required this.date,
    required this.userId,
    required this.roleId,
  });
}

class ProgresParams {
  final String userId;
  final String roleId;
  final String dpaId;
  final String nameId;
  final String content;
  final String file;
  ProgresParams({
    required this.nameId,
    required this.content,
    required this.userId,
    required this.roleId,
    required this.dpaId,
    required this.file,
  });
}

class LoginParam {
  final String email;
  final String password;
  LoginParam({required this.email, required this.password});
}

class RegisterParam {
  final String email;
  final String password;
  final String name;
  final String phone;
  final int roleId;
  final int dosenPaId;
  final String? photoPath;

  RegisterParam({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.roleId,
    required this.dosenPaId,
    this.photoPath,
  });
}
