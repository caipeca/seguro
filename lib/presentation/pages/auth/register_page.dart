import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seguro/presentation/pages/auth/login_page.dart';

import '../../bloc/auth_bloc.dart';

class RegisterPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.shield_outlined, size: 72,),
                    SizedBox(height: 16,),
                    Text('Registrar', style: theme.textTheme.headlineLarge,),
                    SizedBox(height: 16,),
                    Text('Por favor insira os dados', style: theme.textTheme.bodyMedium,),
                    SizedBox(height: 24,),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Nome',border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                    ),
                    SizedBox(height: 16,),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'E-mail',border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                    ),
                    SizedBox(height: 16,),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Senha',  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                    ),
                    SizedBox(height: 16,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(RegisterRequested(
                            _emailController.text,
                            _passwordController.text,
                            _nameController.text,
                          ));
                        },
                        child: Text('Registrar'),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                      child: Text('Já tem conta? Faça login'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
