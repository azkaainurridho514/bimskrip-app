import 'dart:convert';
import 'package:bimskrip/features/dashboard/bussines/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/errors/exceptions.dart';

abstract class OnBoardingLocalDataSource {
  Future<void>? deleteAll();
  Future<void>? cacheUser(User? userToCache);
  Future<void>? updateUser(User? userToCache);
  Future<User> getLastUsers();
  Future<void>? deleteUser();
}

const cachedUsers = 'users';

class OnBoardingLocalDataSourceImpl implements OnBoardingLocalDataSource {
  final SharedPreferences sharedPreferences;
  OnBoardingLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<User> getLastUsers() {
    final jsonString = sharedPreferences.getString(cachedUsers);

    if (jsonString != null) {
      return Future.value(User.fromJson(json.decode(jsonString)));
    } else {
      // throw CacheException();
      return Future.value(
        User(
          id: 0,
          name: '',
          photo: '',
          email: '',
          phone: '',
          dosenPA: null,
          dosenPAID: 0,
          password: "",
          role: null,
          roleId: 0,
        ),
      );
    }
  }

  @override
  Future<void>? updateUser(User? userToCache) async {
    if (userToCache != null) {
      await deleteUser();
      sharedPreferences.setString(
        cachedUsers,
        json.encode(userToCache.toJson()),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? cacheUser(User? userToCache) {
    if (userToCache != null) {
      sharedPreferences.setString(
        cachedUsers,
        json.encode(userToCache.toJson()),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? deleteUser() {
    sharedPreferences.setString(cachedUsers, '');
  }

  @override
  Future<void> deleteAll() async {
    await sharedPreferences.clear();
  }
}
