// lib/auth/presentation/pages/login_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seguro/presentation/bloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
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
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shield_outlined, size: 72,),
                  SizedBox(height: 16,),
                  Text('SEGURO', style: theme.textTheme.headlineLarge,),
                  SizedBox(height: 16,),
                  Text('Please sign in to continue', style: theme.textTheme.bodyMedium,),
                  SizedBox(height: 24,),
                  TextField(controller: _emailController, decoration: InputDecoration(labelText: 'E-mail')),
                  TextField(controller: _passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Senha')),
                  SizedBox(height: 24,),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(LoginRequested(
                          _emailController.text,
                          _passwordController.text,
                        ));
                      },
                      child: Text('Entrar'),
                    ),
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?", style: theme.textTheme.bodySmall,),
                      SizedBox(width: 4,),
                      GestureDetector(
                        onTap: (){},
                        child: Text('Sign up', style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),),
                      )
                    ],
                  )
                  // Link para RegisterPage...
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}