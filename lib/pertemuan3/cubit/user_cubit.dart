import 'package:belajar_user_management/pertemuan3/cubit/user_state.dart';
import 'package:belajar_user_management/pertemuan3/Data/models/city_model.dart';
import 'package:belajar_user_management/pertemuan3/Data/models/user_model.dart';
import 'package:belajar_user_management/pertemuan3/Data/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository repository;
  UserCubit({required this.repository}) : super(UserInitial());

  Future<void> loadData() async {
    emit(UserLoading());

    try {
      final result = await Future.wait([
        repository.getUsers(),
        repository.getCities(),
      ]);
      final users = result[0] as List<UserModel>;
      final cities = result[1] as List<CityModel>;

      emit(UserLoaded(users: users, filteredUsers: users, cities: cities));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  void searchUsers(String query) {
    if (state is UserLoaded) {
      final currentState = state as UserLoaded;
      final filtered = currentState.users.where((user) {
        return user.name.toLowerCase().contains(query.toLowerCase());
      }).toList();

      final finalFiltered = _applyCityFilter(
        filtered,
        currentState.selectedCity,
      );
      emit(
        currentState.copyWith(searchQuery: query, filteredUsers: finalFiltered),
      );
    }
  }

  void filterBycity(String? city) {
    if (state is UserLoaded) {
      final currentState = state as UserLoaded;
      var filtered = currentState.users.where((user) {
        return user.name.toLowerCase().contains(
          currentState.searchQuery.toLowerCase(),
        );
      }).toList();

      filtered = _applyCityFilter(filtered, city);
      emit(currentState.copyWith(selectedCity: city, filteredUsers: filtered));
    }
  }

  Future<void> addUser(UserModel user) async {
    try {
      await repository.addUser(user);
      await loadData();
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  List<UserModel> _applyCityFilter(List<UserModel> users, String? city) {
    if (city == null || city.isEmpty) {
      return users;
    }
    return users.where((user) => user.city == city).toList();
  }
}
