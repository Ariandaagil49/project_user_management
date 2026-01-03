import 'package:belajar_user_management/pertemuan3/data/datasources/user_remote_data_source.dart';
import 'package:belajar_user_management/pertemuan3/data/models/city_model.dart';

import '../models/user_model.dart';
// import '../models/user_model.dart';
abstract class UserRepository {
  Future<List<UserModel>> getUsers();
  Future<UserModel> addUser(UserModel user);
  Future<List<CityModel>> getCities();
}

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource dataSource;
  UserRepositoryImpl({required this.dataSource});

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      return await dataSource.getUsers();
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }

  @override
  Future<UserModel> addUser(UserModel user) async {
    try {
      return await dataSource.addUser(user);
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }

  @override
  Future<List<CityModel>> getCities() async {
    try {
      return await dataSource.getCities();
    } catch (e) {
      throw Exception('Reporsitory error: $e');
    }
  }
}
