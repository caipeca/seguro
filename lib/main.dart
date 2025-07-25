import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seguro/presentation/bloc/auth_bloc.dart';
import 'package:seguro/presentation/pages/auth/login_page.dart';
import 'package:seguro/presentation/pages/auth/register_page.dart';
import 'package:seguro/presentation/pages/dashboard/home_page.dart';

import 'app.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth/auth_repository.dart';
import 'domain/usecases/login_user.dart';
import 'domain/usecases/register_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<AuthRepository>(
        create: (context) => AuthRepositoryImpl(
          AuthRemoteDataSource(FirebaseAuth.instance),
        ),
      ),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            loginUser: LoginUser(context.read<AuthRepository>()),
            registerUser: RegisterUser(context.read<AuthRepository>()),
          ),
        ),
      ],
      child: App()
    ),
  ));
}