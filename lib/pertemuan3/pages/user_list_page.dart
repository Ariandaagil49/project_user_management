import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/user_model.dart';
import 'add_user_page.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar User'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<UserCubit>().loadData(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            context.read<UserCubit>().loadData();
            return const Center(child: CircularProgressIndicator());
          }

          if (State is UserLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Memuat data...'),
                ],
              ),
            );
          }

          if (state is UserError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Oops!', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(state.message, textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => context.read<UserCubit>().loadData(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          if (state is UserLoaded) {
            return RefreshIndicator(
              onRefresh: () => context.read<UserCubit>().loadData(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      onChanged: (query) {
                        context.read<UserCubit>().searchUsers(query);
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari berdasarkan nama...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: state.searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  context.read<UserCubit>().searchUsers('');
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButtonFormField<String>(
                      initialValue: state.selectedCity,
                      decoration: InputDecoration(
                        labelText: 'Filter Kota',
                        prefixIcon: const Icon(Icons.location_city),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[10],
                      ),
                      items: [
                        const DropdownMenuItem<String>(
                          value: null,
                          child: Text('Semua Kota'),
                        ),
                        ...state.cities.map(
                          (city) => DropdownMenuItem<String>(
                            value: city.name,
                            child: Text(city.name),
                          ),
                        ),
                      ],
                      onChanged: (city) {
                        context.read<UserCubit>().filterBycity(city);
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          'Menampilkan ${state.filteredUsers.length} dari ${state.users.length} user',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: state.filteredUsers.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Tidak ada user ditemukan',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: state.filteredUsers.length,
                            itemBuilder: (context, index) {
                              return _buildUserCard(state.filteredUsers[index]);
                            },
                          ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final cubit = context.read<UserCubit>();
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddUserPage(cubit: cubit)),
          );
          if (result == true) {
            cubit.loadData();
          }
        },
        tooltip: 'Tambah User',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildUserCard(UserModel user) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.email_outlined, 'Email', user.email),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.phone_outlined, 'Telepon', user.phoneNumber),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.location_city_outlined, 'Kota', user.city),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.location_on_outlined, 'Alamat', user.address),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              Text(value, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
}
