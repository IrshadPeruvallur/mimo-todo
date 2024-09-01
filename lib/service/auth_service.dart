import 'package:firebase_auth/firebase_auth.dart';
import 'package:memo_todo/authentication/model/auth_model.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<dynamic> registerUser(AuthModel authModel) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: authModel.email!,
        password: authModel.password!,
      );

      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      return e;
    } catch (e) {
      throw Exception('An error occurred during registration: $e');
    }
  }

  Future<dynamic> loginUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      return e;
    } catch (e) {
      throw Exception('An error occurred during login: $e');
    }
  }

  Future<void> logoutUser() async {
    await firebaseAuth.signOut();
  }

  User? get currentUser => firebaseAuth.currentUser;

  Future<dynamic> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return e;
    } catch (e) {
      throw Exception('An error occurred during password reset: $e');
    }
  }
}
