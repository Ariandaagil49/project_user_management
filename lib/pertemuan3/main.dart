import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'data/datasources/user_remote_data_source.dart';
import 'data/repositories/user_repository.dart';
import 'cubit/user_cubit.dart';
import 'pages/user_list_page.dart';

void main() {
  final httpClient = http.Client();

  final userDataSource = UserRemoteDataSourceImpl(client: httpClient);

  final userRepository = UserRepositoryImpl(dataSource: userDataSource);

  final userCubit = UserCubit(repository: userRepository);

  runApp(MyApp(userCubit: userCubit));
}

class MyApp extends StatelessWidget {
  final UserCubit userCubit;

  const MyApp({super.key, required this.userCubit});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Management - Pertemuan 3',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      home: BlocProvider.value(value: userCubit, child: const UserListPage()),
    );
  }
}
