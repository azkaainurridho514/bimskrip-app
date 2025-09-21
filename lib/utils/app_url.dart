class AppUrl {
  // static const String baseUrl = 'http://192.168.245.114:8080/api';
  static const String baseUrl = 'http://192.168.100.6:8080/api';
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
  static const String fetchData = '$baseUrl/data';
  static const String updateProfile = '$baseUrl/profile/update';
  static const String deleteAccount = '$baseUrl/account/delete';
  static const String allMahasiswa = '$baseUrl/mahasiswa';
  static const String allMahasiswaByDosen = '$baseUrl/users';
  static const String allDosen = '$baseUrl/dosen';
  static const String allStatusName = '$baseUrl/status-names';
  static const String allProgressName = '$baseUrl/progress-names';
  static const String allProgresses = '$baseUrl/progress/list';
  static const String allSchedule = '$baseUrl/schedule/list';
  static const String allTodaySchedule = '$baseUrl/schedule/today';
  static const String createProgress = '$baseUrl/progress/create';
  static const String createSchedule = '$baseUrl/schedule/create';
  static const String updateStatusProgress = '$baseUrl/progress/status';
  static const String dashboard = '$baseUrl/dashboard';
}
