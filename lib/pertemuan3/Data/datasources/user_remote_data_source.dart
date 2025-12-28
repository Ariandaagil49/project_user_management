import 'dart:convert';
import 'package:belajar_user_management/pertemuan3/Data/models/city_model.dart';
import 'package:belajar_user_management/pertemuan3/Data/models/user_model.dart';
import 'package:belajar_user_management/pertemuan3/config/api_config.dart';
import 'package:belajar_user_management/pertemuan3/config/api_longger.dart';
import 'package:http/http.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
  Future<UserModel> addUser(UserModel user);
  Future<List<CityModel>> getCities();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await client.get(
        Uri.parse(ApiConfig.userUrl),
        headers: {'content-Type': 'application/json'},
      );

      ApiLogger.logComplete(
        method: 'GET',
        url: ApiConfig.userUrl,
        response: response,
      );

      if (response.statuscode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting users: $e');
    }
  }

  @override
  Future<UserModel> addUser(UserModel user) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConfig.userUrl),
        headers: {'content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );

      ApiLogger.logComplete(
        method: 'POST',
        url: ApiConfig.userUrl,
        response: response,
        requestBody: json.encode(user.toJson()),
      );

      if (response.statusCode == 201 || response.statuscode == 200) {
        return UserModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to add user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding user: $e');
    }
  }

  @override
  Future<List<CityModel>> getCities() async {
    try {
      final response = await client.get(
        Uri.parse(ApiConfig.cityUrl),
        headers: {'content-Type': 'application/json'},
      );

      ApiLogger.logComplete(
        method: 'GET',
        url: ApiConfig.cityUrl,
        response: response,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => CityModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load cities: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting cities: $e');
    }
  }
}
