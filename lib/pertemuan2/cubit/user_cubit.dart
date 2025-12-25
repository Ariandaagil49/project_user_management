import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import 'user_state.dart';
// part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  Future<void> loadUsers() async {
    emit(UserLoading());
    try {
      final response = await http.get(
        Uri.parse(
          'https://627e360ab75a25d3f3b37d5a.mockapi.io/api/v1/accurate/user',
        ),
        headers: {'Content-Type': 'application/json'},
      );
      debugPrint('┌─────────────────────────────────────────────────────────');
      debugPrint('│ 🌐 API REQUEST');
      debugPrint('├─────────────────────────────────────────────────────────');
      debugPrint('│ Method: GET');
      debugPrint(
        '│ URL: https://627e360ab75a25d3f3b37d5a.mockapi.io/api/v1/accurate/user',
      );
      debugPrint('├─────────────────────────────────────────────────────────');
      debugPrint('│ 📥 API RESPONSE');
      debugPrint('├─────────────────────────────────────────────────────────');
      debugPrint('│ Status Code: ${response.statusCode}');
      debugPrint('│ Body: ${response.body}');
      debugPrint('└─────────────────────────────────────────────────────────');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final List<UserModel> users = jsonList
            .map((json) => UserModel.fromJson(json))
            .toList();
        emit(UserLoaded(users: users));
      } else {
        emit(
          UserError(
            message: 'Gagal memuat data. Status: ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      emit(UserError(message: 'Terjadi kesalahan: $e'));
    }
  }

  Future<void> refreshUsers() async {
    await loadUsers();
  }
}
