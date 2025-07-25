import 'package:seguro/domain/entities/user_entity.dart';
import 'package:seguro/domain/repositories/auth/auth_repository.dart';

class RegisterUser{
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<UserEntity> call(String email, String password, String name) async {
    return await repository.register(email, password, name);
  }
}