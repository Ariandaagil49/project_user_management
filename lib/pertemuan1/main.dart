import 'package:flutter/material.dart';
// removed erroneous import
import 'pages/user_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //tes aja
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Management - Pertemuan 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      home: const UserListPage(),
    );
  }
}
