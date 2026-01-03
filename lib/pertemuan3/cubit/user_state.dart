import 'package:belajar_user_management/pertemuan3/data/models/user_model.dart';
// import 'package:belajar_user_management/pertemuan3/cubit/user_state.dart';
import 'package:belajar_user_management/pertemuan3/data/models/city_model.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<UserModel> users;
  final List<UserModel> filteredUsers;
  final List<CityModel> cities;
  final String searchQuery;
  final String? selectedCity;
  const UserLoaded({
    required this.users,
    required this.filteredUsers,
    required this.cities,
    this.searchQuery = '',
    this.selectedCity,
  });

  @override
  List<Object?> get props => [
    users,
    filteredUsers,
    cities,
    searchQuery,
    selectedCity,
  ];

  UserLoaded copyWith({
    List<UserModel>? users,
    List<UserModel>? filteredUsers,
    List<CityModel>? cities,
    String? searchQuery,
    String? selectedCity,
  }) {
    return UserLoaded(
      users: users ?? this.users,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      cities: cities ?? this.cities,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCity: selectedCity,
    );
  }
}

class UserError extends UserState {
  final String message;
  const UserError({required this.message});

  @override
  List<Object?> get props => [message];
}
