import 'package:seguro/domain/entities/user_entity.dart';

abstract class AuthRepository {
Future<UserEntity> login(String email, String password);
Future<UserEntity> register(String email, String password, String name);
Future<void> logout();
Future<UserEntity?> getCurrentUser();
}