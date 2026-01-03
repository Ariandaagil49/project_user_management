import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/user_model.dart';

class AddUserPageWithBlocV1 extends StatefulWidget {
  const AddUserPageWithBlocV1({super.key});

  @override
  State<AddUserPageWithBlocV1> createState() => _AddUserPageWithBlocV1State();
}

class _AddUserPageWithBlocV1State extends State<AddUserPageWithBlocV1> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  String? _selectedCity;
  List<dynamic> _cities = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final currentState = context.read<UserCubit>().state;
    if (currentState is UserLoaded && _cities.isEmpty) {
      _cities = currentState.cities;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah User (BlocListener V1)'),
        centerTitle: true,
      ),
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }

          if (state is UserLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('User berhasil ditambahkan'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context, true);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildNameField(),
                const SizedBox(height: 16),
                _buildEmailField(),
                const SizedBox(height: 16),
                _buildPhoneField(),
                const SizedBox(height: 16),
                _buildCityDropdown(),
                const SizedBox(height: 16),
                _buildAddressField(),
                const SizedBox(height: 32),
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    final isLoading = state is UserLoading;
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Tambah User',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newUser = UserModel(
        id: '',
        name: _nameController.text,
        email: _emailController.text,
        phoneNumber: _phoneController.text,
        address: _addressController.text,
        city: _selectedCity!,
      );
      context.read<UserCubit>().addUser(newUser);
    }
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Nama',
        hintText: 'Masukkan nama lengkap',
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Nama tidak boleh kosong';
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'contoh@email.com',
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Email tidak boleh kosong';
        if (!value.contains('@')) return 'Email tidak valid';
        return null;
      },
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: 'Nomor Telepon',
        hintText: '08123456789',
        prefixIcon: Icon(Icons.phone),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nomor telepon tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _buildCityDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCity,
      decoration: const InputDecoration(
        labelText: 'Kota',
        prefixIcon: Icon(Icons.location_city),
        border: OutlineInputBorder(),
      ),
      items: _cities.map((city) {
        return DropdownMenuItem<String>(
          value: city.name,
          child: Text(city.name),
        );
      }).toList(),
      onChanged: (value) => setState(() => _selectedCity = value),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Pilih kota';
        return null;
      },
    );
  }

  Widget _buildAddressField() {
    return TextFormField(
      controller: _addressController,
      maxLines: 3,
      decoration: const InputDecoration(
        labelText: 'Alamat',
        hintText: 'Masukkan alamat lengkap',
        prefixIcon: Icon(Icons.location_on),
        border: OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Alamat tidak boleh kosong';
        return null;
      },
    );
  }
}
