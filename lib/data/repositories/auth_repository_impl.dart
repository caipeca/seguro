import 'package:seguro/data/datasources/auth_remote_data_source.dart';
import 'package:seguro/domain/entities/user_entity.dart';
import 'package:seguro/domain/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity?> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> login(String email, String password) async {
    // TODO: implement login
    return await remoteDataSource.login(email, password );
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> register(String email, String password, String name) {
    // TODO: implement register
    throw UnimplementedError();
  }

}