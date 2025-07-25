import 'package:seguro/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSource{
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSource(this._firebaseAuth);
  Future<UserModel> login(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return UserModel.fromFirebase(userCredential.user!);
  }

  Future<UserModel> register(String email, String password, String name) async{
    try {
      final userRegister = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await userRegister.user!.updateDisplayName(name);

      final updatedUser = _firebaseAuth.currentUser!;
      await updatedUser.reload();

      return UserModel.fromFirebase(_firebaseAuth.currentUser!);
    }on FirebaseAuthException catch (e) {
      throw Exception("Erro ao registrar: ${e.message}");
    }
  }
// Implemente register, logout, getCurrentUser...
}